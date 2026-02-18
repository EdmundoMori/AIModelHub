#!/usr/bin/env python3
"""
Generate SQL script for 25 HTTP models with correct database schema
Based on actual AIModelHub database structure
"""

models = [
    # Group 1: Medical Imaging (Vision - X-Ray Analysis)
    {
        "id": "asset-vision-chest-xray",
        "name": "Chest X-Ray Classifier",
        "description": "Deep learning model for chest X-ray pathology detection using ResNet50. Classifies images into normal or abnormal categories.",
        "keywords": "medical, xray, chest, vision, radiology, diagnostic",
        "task": "Classification - Computer Vision",
        "subtask": "Medical Image Analysis",
        "algorithm": "Convolutional Neural Network",
        "endpoint": "/api/v1/vision/chest-xray",
        "input_features": {
            "fields": [
                {"name": "image_url", "type": "string", "required": True, "description": "URL to chest X-ray image"},
                {"name": "image_size", "type": "string", "required": False, "description": "Target image size (e.g., 512x512)"}
            ]
        }
    },
    {
        "id": "asset-vision-pneumonia",
        "name": "Pneumonia Detector",
        "description": "Specialized CNN model for detecting pneumonia in chest X-rays. Trained on large medical imaging dataset.",
        "keywords": "pneumonia, medical, xray, detection, vision, respiratory",
        "task": "Classification - Computer Vision",
        "subtask": "Medical Image Analysis",
        "algorithm": "Deep Convolutional Neural Network",
        "endpoint": "/api/v1/vision/pneumonia",
        "input_features": {
            "fields": [
                {"name": "image_url", "type": "string", "required": True, "description": "URL to chest X-ray image"},
                {"name": "image_size", "type": "string", "required": False, "description": "Target image size (e.g., 512x512)"}
            ]
        }
    },
    {
        "id": "asset-vision-covid19",
        "name": "COVID-19 X-Ray Detector",
        "description": "AI model for detecting COVID-19 signs in chest radiographs. Uses transfer learning on medical data.",
        "keywords": "covid19, pandemic, medical, xray, vision, coronavirus",
        "task": "Classification - Computer Vision",
        "subtask": "Medical Image Analysis",
        "algorithm": "Transfer Learning CNN",
        "endpoint": "/api/v1/vision/covid19",
        "input_features": {
            "fields": [
                {"name": "image_url", "type": "string", "required": True, "description": "URL to chest X-ray image"},
                {"name": "image_size", "type": "string", "required": False, "description": "Target image size (e.g., 512x512)"}
            ]
        }
    },
    {
        "id": "asset-vision-lung-nodule",
        "name": "Lung Nodule Detector",
        "description": "Computer vision model for detecting lung nodules in X-ray images. Early cancer detection aid.",
        "keywords": "lung, nodule, cancer, medical, xray, vision, oncology",
        "task": "Classification - Computer Vision",
        "subtask": "Medical Image Analysis",
        "algorithm": "Region-based CNN",
        "endpoint": "/api/v1/vision/lung-nodule",
        "input_features": {
            "fields": [
                {"name": "image_url", "type": "string", "required": True, "description": "URL to chest X-ray image"},
                {"name": "image_size", "type": "string", "required": False, "description": "Target image size (e.g., 512x512)"}
            ]
        }
    },
    {
        "id": "asset-vision-tuberculosis",
        "name": "Tuberculosis Detector",
        "description": "ML model for TB detection in chest X-rays. Supports global health screening programs.",
        "keywords": "tuberculosis, tb, medical, xray, vision, infectious-disease",
        "task": "Classification - Computer Vision",
        "subtask": "Medical Image Analysis",
        "algorithm": "Ensemble CNN",
        "endpoint": "/api/v1/vision/tuberculosis",
        "input_features": {
            "fields": [
                {"name": "image_url", "type": "string", "required": True, "description": "URL to chest X-ray image"},
                {"name": "image_size", "type": "string", "required": False, "description": "Target image size (e.g., 512x512)"}
            ]
        }
    },
    
    # Group 2: Sentiment Analysis (NLP - Text Classification)
    {
        "id": "asset-nlp-ecommerce",
        "name": "E-commerce Sentiment Analyzer",
        "description": "NLP model trained on e-commerce product reviews. Classifies customer sentiment as positive, negative, or neutral.",
        "keywords": "sentiment, nlp, ecommerce, reviews, text, customer-feedback",
        "task": "Classification - Natural Language Processing",
        "subtask": "Sentiment Analysis",
        "algorithm": "BERT Fine-tuned",
        "endpoint": "/api/v1/nlp/ecommerce-sentiment",
        "input_features": {
            "fields": [
                {"name": "text", "type": "string", "required": True, "description": "Product review or feedback text"}
            ]
        }
    },
    {
        "id": "asset-nlp-twitter",
        "name": "Twitter Sentiment Analyzer",
        "description": "Sentiment analysis model optimized for social media posts. Handles abbreviations, emojis, and slang.",
        "keywords": "sentiment, twitter, social-media, nlp, text, opinion-mining",
        "task": "Classification - Natural Language Processing",
        "subtask": "Sentiment Analysis",
        "algorithm": "RoBERTa Fine-tuned",
        "endpoint": "/api/v1/nlp/twitter-sentiment",
        "input_features": {
            "fields": [
                {"name": "text", "type": "string", "required": True, "description": "Social media post or tweet text"}
            ]
        }
    },
    {
        "id": "asset-nlp-product-review",
        "name": "Product Review Analyzer",
        "description": "Advanced NLP model for product review sentiment and aspect extraction. Multi-label classification.",
        "keywords": "product, review, sentiment, nlp, text, consumer-insights",
        "task": "Classification - Natural Language Processing",
        "subtask": "Sentiment Analysis",
        "algorithm": "DistilBERT",
        "endpoint": "/api/v1/nlp/product-review",
        "input_features": {
            "fields": [
                {"name": "text", "type": "string", "required": True, "description": "Product review text"}
            ]
        }
    },
    {
        "id": "asset-nlp-customer-feedback",
        "name": "Customer Feedback Analyzer",
        "description": "Enterprise-grade sentiment analysis for customer service feedback and support tickets.",
        "keywords": "customer-service, feedback, sentiment, nlp, text, support",
        "task": "Classification - Natural Language Processing",
        "subtask": "Sentiment Analysis",
        "algorithm": "LSTM with Attention",
        "endpoint": "/api/v1/nlp/customer-feedback",
        "input_features": {
            "fields": [
                {"name": "text", "type": "string", "required": True, "description": "Customer feedback or support ticket text"}
            ]
        }
    },
    {
        "id": "asset-nlp-social-media",
        "name": "Social Media Sentiment Analyzer",
        "description": "General-purpose sentiment analysis for social media content. Multi-platform support.",
        "keywords": "social-media, sentiment, nlp, text, opinion, brand-monitoring",
        "task": "Classification - Natural Language Processing",
        "subtask": "Sentiment Analysis",
        "algorithm": "XLNet",
        "endpoint": "/api/v1/nlp/social-media",
        "input_features": {
            "fields": [
                {"name": "text", "type": "string", "required": True, "description": "Social media post or comment"}
            ]
        }
    },
    
    # Group 3: Health Metrics (Regression - Body Measurements)
    {
        "id": "asset-health-bmi",
        "name": "BMI Calculator",
        "description": "Body Mass Index calculator using standard WHO formula. Provides health category classification.",
        "keywords": "bmi, health, fitness, body-metrics, wellness, nutrition",
        "task": "Regression",
        "subtask": "Health Metrics",
        "algorithm": "Linear Regression",
        "endpoint": "/api/v1/health/bmi",
        "input_features": {
            "fields": [
                {"name": "weight_kg", "type": "float", "required": True, "description": "Body weight in kilograms"},
                {"name": "height_m", "type": "float", "required": True, "description": "Height in meters"}
            ]
        }
    },
    {
        "id": "asset-health-bodyfat",
        "name": "Body Fat Estimator",
        "description": "ML model for estimating body fat percentage using anthropometric measurements.",
        "keywords": "bodyfat, health, fitness, body-composition, wellness",
        "task": "Regression",
        "subtask": "Health Metrics",
        "algorithm": "Random Forest Regressor",
        "endpoint": "/api/v1/health/body-fat",
        "input_features": {
            "fields": [
                {"name": "weight_kg", "type": "float", "required": True, "description": "Body weight in kilograms"},
                {"name": "height_m", "type": "float", "required": True, "description": "Height in meters"}
            ]
        }
    },
    {
        "id": "asset-health-bmr",
        "name": "BMR Calculator",
        "description": "Basal Metabolic Rate calculator using Mifflin-St Jeor equation. Calorie needs estimation.",
        "keywords": "bmr, metabolism, health, fitness, nutrition, calories",
        "task": "Regression",
        "subtask": "Health Metrics",
        "algorithm": "Polynomial Regression",
        "endpoint": "/api/v1/health/bmr",
        "input_features": {
            "fields": [
                {"name": "weight_kg", "type": "float", "required": True, "description": "Body weight in kilograms"},
                {"name": "height_m", "type": "float", "required": True, "description": "Height in meters"}
            ]
        }
    },
    {
        "id": "asset-health-ideal-weight",
        "name": "Ideal Weight Predictor",
        "description": "Predicts ideal body weight range based on height and body frame using multiple health formulas.",
        "keywords": "ideal-weight, health, fitness, wellness, body-goals",
        "task": "Regression",
        "subtask": "Health Metrics",
        "algorithm": "Ensemble Regressor",
        "endpoint": "/api/v1/health/ideal-weight",
        "input_features": {
            "fields": [
                {"name": "weight_kg", "type": "float", "required": True, "description": "Current body weight in kilograms"},
                {"name": "height_m", "type": "float", "required": True, "description": "Height in meters"}
            ]
        }
    },
    {
        "id": "asset-health-risk",
        "name": "Health Risk Scorer",
        "description": "Calculates health risk score based on BMI and related metrics. Preventive health assessment.",
        "keywords": "health-risk, assessment, wellness, prevention, body-metrics",
        "task": "Regression",
        "subtask": "Health Metrics",
        "algorithm": "Gradient Boosting Regressor",
        "endpoint": "/api/v1/health/health-risk",
        "input_features": {
            "fields": [
                {"name": "weight_kg", "type": "float", "required": True, "description": "Body weight in kilograms"},
                {"name": "height_m", "type": "float", "required": True, "description": "Height in meters"}
            ]
        }
    },
    
    # Group 4: Flora Classification (Tabular - Iris Dataset Style)
    {
        "id": "asset-flora-iris",
        "name": "Iris Flower Classifier",
        "description": "Classic iris species classifier using petal and sepal measurements. Trained on Fisher's iris dataset.",
        "keywords": "iris, flower, classification, botanical, species-identification",
        "task": "Classification - Tabular",
        "subtask": "Flora Identification",
        "algorithm": "Support Vector Machine",
        "endpoint": "/api/v1/classification/iris",
        "input_features": {
            "fields": [
                {"name": "sepal_length", "type": "float", "required": True, "description": "Sepal length in cm"},
                {"name": "sepal_width", "type": "float", "required": True, "description": "Sepal width in cm"},
                {"name": "petal_length", "type": "float", "required": True, "description": "Petal length in cm"},
                {"name": "petal_width", "type": "float", "required": True, "description": "Petal width in cm"}
            ]
        }
    },
    {
        "id": "asset-flora-flower",
        "name": "Flower Classifier",
        "description": "General flower species classifier based on morphological features. Multi-species support.",
        "keywords": "flower, classification, botanical, species, morphology",
        "task": "Classification - Tabular",
        "subtask": "Flora Identification",
        "algorithm": "Decision Tree",
        "endpoint": "/api/v1/classification/flower",
        "input_features": {
            "fields": [
                {"name": "sepal_length", "type": "float", "required": True, "description": "Sepal length in cm"},
                {"name": "sepal_width", "type": "float", "required": True, "description": "Sepal width in cm"},
                {"name": "petal_length", "type": "float", "required": True, "description": "Petal length in cm"},
                {"name": "petal_width", "type": "float", "required": True, "description": "Petal width in cm"}
            ]
        }
    },
    {
        "id": "asset-flora-plant",
        "name": "Plant Classifier",
        "description": "Plant species identification model using leaf and flower measurements. Botanical taxonomy support.",
        "keywords": "plant, botanical, classification, species, taxonomy",
        "task": "Classification - Tabular",
        "subtask": "Flora Identification",
        "algorithm": "K-Nearest Neighbors",
        "endpoint": "/api/v1/classification/plant",
        "input_features": {
            "fields": [
                {"name": "sepal_length", "type": "float", "required": True, "description": "Sepal length in cm"},
                {"name": "sepal_width", "type": "float", "required": True, "description": "Sepal width in cm"},
                {"name": "petal_length", "type": "float", "required": True, "description": "Petal length in cm"},
                {"name": "petal_width", "type": "float", "required": True, "description": "Petal width in cm"}
            ]
        }
    },
    {
        "id": "asset-flora-botanical",
        "name": "Botanical Classifier",
        "description": "Advanced botanical classification model for scientific plant identification and research.",
        "keywords": "botanical, classification, scientific, plant-research, taxonomy",
        "task": "Classification - Tabular",
        "subtask": "Flora Identification",
        "algorithm": "Random Forest",
        "endpoint": "/api/v1/classification/botanical",
        "input_features": {
            "fields": [
                {"name": "sepal_length", "type": "float", "required": True, "description": "Sepal length in cm"},
                {"name": "sepal_width", "type": "float", "required": True, "description": "Sepal width in cm"},
                {"name": "petal_length", "type": "float", "required": True, "description": "Petal length in cm"},
                {"name": "petal_width", "type": "float", "required": True, "description": "Petal width in cm"}
            ]
        }
    },
    {
        "id": "asset-flora-recognition",
        "name": "Flora Recognition System",
        "description": "Comprehensive flora recognition using morphological features. Educational and research applications.",
        "keywords": "flora, recognition, botanical, education, biodiversity",
        "task": "Classification - Tabular",
        "subtask": "Flora Identification",
        "algorithm": "Gradient Boosting Classifier",
        "endpoint": "/api/v1/classification/flora-recognition",
        "input_features": {
            "fields": [
                {"name": "sepal_length", "type": "float", "required": True, "description": "Sepal length in cm"},
                {"name": "sepal_width", "type": "float", "required": True, "description": "Sepal width in cm"},
                {"name": "petal_length", "type": "float", "required": True, "description": "Petal length in cm"},
                {"name": "petal_width", "type": "float", "required": True, "description": "Petal width in cm"}
            ]
        }
    },
    
    # Group 5: Fraud Detection (Classification - Transactional Data)
    {
        "id": "asset-fraud-transaction",
        "name": "Transaction Fraud Checker",
        "description": "Real-time fraud detection for financial transactions. Analyzes patterns and flags suspicious activity.",
        "keywords": "fraud, transaction, finance, security, anomaly-detection",
        "task": "Classification - Tabular",
        "subtask": "Fraud Detection",
        "algorithm": "XGBoost",
        "endpoint": "/api/v1/fraud/transaction",
        "input_features": {
            "fields": [
                {"name": "amount", "type": "float", "required": True, "description": "Transaction amount in currency units"},
                {"name": "merchant_category", "type": "string", "required": True, "description": "Merchant category code"},
                {"name": "location", "type": "string", "required": True, "description": "Transaction location"},
               {"name": "timestamp", "type": "string", "required": True, "description": "Transaction timestamp ISO format"}
            ]
        }
    },
    {
        "id": "asset-fraud-creditcard",
        "name": "Credit Card Fraud Detector",
        "description": "Specialized fraud detection for credit card transactions. High accuracy and low false positive rate.",
        "keywords": "creditcard, fraud, payment, security, banking",
        "task": "Classification - Tabular",
        "subtask": "Fraud Detection",
        "algorithm": "Neural Network",
        "endpoint": "/api/v1/fraud/credit-card",
        "input_features": {
            "fields": [
                {"name": "amount", "type": "float", "required": True, "description": "Transaction amount in currency units"},
                {"name": "merchant_category", "type": "string", "required": True, "description": "Merchant category code"},
                {"name": "location", "type": "string", "required": True, "description": "Transaction location"},
                {"name": "timestamp", "type": "string", "required": True, "description": "Transaction timestamp ISO format"}
            ]
        }
    },
    {
        "id": "asset-fraud-anomaly",
        "name": "Transaction Anomaly Detector",
        "description": "ML model for detecting anomalous transaction patterns. Unsupervised learning approach.",
        "keywords": "anomaly, fraud, transaction, outlier-detection, security",
        "task": "Classification - Tabular",
        "subtask": "Fraud Detection",
        "algorithm": "Isolation Forest",
        "endpoint": "/api/v1/fraud/anomaly",
        "input_features": {
            "fields": [
                {"name": "amount", "type": "float", "required": True, "description": "Transaction amount in currency units"},
                {"name": "merchant_category", "type": "string", "required": True, "description": "Merchant category code"},
                {"name": "location", "type": "string", "required": True, "description": "Transaction location"},
                {"name": "timestamp", "type": "string", "required": True, "description": "Transaction timestamp ISO format"}
            ]
        }
    },
    {
        "id": "asset-fraud-risk-scorer",
        "name": "Fraud Risk Scorer",
        "description": "Assigns fraud risk scores to transactions for manual review pipeline. Configurable thresholds.",
        "keywords": "fraud, risk-score, transaction, assessment, security",
        "task": "Classification - Tabular",
        "subtask": "Fraud Detection",
        "algorithm": "Logistic Regression",
        "endpoint": "/api/v1/fraud/risk-scorer",
        "input_features": {
            "fields": [
                {"name": "amount", "type": "float", "required": True, "description": "Transaction amount in currency units"},
                {"name": "merchant_category", "type": "string", "required": True, "description": "Merchant category code"},
                {"name": "location", "type": "string", "required": True, "description": "Transaction location"},
                {"name": "timestamp", "type": "string", "required": True, "description": "Transaction timestamp ISO format"}
            ]
        }
    },
    {
        "id": "asset-fraud-classifier",
        "name": "Binary Fraud Classifier",
        "description": "Simple binary classifier for fraud vs legitimate transactions. High-speed inference.",
        "keywords": "fraud, binary-classification, transaction, finance, security",
        "task": "Classification - Tabular",
        "subtask": "Fraud Detection",
        "algorithm": "LightGBM",
        "endpoint": "/api/v1/fraud/fraud-classifier",
        "input_features": {
            "fields": [
                {"name": "amount", "type": "float", "required": True, "description": "Transaction amount in currency units"},
                {"name": "merchant_category", "type": "string", "required": True, "description": "Merchant category code"},
                {"name": "location", "type": "string", "required": True, "description": "Transaction location"},
                {"name": "timestamp", "type": "string", "required": True, "description": "Transaction timestamp ISO format"}
            ]
        }
    }
]

import json

print("-- ====================================================================")
print("-- 25 HTTP Models for Benchmarking - Correct Database Schema")
print("-- Generated: 2026-02-10")
print("-- Compatible with AIModelHub database structure")
print("-- ====================================================================\n")

for model in models:
    asset_id = model["id"]
    name = model["name"]
    description = model["description"]
    keywords = model["keywords"]
    task = model["task"]
    subtask = model["subtask"]
    algorithm = model["algorithm"]
    endpoint = model["endpoint"]
    input_features_json = json.dumps(model["input_features"], indent=2)
    
    print(f"""
-- {name}
-- {"-" * len(name)}
    
-- Insert asset
INSERT INTO assets (id, name, version, content_type, description, keywords, asset_type, owner)
VALUES (
    '{asset_id}',
    '{name}',
    '1.0',
    'application/json',
    '{description}',
    '{keywords}',
    'MLModel',
    'conn-user1-demo'
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    keywords = EXCLUDED.keywords;

-- Insert data address (HTTP endpoint)
INSERT INTO data_addresses (asset_id, type, endpoint_override)
VALUES (
    '{asset_id}',
    'HttpData',
    '{endpoint}'
)
ON CONFLICT DO NOTHING;

-- Insert ML metadata
INSERT INTO ml_metadata (asset_id, task, subtask, algorithm, input_features)
VALUES (
    '{asset_id}',
    '{task}',
    '{subtask}',
    '{algorithm}',
    '{input_features_json}'::jsonb
)
ON CONFLICT (asset_id) DO UPDATE SET
    task = EXCLUDED.task,
    subtask = EXCLUDED.subtask,
    algorithm = EXCLUDED.algorithm,
    input_features = EXCLUDED.input_features;
""")

print("""
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
""")
