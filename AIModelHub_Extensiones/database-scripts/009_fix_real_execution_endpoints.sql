-- Fix execution_endpoint for the REAL 25 MLModel assets in database
-- These are the actual asset_id values that exist in the database

-- Vision Models (5)
UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/vision/chest-xray',
    is_executable = true
WHERE asset_id = 'asset-vision-chest-xray';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/vision/pneumonia',
    is_executable = true
WHERE asset_id = 'asset-vision-pneumonia';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/vision/covid19',
    is_executable = true
WHERE asset_id = 'asset-vision-covid19';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/vision/lung-nodule',
    is_executable = true
WHERE asset_id = 'asset-vision-lung-nodule';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/vision/tuberculosis',
    is_executable = true
WHERE asset_id = 'asset-vision-tuberculosis';

-- NLP Models (5)
UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/nlp/customer-feedback',
    is_executable = true
WHERE asset_id = 'asset-nlp-customer-feedback';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/nlp/ecommerce-sentiment',
    is_executable = true
WHERE asset_id = 'asset-nlp-ecommerce';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/nlp/product-review',
    is_executable = true
WHERE asset_id = 'asset-nlp-product-review';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/nlp/social-media',
    is_executable = true
WHERE asset_id = 'asset-nlp-social-media';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/nlp/twitter-sentiment',
    is_executable = true
WHERE asset_id = 'asset-nlp-twitter';

-- Health Models (5)
UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/health/bmi',
    is_executable = true
WHERE asset_id = 'asset-health-bmi';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/health/bmr',
    is_executable = true
WHERE asset_id = 'asset-health-bmr';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/health/body-fat',
    is_executable = true
WHERE asset_id = 'asset-health-bodyfat';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/health/ideal-weight',
    is_executable = true
WHERE asset_id = 'asset-health-ideal-weight';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/health/risk-assessment',
    is_executable = true
WHERE asset_id = 'asset-health-risk';

-- Flora Models (5)
UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/classification/botanical',
    is_executable = true
WHERE asset_id = 'asset-flora-botanical';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/classification/flower',
    is_executable = true
WHERE asset_id = 'asset-flora-flower';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/classification/iris',
    is_executable = true
WHERE asset_id = 'asset-flora-iris';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/classification/plant',
    is_executable = true
WHERE asset_id = 'asset-flora-plant';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/classification/flora',
    is_executable = true
WHERE asset_id = 'asset-flora-recognition';

-- Fraud Models (5)
UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/fraud/anomaly',
    is_executable = true
WHERE asset_id = 'asset-fraud-anomaly';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/fraud/classifier',
    is_executable = true
WHERE asset_id = 'asset-fraud-classifier';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/fraud/credit-card',
    is_executable = true
WHERE asset_id = 'asset-fraud-creditcard';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/fraud/risk-scorer',
    is_executable = true
WHERE asset_id = 'asset-fraud-risk-scorer';

UPDATE data_addresses SET 
    execution_endpoint = 'http://localhost:8080/api/v1/fraud/transaction',
    is_executable = true
WHERE asset_id = 'asset-fraud-transaction';

-- Verify: Count how many were updated
SELECT COUNT(*) as updated_models
FROM data_addresses 
WHERE is_executable = true
  AND execution_endpoint IS NOT NULL
  AND asset_id IN (
    SELECT id FROM assets WHERE asset_type = 'MLModel'
  );

-- Show sample results
SELECT asset_id, LEFT(execution_endpoint, 50) as endpoint, is_executable
FROM data_addresses
WHERE asset_id IN (SELECT id FROM assets WHERE asset_type = 'MLModel')
  AND execution_endpoint IS NOT NULL
ORDER BY asset_id
LIMIT 10;

-- Fix ownership to match user-conn-user1-demo for all 25 benchmark models
UPDATE assets SET owner = 'user-conn-user1-demo'
WHERE id LIKE 'asset-vision-%' 
   OR id LIKE 'asset-nlp-%' 
   OR id LIKE 'asset-health-%' 
   OR id LIKE 'asset-flora-%' 
   OR id LIKE 'asset-fraud-%';

-- Exclude asset-user1-fraud-api from executable models (no valid endpoint in mock server)
UPDATE data_addresses SET 
    is_executable = false,
    execution_endpoint = NULL
WHERE asset_id = 'asset-user1-fraud-api';
