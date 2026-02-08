import { Component, inject, signal, OnInit, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatTabsModule, MatTabGroup } from '@angular/material/tabs';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatExpansionModule } from '@angular/material/expansion';

import { AssetService } from '../../shared/services/asset.service';
import { NotificationService } from '../../shared/services/notification.service';
import { VocabularyService, VocabularyOptions } from '../../shared/services/vocabulary.service';
import {
  AssetFormData,
  AssetInput,
  convertFormDataToAssetInput,
  validateAssetFormData
} from '../../shared/models/asset-input';
import {
  ASSET_TYPES,
  DEFAULT_ASSET_TYPE,
  MLMetadata
} from '../../shared/models/ml-metadata';
import {
  DATA_ADDRESS_TYPES,
  STORAGE_TYPES,
  HttpDataAddress,
  AmazonS3DataAddress,
  DataSpacePrototypeStoreAddress,
  DataAddress
} from '../../shared/models/data-address';

/**
 * Input Field Configuration Interface
 * Used to define expected inputs for HTTP model execution
 */
interface InputField {
  name: string;
  type: 'string' | 'int' | 'float' | 'number' | 'boolean';
  required: boolean;
  description?: string;
  min?: number;
  max?: number;
}

/**
 * Asset Create Component
 * 
 * Allows users to create new AI assets with:
 * - Basic asset information (id, name, version, description)
 * - ML metadata from JS_Pionera_Ontology
 * - Storage configuration (HTTP, S3, or DataSpacePrototypeStore)
 */
@Component({
  selector: 'app-asset-create',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    MatCardModule,
    MatTabsModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatIconModule,
    MatSlideToggleModule,
    MatCheckboxModule,
    MatExpansionModule
  ],
  templateUrl: './asset-create.component.html',
  styleUrl: './asset-create.component.scss'
})
export class AssetCreateComponent implements OnInit {
  private assetService = inject(AssetService);
  private notificationService = inject(NotificationService);
  private router = inject(Router);
  private vocabularyService = inject(VocabularyService);
  
  // ViewChild to control tab navigation
  @ViewChild('tabGroup') tabGroup!: MatTabGroup;
  
  // Vocabulary options loaded from JS_Pionera_Ontology
  vocabularyOptions = signal<VocabularyOptions>({
    task: [],
    subtask: [],
    algorithm: [],
    library: [],
    framework: [],
    software: [],
    format: []
  });
  
  // Track if HTTP Data fields are complete
  httpDataFieldsCompleted = signal(false);
  
  // Track if Model Input Schema warning was shown
  inputSchemaWarningShown = false;
  
  // Expose constants for template
  readonly DATA_ADDRESS_TYPES = DATA_ADDRESS_TYPES;

  // Asset type options
  assetTypes = Object.entries(ASSET_TYPES);
  
  // Storage type options
  storageTypes = STORAGE_TYPES;
  
  // Basic asset information
  id = '';
  name = '';
  version = '1.0';
  contenttype = 'application/octet-stream';
  assetType = DEFAULT_ASSET_TYPE;
  shortDescription = '';
  description = '';
  keywords = '';
  byteSize = '';
  format = '';
  
  // ML Metadata
  mlMetadata: MLMetadata = {
    task: [],
    subtask: [],
    algorithm: [],
    library: [],
    framework: [],
    software: [],
    format: ''
  };
  
  // Storage configuration
  storageTypeId: string = DATA_ADDRESS_TYPES.httpData;
  
  httpDataAddress: HttpDataAddress = {
    '@type': 'HttpData',
    type: 'HttpData',
    name: '',
    baseUrl: '',
    path: '',
    authKey: '',
    authCode: '',
    secretName: '',
    contentType: '',
    proxyBody: 'false',
    proxyPath: 'false',
    proxyQueryParams: 'false',
    proxyMethod: 'false'
  };
  
  amazonS3DataAddress: AmazonS3DataAddress = {
    '@type': 'AmazonS3',
    type: 'AmazonS3',
    region: '',
    bucketName: '',
    accessKeyId: '',
    secretAccessKey: '',
    endpointOverride: '',
    keyPrefix: '',
    folderName: ''
  };
  
  dataSpacePrototypeStoreAddress: DataSpacePrototypeStoreAddress = {
    '@type': 'DataSpacePrototypeStore',
    type: 'DataSpacePrototypeStore',
    folder: ''
  };

  // HTTP Model Input Configuration (for executable models)
  httpInputFields: InputField[] = [];
  
  // Input Templates
  inputTemplates = {
    '': { name: '-- Start from scratch --', fields: [] },
    'tabular': {
      name: 'Tabular Data (multiple numbers)',
      fields: [
        { name: 'feature_1', type: 'float' as const, required: true, description: 'First numeric feature', min: 0, max: 10 },
        { name: 'feature_2', type: 'float' as const, required: true, description: 'Second numeric feature', min: 0, max: 10 },
        { name: 'feature_3', type: 'float' as const, required: true, description: 'Third numeric feature', min: 0, max: 10 },
        { name: 'feature_4', type: 'float' as const, required: true, description: 'Fourth numeric feature', min: 0, max: 10 }
      ]
    },
    'text': {
      name: 'Text Input (single text field)',
      fields: [
        { name: 'text', type: 'string' as const, required: true, description: 'Input text to analyze' }
      ]
    },
    'image': {
      name: 'Image Input (base64)',
      fields: [
        { name: 'image', type: 'string' as const, required: true, description: 'Base64 encoded image' },
        { name: 'image_format', type: 'string' as const, required: false, description: 'Image format (jpg, png)' }
      ]
    },
    'custom': {
      name: 'Custom Configuration',
      fields: [
        { name: 'input_param', type: 'string' as const, required: true, description: 'Custom input parameter' }
      ]
    }
  };

  // Loading state
  isSubmitting = signal(false);

  /**
   * Initialize component and load vocabulary options
   */
  ngOnInit(): void {
    // Load vocabulary options from JS_Pionera_Ontology
    this.vocabularyService.getVocabularyOptions().subscribe({
      next: (options) => {
        this.vocabularyOptions.set(options);
      },
      error: (error) => {
        console.error('Error loading vocabulary options:', error);
        this.notificationService.showError('Error loading ML metadata options');
      }
    });
  }

  /**
   * Save and create the asset
   */
  async onSave(): Promise<void> {
    // Validate required fields
    const formData: AssetFormData = {
      id: this.id,
      name: this.name,
      version: this.version,
      contenttype: this.contenttype,
      assetType: this.assetType,
      shortDescription: this.shortDescription,
      description: this.description,
      keywords: this.keywords,
      byteSize: this.byteSize,
      format: this.format,
      mlMetadata: this.mlMetadata,
      storageTypeId: this.storageTypeId,
      dataAddress: this.getCurrentDataAddress()
    };
    
    const validation = validateAssetFormData(formData);
    
    if (!validation.valid) {
      this.notificationService.showError(`Validation errors: ${validation.errors.join(', ')}`);
      return;
    }
    
    // Additional storage-specific validation
    if (!this.validateDataAddress()) {
      this.notificationService.showError('Please fill all required storage fields');
      return;
    }
    
    // Add input_features to mlMetadata if this is an HTTP model
    if (this.storageTypeId === DATA_ADDRESS_TYPES.httpData && this.httpInputFields.length > 0) {
      // Create input schema
      const inputSchema = {
        fields: this.httpInputFields.map(field => ({
          name: field.name,
          type: field.type,
          required: field.required,
          ...(field.description && { description: field.description }),
          ...(field.min !== undefined && { min: field.min }),
          ...(field.max !== undefined && { max: field.max })
        }))
      };
      
      // Add to mlMetadata as a JSON string (will be parsed as JSONB in backend)
      (formData.mlMetadata as any).input_features = inputSchema;
      
      console.log('[Asset Create] Adding input_features to mlMetadata:', inputSchema);
    }
    
    this.isSubmitting.set(true);
    
    try {
      // Convert form data to asset input
      const assetInput = convertFormDataToAssetInput(formData);
      
      // Handle DataSpacePrototypeStore file upload
      const storageType = this.storageTypeId as string;
      if (storageType === DATA_ADDRESS_TYPES.dataSpacePrototypeStore && this.dataSpacePrototypeStoreAddress.file) {
        await this.createAssetWithFileUpload(assetInput, this.dataSpacePrototypeStoreAddress.file);
      } else {
        await this.createAsset(assetInput);
      }
    } catch (error: any) {
      this.notificationService.showError(`Error creating asset: ${error.message || 'Unknown error'}`);
      this.isSubmitting.set(false);
    }
  }

  /**
   * Create asset without file upload
   */
  private async createAsset(assetInput: AssetInput): Promise<void> {
    this.assetService.createAsset(assetInput as any).subscribe({
      next: () => {
        this.notificationService.showInfo('Asset created successfully');
        this.navigateToAssets();
      },
      error: (error) => {
        this.notificationService.showError(`Error creating asset: ${error.error?.[0]?.message || error.message}`);
        this.isSubmitting.set(false);
      },
      complete: () => {
        this.isSubmitting.set(false);
      }
    });
  }

  /**
   * Create asset with chunked file upload for DataSpacePrototypeStore
   */
  private async createAssetWithFileUpload(assetInput: AssetInput, file: File): Promise<void> {
    const chunkSize = 5 * 1024 * 1024; // 5 MB chunks (S3 minimum)
    const totalChunks = Math.ceil(file.size / chunkSize);
    const fileName = file.name;
    const maxRetries = 3;

    try {
      // Step 1: Create asset first (required for S3 flow)
      this.notificationService.showInfo('Creating asset...');
      await this.createAsset(assetInput);
      const assetId = assetInput['@id'];
      console.log(`[Upload] Asset created: ${assetId}`);
      
      // Step 2: Initialize upload session
      this.notificationService.showInfo('Initializing file upload...');
      const { sessionId } = await this.assetService.initUpload(
        assetId,
        fileName,
        totalChunks,
        file.type || 'application/octet-stream'
      );
      
      console.log(`[Upload] Session created: ${sessionId}`);
      
      // Step 3: Upload chunks
      const parts: Array<{ PartNumber: number; ETag: string }> = [];
      
      for (let chunkIndex = 0; chunkIndex < totalChunks; chunkIndex++) {
        const start = chunkIndex * chunkSize;
        const chunk = file.slice(start, start + chunkSize);
        
        const progressPercentage = Math.floor(((chunkIndex + 1) / totalChunks) * 100);
        this.notificationService.showInfo(`Uploading file: ${progressPercentage}% completed`);
        
        let attempt = 0;
        let success = false;
        let etag = '';
        
        while (attempt < maxRetries && !success) {
          try {
            const result = await this.assetService.uploadChunk(sessionId, chunkIndex + 1, chunk);
            etag = result.etag;
            success = true;
            console.log(`[Upload] Chunk ${chunkIndex + 1}/${totalChunks} uploaded, ETag: ${etag}`);
          } catch (error) {
            attempt++;
            console.error(`[Upload] Chunk ${chunkIndex + 1} failed (attempt ${attempt}):`, error);
            if (attempt >= maxRetries) {
              throw new Error(`Error uploading chunk ${chunkIndex + 1}. Maximum retries reached.`);
            }
            // Wait before retry (exponential backoff)
            await new Promise(resolve => setTimeout(resolve, 1000 * Math.pow(2, attempt - 1)));
          }
        }
        
        parts.push({
          PartNumber: chunkIndex + 1,
          ETag: etag
        });
      }
      
      // Step 4: Finalize upload (updates data_address with s3Key)
      this.notificationService.showInfo('Finalizing upload...');
      const { s3Key } = await this.assetService.finalizeUpload(sessionId, parts);
      console.log(`[Upload] Finalized: s3Key=${s3Key}`);
      
      this.notificationService.showInfo('Asset created successfully with file upload');
      this.navigateToAssets();
    } catch (error: any) {
      this.notificationService.showError(`Error uploading file: ${error.message}`);
    } finally {
      this.isSubmitting.set(false);
    }
  }

  /**
   * Get current data address based on selected storage type
   */
  private getCurrentDataAddress(): any {
    const storageType = this.storageTypeId as string;
    
    if (storageType === DATA_ADDRESS_TYPES.httpData) {
      return this.httpDataAddress;
    }
    
    if (storageType === DATA_ADDRESS_TYPES.amazonS3) {
      return this.amazonS3DataAddress;
    }
    
    if (storageType === DATA_ADDRESS_TYPES.dataSpacePrototypeStore) {
      return this.dataSpacePrototypeStoreAddress;
    }
    
    throw new Error('Invalid storage type');
  }

  /**
   * Validate data address based on storage type
   */
  private validateDataAddress(): boolean {
    const storageType = this.storageTypeId as string;
    
    if (storageType === DATA_ADDRESS_TYPES.httpData) {
      return !!(
        this.httpDataAddress.name &&
        this.httpDataAddress.baseUrl &&
        this.validateUrl(this.httpDataAddress.baseUrl)
      );
    }
    
    if (storageType === DATA_ADDRESS_TYPES.amazonS3) {
      return !!(
        this.amazonS3DataAddress.region &&
        this.amazonS3DataAddress.bucketName &&
        this.amazonS3DataAddress.accessKeyId &&
        this.amazonS3DataAddress.secretAccessKey &&
        this.amazonS3DataAddress.endpointOverride
      );
    }
    
    if (storageType === DATA_ADDRESS_TYPES.dataSpacePrototypeStore) {
      return !!this.dataSpacePrototypeStoreAddress.file;
    }
    
    return false;
  }

  /**
   * Validate URL format
   */
  private validateUrl(url: string): boolean {
    try {
      const urlObj = new URL(url);
      return urlObj.protocol === 'http:' || urlObj.protocol === 'https:';
    } catch {
      return false;
    }
  }

  /**
   * Handle toggle changes for HTTP proxy settings
   */
  onToggleChange(property: keyof HttpDataAddress, value: boolean): void {
    (this.httpDataAddress[property] as any) = value ? 'true' : 'false';
    // Check if all HTTP fields are now complete
    this.checkHttpDataFieldsComplete();
  }
  
  /**
   * Check if all HTTP Data fields are complete
   * Called on blur and toggle change events
   */
  checkHttpDataFieldsComplete(): void {
    if (this.storageTypeId !== DATA_ADDRESS_TYPES.httpData) {
      return;
    }
    
    const isComplete = this.validateHttpDataFieldsComplete();
    
    // If just completed and not already shown warning
    if (isComplete && !this.httpDataFieldsCompleted() && !this.inputSchemaWarningShown) {
      this.httpDataFieldsCompleted.set(true);
      this.inputSchemaWarningShown = true;
      
      // Show alert and redirect to ML Metadata tab
      setTimeout(() => {
        this.notificationService.showWarning(
          'HTTP Configuration complete! Please configure the Model Input Schema in ML Metadata tab (REQUIRED for HTTP models)',
          8000
        );
        
        // Redirect to ML Metadata tab (index 1)
        if (this.tabGroup) {
          this.tabGroup.selectedIndex = 1;
        }
      }, 500);
    }
  }
  
  /**
   * Validate that all required HTTP Data fields are filled
   * Returns true only if name, baseUrl, path, contentType, authKey, authCode, secretName are filled
   * AND at least one proxy option is selected
   */
  private validateHttpDataFieldsComplete(): boolean {
    const http = this.httpDataAddress;
    
    // Check all required fields
    const requiredFieldsFilled = !!(      http.name &&
      http.baseUrl &&
      http.path &&
      http.contentType &&
      http.authKey &&
      http.authCode &&
      http.secretName
    );
    
    // Check at least one proxy option is enabled
    const atLeastOneProxyEnabled = 
      http.proxyBody === 'true' ||
      http.proxyPath === 'true' ||
      http.proxyQueryParams === 'true' ||
      http.proxyMethod === 'true';
    
    return requiredFieldsFilled && atLeastOneProxyEnabled;
  }
  
  /**
   * Called when user leaves an HTTP Data input field
   */
  onHttpDataFieldBlur(): void {
    this.checkHttpDataFieldsComplete();
  }

  /**
   * Handle file selection for DataSpacePrototypeStore
   */
  onFileSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      this.dataSpacePrototypeStoreAddress.file = input.files[0];
    }
  }

  /**
   * Add a new input field to the configuration
   */
  addInputField(): void {
    this.httpInputFields.push({
      name: '',
      type: 'string',
      required: true,
      description: ''
    });
  }

  /**
   * Remove an input field from the configuration
   */
  removeInputField(index: number): void {
    this.httpInputFields.splice(index, 1);
  }

  /**
   * Load input fields from a predefined template
   */
  loadTemplate(templateKey: string): void {
    if (templateKey && this.inputTemplates[templateKey as keyof typeof this.inputTemplates]) {
      const template = this.inputTemplates[templateKey as keyof typeof this.inputTemplates];
      this.httpInputFields = JSON.parse(JSON.stringify(template.fields)); // Deep copy
      this.notificationService.showInfo(`Template "${template.name}" loaded successfully`);
    } else {
      this.httpInputFields = [];
    }
  }

  /**
   * Get Input Schema as JSON string for preview
   */
  getInputSchemaJSON(): string {
    if (this.httpInputFields.length === 0) {
      return '{}';
    }
    
    const schema = {
      fields: this.httpInputFields.map(field => ({
        name: field.name,
        type: field.type,
        required: field.required,
        ...(field.description && { description: field.description }),
        ...(field.min !== undefined && { min: field.min }),
        ...(field.max !== undefined && { max: field.max })
      }))
    };
    
    return JSON.stringify(schema, null, 2);
  }

  /**
   * Get template keys for dropdown
   */
  getTemplateKeys(): string[] {
    return Object.keys(this.inputTemplates);
  }

  /**
   * Get template name by key
   */
  getTemplateName(key: string): string {
    return this.inputTemplates[key as keyof typeof this.inputTemplates]?.name || key;
  }

  /**
   * Navigate back to assets list
   */
  navigateToAssets(): void {
    this.router.navigate(['/ml-assets']);
  }

  /**
   * Cancel and return to assets list
   */
  onCancel(): void {
    this.navigateToAssets();
  }
}
