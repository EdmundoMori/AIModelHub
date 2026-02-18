-- ====================================================================
-- 25 HTTP Models for Benchmarking - Correct Database Schema
-- Generated: 2026-02-10
-- Compatible with AIModelHub database structure
-- ====================================================================


-- Chest X-Ray Classifier
-- ----------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-vision-chest-xray',
    'Chest X-Ray Classifier',
    '1.0',
    'application/json',
    'Deep learning model for chest X-ray pathology detection using ResNet50. Classifies images into normal or abnormal categories.',
    'medical, xray, chest, vision, radiology, diagnostic',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-vision-chest-xray',
    'HttpData',
    '/api/v1/vision/chest-xray'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-vision-chest-xray',
    'Classification - Computer Vision',
    'Medical Image Analysis',
    'Convolutional Neural Network',
    '{
  "fields": [
    {
      "name": "image_url",
      "type": "string",
      "required": true,
      "description": "URL to chest X-ray image"
    },
    {
      "name": "image_size",
      "type": "string",
      "required": false,
      "description": "Target image size (e.g., 512x512)"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Pneumonia Detector
-- ------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-vision-pneumonia',
    'Pneumonia Detector',
    '1.0',
    'application/json',
    'Specialized CNN model for detecting pneumonia in chest X-rays. Trained on large medical imaging dataset.',
    'pneumonia, medical, xray, detection, vision, respiratory',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-vision-pneumonia',
    'HttpData',
    '/api/v1/vision/pneumonia'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-vision-pneumonia',
    'Classification - Computer Vision',
    'Medical Image Analysis',
    'Deep Convolutional Neural Network',
    '{
  "fields": [
    {
      "name": "image_url",
      "type": "string",
      "required": true,
      "description": "URL to chest X-ray image"
    },
    {
      "name": "image_size",
      "type": "string",
      "required": false,
      "description": "Target image size (e.g., 512x512)"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- COVID-19 X-Ray Detector
-- -----------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-vision-covid19',
    'COVID-19 X-Ray Detector',
    '1.0',
    'application/json',
    'AI model for detecting COVID-19 signs in chest radiographs. Uses transfer learning on medical data.',
    'covid19, pandemic, medical, xray, vision, coronavirus',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-vision-covid19',
    'HttpData',
    '/api/v1/vision/covid19'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-vision-covid19',
    'Classification - Computer Vision',
    'Medical Image Analysis',
    'Transfer Learning CNN',
    '{
  "fields": [
    {
      "name": "image_url",
      "type": "string",
      "required": true,
      "description": "URL to chest X-ray image"
    },
    {
      "name": "image_size",
      "type": "string",
      "required": false,
      "description": "Target image size (e.g., 512x512)"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Lung Nodule Detector
-- --------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-vision-lung-nodule',
    'Lung Nodule Detector',
    '1.0',
    'application/json',
    'Computer vision model for detecting lung nodules in X-ray images. Early cancer detection aid.',
    'lung, nodule, cancer, medical, xray, vision, oncology',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-vision-lung-nodule',
    'HttpData',
    '/api/v1/vision/lung-nodule'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-vision-lung-nodule',
    'Classification - Computer Vision',
    'Medical Image Analysis',
    'Region-based CNN',
    '{
  "fields": [
    {
      "name": "image_url",
      "type": "string",
      "required": true,
      "description": "URL to chest X-ray image"
    },
    {
      "name": "image_size",
      "type": "string",
      "required": false,
      "description": "Target image size (e.g., 512x512)"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Tuberculosis Detector
-- ---------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-vision-tuberculosis',
    'Tuberculosis Detector',
    '1.0',
    'application/json',
    'ML model for TB detection in chest X-rays. Supports global health screening programs.',
    'tuberculosis, tb, medical, xray, vision, infectious-disease',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-vision-tuberculosis',
    'HttpData',
    '/api/v1/vision/tuberculosis'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-vision-tuberculosis',
    'Classification - Computer Vision',
    'Medical Image Analysis',
    'Ensemble CNN',
    '{
  "fields": [
    {
      "name": "image_url",
      "type": "string",
      "required": true,
      "description": "URL to chest X-ray image"
    },
    {
      "name": "image_size",
      "type": "string",
      "required": false,
      "description": "Target image size (e.g., 512x512)"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- E-commerce Sentiment Analyzer
-- -----------------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-nlp-ecommerce',
    'E-commerce Sentiment Analyzer',
    '1.0',
    'application/json',
    'NLP model trained on e-commerce product reviews. Classifies customer sentiment as positive, negative, or neutral.',
    'sentiment, nlp, ecommerce, reviews, text, customer-feedback',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-nlp-ecommerce',
    'HttpData',
    '/api/v1/nlp/ecommerce-sentiment'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-nlp-ecommerce',
    'Classification - Natural Language Processing',
    'Sentiment Analysis',
    'BERT Fine-tuned',
    '{
  "fields": [
    {
      "name": "text",
      "type": "string",
      "required": true,
      "description": "Product review or feedback text"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Twitter Sentiment Analyzer
-- --------------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-nlp-twitter',
    'Twitter Sentiment Analyzer',
    '1.0',
    'application/json',
    'Sentiment analysis model optimized for social media posts. Handles abbreviations, emojis, and slang.',
    'sentiment, twitter, social-media, nlp, text, opinion-mining',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-nlp-twitter',
    'HttpData',
    '/api/v1/nlp/twitter-sentiment'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-nlp-twitter',
    'Classification - Natural Language Processing',
    'Sentiment Analysis',
    'RoBERTa Fine-tuned',
    '{
  "fields": [
    {
      "name": "text",
      "type": "string",
      "required": true,
      "description": "Social media post or tweet text"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Product Review Analyzer
-- -----------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-nlp-product-review',
    'Product Review Analyzer',
    '1.0',
    'application/json',
    'Advanced NLP model for product review sentiment and aspect extraction. Multi-label classification.',
    'product, review, sentiment, nlp, text, consumer-insights',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-nlp-product-review',
    'HttpData',
    '/api/v1/nlp/product-review'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-nlp-product-review',
    'Classification - Natural Language Processing',
    'Sentiment Analysis',
    'DistilBERT',
    '{
  "fields": [
    {
      "name": "text",
      "type": "string",
      "required": true,
      "description": "Product review text"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Customer Feedback Analyzer
-- --------------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-nlp-customer-feedback',
    'Customer Feedback Analyzer',
    '1.0',
    'application/json',
    'Enterprise-grade sentiment analysis for customer service feedback and support tickets.',
    'customer-service, feedback, sentiment, nlp, text, support',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-nlp-customer-feedback',
    'HttpData',
    '/api/v1/nlp/customer-feedback'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-nlp-customer-feedback',
    'Classification - Natural Language Processing',
    'Sentiment Analysis',
    'LSTM with Attention',
    '{
  "fields": [
    {
      "name": "text",
      "type": "string",
      "required": true,
      "description": "Customer feedback or support ticket text"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Social Media Sentiment Analyzer
-- -------------------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-nlp-social-media',
    'Social Media Sentiment Analyzer',
    '1.0',
    'application/json',
    'General-purpose sentiment analysis for social media content. Multi-platform support.',
    'social-media, sentiment, nlp, text, opinion, brand-monitoring',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-nlp-social-media',
    'HttpData',
    '/api/v1/nlp/social-media'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-nlp-social-media',
    'Classification - Natural Language Processing',
    'Sentiment Analysis',
    'XLNet',
    '{
  "fields": [
    {
      "name": "text",
      "type": "string",
      "required": true,
      "description": "Social media post or comment"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- BMI Calculator
-- --------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-health-bmi',
    'BMI Calculator',
    '1.0',
    'application/json',
    'Body Mass Index calculator using standard WHO formula. Provides health category classification.',
    'bmi, health, fitness, body-metrics, wellness, nutrition',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-health-bmi',
    'HttpData',
    '/api/v1/health/bmi'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-health-bmi',
    'Regression',
    'Health Metrics',
    'Linear Regression',
    '{
  "fields": [
    {
      "name": "weight_kg",
      "type": "float",
      "required": true,
      "description": "Body weight in kilograms"
    },
    {
      "name": "height_m",
      "type": "float",
      "required": true,
      "description": "Height in meters"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Body Fat Estimator
-- ------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-health-bodyfat',
    'Body Fat Estimator',
    '1.0',
    'application/json',
    'ML model for estimating body fat percentage using anthropometric measurements.',
    'bodyfat, health, fitness, body-composition, wellness',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-health-bodyfat',
    'HttpData',
    '/api/v1/health/body-fat'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-health-bodyfat',
    'Regression',
    'Health Metrics',
    'Random Forest Regressor',
    '{
  "fields": [
    {
      "name": "weight_kg",
      "type": "float",
      "required": true,
      "description": "Body weight in kilograms"
    },
    {
      "name": "height_m",
      "type": "float",
      "required": true,
      "description": "Height in meters"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- BMR Calculator
-- --------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-health-bmr',
    'BMR Calculator',
    '1.0',
    'application/json',
    'Basal Metabolic Rate calculator using Mifflin-St Jeor equation. Calorie needs estimation.',
    'bmr, metabolism, health, fitness, nutrition, calories',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-health-bmr',
    'HttpData',
    '/api/v1/health/bmr'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-health-bmr',
    'Regression',
    'Health Metrics',
    'Polynomial Regression',
    '{
  "fields": [
    {
      "name": "weight_kg",
      "type": "float",
      "required": true,
      "description": "Body weight in kilograms"
    },
    {
      "name": "height_m",
      "type": "float",
      "required": true,
      "description": "Height in meters"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Ideal Weight Predictor
-- ----------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-health-ideal-weight',
    'Ideal Weight Predictor',
    '1.0',
    'application/json',
    'Predicts ideal body weight range based on height and body frame using multiple health formulas.',
    'ideal-weight, health, fitness, wellness, body-goals',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-health-ideal-weight',
    'HttpData',
    '/api/v1/health/ideal-weight'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-health-ideal-weight',
    'Regression',
    'Health Metrics',
    'Ensemble Regressor',
    '{
  "fields": [
    {
      "name": "weight_kg",
      "type": "float",
      "required": true,
      "description": "Current body weight in kilograms"
    },
    {
      "name": "height_m",
      "type": "float",
      "required": true,
      "description": "Height in meters"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Health Risk Scorer
-- ------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-health-risk',
    'Health Risk Scorer',
    '1.0',
    'application/json',
    'Calculates health risk score based on BMI and related metrics. Preventive health assessment.',
    'health-risk, assessment, wellness, prevention, body-metrics',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-health-risk',
    'HttpData',
    '/api/v1/health/health-risk'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-health-risk',
    'Regression',
    'Health Metrics',
    'Gradient Boosting Regressor',
    '{
  "fields": [
    {
      "name": "weight_kg",
      "type": "float",
      "required": true,
      "description": "Body weight in kilograms"
    },
    {
      "name": "height_m",
      "type": "float",
      "required": true,
      "description": "Height in meters"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Iris Flower Classifier
-- ----------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-flora-iris',
    'Iris Flower Classifier',
    '1.0',
    'application/json',
    'Classic iris species classifier using petal and sepal measurements. Trained on Fisher iris dataset.',
    'iris, flower, classification, botanical, species-identification',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-flora-iris',
    'HttpData',
    '/api/v1/classification/iris'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-flora-iris',
    'Classification - Tabular',
    'Flora Identification',
    'Support Vector Machine',
    '{
  "fields": [
    {
      "name": "sepal_length",
      "type": "float",
      "required": true,
      "description": "Sepal length in cm"
    },
    {
      "name": "sepal_width",
      "type": "float",
      "required": true,
      "description": "Sepal width in cm"
    },
    {
      "name": "petal_length",
      "type": "float",
      "required": true,
      "description": "Petal length in cm"
    },
    {
      "name": "petal_width",
      "type": "float",
      "required": true,
      "description": "Petal width in cm"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Flower Classifier
-- -----------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-flora-flower',
    'Flower Classifier',
    '1.0',
    'application/json',
    'General flower species classifier based on morphological features. Multi-species support.',
    'flower, classification, botanical, species, morphology',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-flora-flower',
    'HttpData',
    '/api/v1/classification/flower'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-flora-flower',
    'Classification - Tabular',
    'Flora Identification',
    'Decision Tree',
    '{
  "fields": [
    {
      "name": "sepal_length",
      "type": "float",
      "required": true,
      "description": "Sepal length in cm"
    },
    {
      "name": "sepal_width",
      "type": "float",
      "required": true,
      "description": "Sepal width in cm"
    },
    {
      "name": "petal_length",
      "type": "float",
      "required": true,
      "description": "Petal length in cm"
    },
    {
      "name": "petal_width",
      "type": "float",
      "required": true,
      "description": "Petal width in cm"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Plant Classifier
-- ----------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-flora-plant',
    'Plant Classifier',
    '1.0',
    'application/json',
    'Plant species identification model using leaf and flower measurements. Botanical taxonomy support.',
    'plant, botanical, classification, species, taxonomy',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-flora-plant',
    'HttpData',
    '/api/v1/classification/plant'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-flora-plant',
    'Classification - Tabular',
    'Flora Identification',
    'K-Nearest Neighbors',
    '{
  "fields": [
    {
      "name": "sepal_length",
      "type": "float",
      "required": true,
      "description": "Sepal length in cm"
    },
    {
      "name": "sepal_width",
      "type": "float",
      "required": true,
      "description": "Sepal width in cm"
    },
    {
      "name": "petal_length",
      "type": "float",
      "required": true,
      "description": "Petal length in cm"
    },
    {
      "name": "petal_width",
      "type": "float",
      "required": true,
      "description": "Petal width in cm"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Botanical Classifier
-- --------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-flora-botanical',
    'Botanical Classifier',
    '1.0',
    'application/json',
    'Advanced botanical classification model for scientific plant identification and research.',
    'botanical, classification, scientific, plant-research, taxonomy',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-flora-botanical',
    'HttpData',
    '/api/v1/classification/botanical'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-flora-botanical',
    'Classification - Tabular',
    'Flora Identification',
    'Random Forest',
    '{
  "fields": [
    {
      "name": "sepal_length",
      "type": "float",
      "required": true,
      "description": "Sepal length in cm"
    },
    {
      "name": "sepal_width",
      "type": "float",
      "required": true,
      "description": "Sepal width in cm"
    },
    {
      "name": "petal_length",
      "type": "float",
      "required": true,
      "description": "Petal length in cm"
    },
    {
      "name": "petal_width",
      "type": "float",
      "required": true,
      "description": "Petal width in cm"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Flora Recognition System
-- ------------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-flora-recognition',
    'Flora Recognition System',
    '1.0',
    'application/json',
    'Comprehensive flora recognition using morphological features. Educational and research applications.',
    'flora, recognition, botanical, education, biodiversity',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-flora-recognition',
    'HttpData',
    '/api/v1/classification/flora-recognition'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-flora-recognition',
    'Classification - Tabular',
    'Flora Identification',
    'Gradient Boosting Classifier',
    '{
  "fields": [
    {
      "name": "sepal_length",
      "type": "float",
      "required": true,
      "description": "Sepal length in cm"
    },
    {
      "name": "sepal_width",
      "type": "float",
      "required": true,
      "description": "Sepal width in cm"
    },
    {
      "name": "petal_length",
      "type": "float",
      "required": true,
      "description": "Petal length in cm"
    },
    {
      "name": "petal_width",
      "type": "float",
      "required": true,
      "description": "Petal width in cm"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Transaction Fraud Checker
-- -------------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-fraud-transaction',
    'Transaction Fraud Checker',
    '1.0',
    'application/json',
    'Real-time fraud detection for financial transactions. Analyzes patterns and flags suspicious activity.',
    'fraud, transaction, finance, security, anomaly-detection',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-fraud-transaction',
    'HttpData',
    '/api/v1/fraud/transaction'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-fraud-transaction',
    'Classification - Tabular',
    'Fraud Detection',
    'XGBoost',
    '{
  "fields": [
    {
      "name": "amount",
      "type": "float",
      "required": true,
      "description": "Transaction amount in currency units"
    },
    {
      "name": "merchant_category",
      "type": "string",
      "required": true,
      "description": "Merchant category code"
    },
    {
      "name": "location",
      "type": "string",
      "required": true,
      "description": "Transaction location"
    },
    {
      "name": "timestamp",
      "type": "string",
      "required": true,
      "description": "Transaction timestamp ISO format"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Credit Card Fraud Detector
-- --------------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-fraud-creditcard',
    'Credit Card Fraud Detector',
    '1.0',
    'application/json',
    'Specialized fraud detection for credit card transactions. High accuracy and low false positive rate.',
    'creditcard, fraud, payment, security, banking',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-fraud-creditcard',
    'HttpData',
    '/api/v1/fraud/credit-card'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-fraud-creditcard',
    'Classification - Tabular',
    'Fraud Detection',
    'Neural Network',
    '{
  "fields": [
    {
      "name": "amount",
      "type": "float",
      "required": true,
      "description": "Transaction amount in currency units"
    },
    {
      "name": "merchant_category",
      "type": "string",
      "required": true,
      "description": "Merchant category code"
    },
    {
      "name": "location",
      "type": "string",
      "required": true,
      "description": "Transaction location"
    },
    {
      "name": "timestamp",
      "type": "string",
      "required": true,
      "description": "Transaction timestamp ISO format"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Transaction Anomaly Detector
-- ----------------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-fraud-anomaly',
    'Transaction Anomaly Detector',
    '1.0',
    'application/json',
    'ML model for detecting anomalous transaction patterns. Unsupervised learning approach.',
    'anomaly, fraud, transaction, outlier-detection, security',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-fraud-anomaly',
    'HttpData',
    '/api/v1/fraud/anomaly'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-fraud-anomaly',
    'Classification - Tabular',
    'Fraud Detection',
    'Isolation Forest',
    '{
  "fields": [
    {
      "name": "amount",
      "type": "float",
      "required": true,
      "description": "Transaction amount in currency units"
    },
    {
      "name": "merchant_category",
      "type": "string",
      "required": true,
      "description": "Merchant category code"
    },
    {
      "name": "location",
      "type": "string",
      "required": true,
      "description": "Transaction location"
    },
    {
      "name": "timestamp",
      "type": "string",
      "required": true,
      "description": "Transaction timestamp ISO format"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Fraud Risk Scorer
-- -----------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-fraud-risk-scorer',
    'Fraud Risk Scorer',
    '1.0',
    'application/json',
    'Assigns fraud risk scores to transactions for manual review pipeline. Configurable thresholds.',
    'fraud, risk-score, transaction, assessment, security',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-fraud-risk-scorer',
    'HttpData',
    '/api/v1/fraud/risk-scorer'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-fraud-risk-scorer',
    'Classification - Tabular',
    'Fraud Detection',
    'Logistic Regression',
    '{
  "fields": [
    {
      "name": "amount",
      "type": "float",
      "required": true,
      "description": "Transaction amount in currency units"
    },
    {
      "name": "merchant_category",
      "type": "string",
      "required": true,
      "description": "Merchant category code"
    },
    {
      "name": "location",
      "type": "string",
      "required": true,
      "description": "Transaction location"
    },
    {
      "name": "timestamp",
      "type": "string",
      "required": true,
      "description": "Transaction timestamp ISO format"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- Binary Fraud Classifier
-- -----------------------
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    'asset-fraud-classifier',
    'Binary Fraud Classifier',
    '1.0',
    'application/json',
    'Simple binary classifier for fraud vs legitimate transactions. High-speed inference.',
    'fraud, binary-classification, transaction, finance, security',
    'MLModel',
    'user-conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    'asset-fraud-classifier',
    'HttpData',
    '/api/v1/fraud/fraud-classifier'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    'asset-fraud-classifier',
    'Classification - Tabular',
    'Fraud Detection',
    'LightGBM',
    '{
  "fields": [
    {
      "name": "amount",
      "type": "float",
      "required": true,
      "description": "Transaction amount in currency units"
    },
    {
      "name": "merchant_category",
      "type": "string",
      "required": true,
      "description": "Merchant category code"
    },
    {
      "name": "location",
      "type": "string",
      "required": true,
      "description": "Transaction location"
    },
    {
      "name": "timestamp",
      "type": "string",
      "required": true,
      "description": "Transaction timestamp ISO format"
    }
  ]
}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;


-- ====================================================================
-- Verification Query
-- ====================================================================
SELECT 
    COUNT(*) as total_models,
    COUNT(CASE WHEN da.type = 'HttpData' THEN 1 END) as http_models
FROM assets a
LEFT JOIN data_addresses da ON a.id = da.asset_id
WHERE a.id LIKE 'asset-vision-%' 
   OR a.id LIKE 'asset-nlp-%'
   OR a.id LIKE 'asset-health-%'
   OR a.id LIKE 'asset-flora-%'
   OR a.id LIKE 'asset-fraud-%';

