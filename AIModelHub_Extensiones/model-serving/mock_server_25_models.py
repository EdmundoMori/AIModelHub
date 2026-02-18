"""
Mock AI Model Server - 25 Models Edition
========================================

Servidor mock con 25 modelos organizados en 5 grupos:
- Grupo 1: Computer Vision - Medical Imaging (5 modelos)
- Grupo 2: NLP - Sentiment Analysis (5 modelos)
- Grupo 3: Regression - Health Metrics (5 modelos)
- Grupo 4: Tabular Classification - Iris-like (5 modelos)
- Grupo 5: Fraud Detection - Transactional (5 modelos)

Cada grupo comparte el mismo esquema de input para benchmarking comparativo.

Puerto: 8080
"""

from flask import Flask, request, jsonify, render_template_string
from flask_cors import CORS
from datetime import datetime
import time
import random
import json

app = Flask(__name__)
CORS(app)

execution_log = []

# ============================================================================
# GRUPO 1: COMPUTER VISION - MEDICAL IMAGING
# Input: image_url (string), image_size (string)
# ============================================================================

def chest_xray_classifier(data):
    """Chest X-Ray Classifier - Classifies chest X-rays"""
    time.sleep(random.uniform(0.8, 1.5))
    conditions = ['Normal', 'Pneumonia', 'COVID-19', 'Tuberculosis', 'Lung Cancer']
    predicted = random.choice(conditions)
    confidence = random.uniform(0.75, 0.95)
    
    return {
        'model': 'Chest X-Ray Classifier',
        'prediction': predicted,
        'confidence': round(confidence, 3),
        'processing_time_ms': round(random.uniform(800, 1500), 2)
    }

def pneumonia_detector(data):
    """Pneumonia Detection API - Detects pneumonia in lung images"""
    time.sleep(random.uniform(0.7, 1.4))
    result = random.choice(['No_Pneumonia', 'Bacterial_Pneumonia', 'Viral_Pneumonia'])
    confidence = random.uniform(0.78, 0.96)
    
    return {
        'model': 'Pneumonia Detector',
        'prediction': result,
        'confidence': round(confidence, 3),
        'severity': random.choice(['Mild', 'Moderate', 'Severe']) if 'Pneumonia' in result else 'None',
        'processing_time_ms': round(random.uniform(700, 1400), 2)
    }

def covid19_screener(data):
    """COVID-19 Screening API - Screens for COVID-19 from medical images"""
    time.sleep(random.uniform(0.9, 1.6))
    result = random.choice(['Negative', 'Positive', 'Probable'])
    confidence = random.uniform(0.72, 0.94)
    
    return {
        'model': 'COVID-19 Screener',
        'prediction': result,
        'confidence': round(confidence, 3),
        'recommendation': 'PCR test recommended' if result != 'Negative' else 'No further action needed',
        'processing_time_ms': round(random.uniform(900, 1600), 2)
    }

def lung_nodule_detector(data):
    """Lung Nodule Detector API - Detects and classifies lung nodules"""
    time.sleep(random.uniform(1.0, 1.7))
    has_nodule = random.choice([True, False])
    nodule_type = random.choice(['Benign', 'Malignant', 'Indeterminate']) if has_nodule else 'None'
    confidence = random.uniform(0.76, 0.93)
    
    return {
        'model': 'Lung Nodule Detector',
        'has_nodule': has_nodule,
        'nodule_type': nodule_type,
        'confidence': round(confidence, 3),
        'risk_score': round(random.uniform(0.1, 0.9), 2) if has_nodule else 0.0,
        'processing_time_ms': round(random.uniform(1000, 1700), 2)
    }

def tuberculosis_classifier(data):
    """Tuberculosis Classifier API - Classifies TB presence"""
    time.sleep(random.uniform(0.8, 1.5))
    result = random.choice(['Normal', 'TB_Active', 'TB_Latent', 'TB_Suspected'])
    confidence = random.uniform(0.74, 0.92)
    
    return {
        'model': 'Tuberculosis Classifier',
        'prediction': result,
        'confidence': round(confidence, 3),
        'follow_up': 'Sputum test recommended' if 'TB' in result else 'None',
        'processing_time_ms': round(random.uniform(800, 1500), 2)
    }

# ============================================================================
# GRUPO 2: NLP - SENTIMENT ANALYSIS
# Input: text (string)
# ============================================================================

def ecommerce_sentiment(data):
    """E-commerce Review Sentiment API - Analyzes product reviews"""
    time.sleep(random.uniform(0.3, 0.8))
    text = data.get('text', '')
    
    positive_words = ['good', 'great', 'excellent', 'love', 'amazing']
    negative_words = ['bad', 'terrible', 'hate', 'awful', 'horrible']
    
    pos_count = sum(word in text.lower() for word in positive_words)
    neg_count = sum(word in text.lower() for word in negative_words)
    
    if pos_count > neg_count:
        sentiment = 'positive'
        score = random.uniform(0.7, 0.95)
    elif neg_count > pos_count:
        sentiment = 'negative'
        score = random.uniform(0.7, 0.95)
    else:
        sentiment = 'neutral'
        score = random.uniform(0.45, 0.65)
    
    return {
        'model': 'E-commerce Sentiment Analyzer',
        'sentiment': sentiment,
        'confidence': round(score, 3),
        'rating_prediction': round(random.uniform(1, 5), 1),
        'processing_time_ms': round(random.uniform(300, 800), 2)
    }

def twitter_sentiment(data):
    """Twitter Sentiment Analyzer API - Analyzes social media sentiment"""
    time.sleep(random.uniform(0.2, 0.7))
    sentiments = ['positive', 'negative', 'neutral']
    sentiment = random.choice(sentiments)
    confidence = random.uniform(0.68, 0.92)
    
    return {
        'model': 'Twitter Sentiment Analyzer',
        'sentiment': sentiment,
        'confidence': round(confidence, 3),
        'emotion': random.choice(['joy', 'anger', 'sadness', 'surprise', 'neutral']),
        'processing_time_ms': round(random.uniform(200, 700), 2)
    }

def product_review_classifier(data):
    """Product Review Classifier API - Classifies product reviews"""
    time.sleep(random.uniform(0.3, 0.9))
    sentiment = random.choice(['very_positive', 'positive', 'neutral', 'negative', 'very_negative'])
    confidence = random.uniform(0.71, 0.94)
    
    return {
        'model': 'Product Review Classifier',
        'sentiment': sentiment,
        'confidence': round(confidence, 3),
        'star_rating': round(random.uniform(1, 5), 1),
        'processing_time_ms': round(random.uniform(300, 900), 2)
    }

def customer_feedback_analyzer(data):
    """Customer Feedback Analyzer API - Analyzes customer feedback"""
    time.sleep(random.uniform(0.4, 0.9))
    sentiment = random.choice(['satisfied', 'dissatisfied', 'neutral'])
    confidence = random.uniform(0.69, 0.93)
    
    return {
        'model': 'Customer Feedback Analyzer',
        'sentiment': sentiment,
        'confidence': round(confidence, 3),
        'satisfaction_score': round(random.uniform(0, 100), 1),
        'action_required': random.choice([True, False]),
        'processing_time_ms': round(random.uniform(400, 900), 2)
    }

def social_media_sentiment(data):
    """Social Media Sentiment API - General social media sentiment"""
    time.sleep(random.uniform(0.3, 0.8))
    sentiment = random.choice(['positive', 'negative', 'neutral', 'mixed'])
    confidence = random.uniform(0.70, 0.91)
    
    return {
        'model': 'Social Media Sentiment',
        'sentiment': sentiment,
        'confidence': round(confidence, 3),
        'virality_score': round(random.uniform(0, 100), 1),
        'engagement_prediction': random.choice(['High', 'Medium', 'Low']),
        'processing_time_ms': round(random.uniform(300, 800), 2)
    }

# ============================================================================
# GRUPO 3: REGRESSION - HEALTH METRICS
# Input: weight_kg (float), height_m (float)
# ============================================================================

def bmi_calculator(data):
    """BMI Calculator - Calculates Body Mass Index"""
    time.sleep(random.uniform(0.2, 0.5))
    weight_kg = data.get('weight_kg', 70.0)
    height_m = data.get('height_m', 1.75)
    
    bmi = weight_kg / (height_m ** 2)
    
    if bmi < 18.5:
        category = 'Underweight'
    elif bmi < 25:
        category = 'Normal'
    elif bmi < 30:
        category = 'Overweight'
    else:
        category = 'Obese'
    
    return {
        'model': 'BMI Calculator',
        'bmi': round(bmi, 2),
        'category': category,
        'weight_kg': weight_kg,
        'height_m': height_m,
        'processing_time_ms': round(random.uniform(200, 500), 2)
    }

def body_fat_estimator(data):
    """Body Fat Percentage Estimator API - Estimates body fat percentage"""
    time.sleep(random.uniform(0.3, 0.6))
    weight_kg = data.get('weight_kg', 70.0)
    height_m = data.get('height_m', 1.75)
    
    bmi = weight_kg / (height_m ** 2)
    body_fat = (1.20 * bmi) + (0.23 * 30) - 5.4  # Simplified formula
    body_fat = max(5, min(50, body_fat))
    
    return {
        'model': 'Body Fat Estimator',
        'body_fat_percentage': round(body_fat, 1),
        'category': 'Athletic' if body_fat < 20 else 'Average' if body_fat < 30 else 'High',
        'lean_mass_kg': round(weight_kg * (1 - body_fat/100), 1),
        'processing_time_ms': round(random.uniform(300, 600), 2)
    }

def bmr_calculator(data):
    """Basal Metabolic Rate Calculator API - Calculates daily calorie needs"""
    time.sleep(random.uniform(0.2, 0.5))
    weight_kg = data.get('weight_kg', 70.0)
    height_m = data.get('height_m', 1.75)
    
    height_cm = height_m * 100
    age = 30  # Assumed
    
    # Mifflin-St Jeor Equation (male)
    bmr = (10 * weight_kg) + (6.25 * height_cm) - (5 * age) + 5
    
    return {
        'model': 'BMR Calculator',
        'bmr_calories': round(bmr, 0),
        'sedentary': round(bmr * 1.2, 0),
        'moderate_activity': round(bmr * 1.55, 0),
        'very_active': round(bmr * 1.9, 0),
        'processing_time_ms': round(random.uniform(200, 500), 2)
    }

def ideal_weight_predictor(data):
    """Ideal Weight Predictor API - Predicts ideal weight"""
    time.sleep(random.uniform(0.3, 0.6))
    height_m = data.get('height_m', 1.75)
    
    # Hamwi formula (male)
    ideal_weight = 48 + 2.7 * (height_m * 100 - 152.4) / 2.54
    ideal_weight = max(45, min(120, ideal_weight))
    
    return {
        'model': 'Ideal Weight Predictor',
        'ideal_weight_kg': round(ideal_weight, 1),
        'healthy_range_min': round(ideal_weight * 0.9, 1),
        'healthy_range_max': round(ideal_weight * 1.1, 1),
        'processing_time_ms': round(random.uniform(300, 600), 2)
    }

def health_risk_assessor(data):
    """Health Risk Assessor API - Assesses health risks"""
    time.sleep(random.uniform(0.4, 0.7))
    weight_kg = data.get('weight_kg', 70.0)
    height_m = data.get('height_m', 1.75)
    
    bmi = weight_kg / (height_m ** 2)
    
    risk_score = 0
    if bmi < 18.5:
        risk_score = 30
    elif bmi < 25:
        risk_score = 10
    elif bmi < 30:
        risk_score = 40
    else:
        risk_score = 70
    
    return {
        'model': 'Health Risk Assessor',
        'risk_score': risk_score,
        'risk_level': 'Low' if risk_score < 30 else 'Moderate' if risk_score < 50 else 'High',
        'recommendations': ['Maintain healthy diet', 'Regular exercise', 'Annual checkup'],
        'processing_time_ms': round(random.uniform(400, 700), 2)
    }

# ============================================================================
# GRUPO 4: TABULAR CLASSIFICATION - IRIS-LIKE
# Input: sepal_length, sepal_width, petal_length, petal_width (floats)
# ============================================================================

def iris_classifier(data):
    """Iris Species Classifier API - Classifies iris flowers"""
    time.sleep(random.uniform(0.4, 0.9))
    petal_length = data.get('petal_length', 4.0)
    
    if petal_length < 2.5:
        species = 'setosa'
    elif petal_length < 5.0:
        species = 'versicolor'
    else:
        species = 'virginica'
    
    confidence = random.uniform(0.85, 0.98)
    
    return {
        'model': 'Iris Classifier',
        'prediction': species,
        'confidence': round(confidence, 3),
        'processing_time_ms': round(random.uniform(400, 900), 2)
    }

def flower_type_classifier(data):
    """Flower Type Classifier API - Classifies flower types"""
    time.sleep(random.uniform(0.5, 1.0))
    flowers = ['Rose', 'Tulip', 'Sunflower', 'Daisy', 'Lily']
    prediction = random.choice(flowers)
    confidence = random.uniform(0.82, 0.96)
    
    return {
        'model': 'Flower Type Classifier',
        'prediction': prediction,
        'confidence': round(confidence, 3),
        'color_prediction': random.choice(['Red', 'Yellow', 'White', 'Pink', 'Purple']),
        'processing_time_ms': round(random.uniform(500, 1000), 2)
    }

def plant_species_identifier(data):
    """Plant Species Identifier API - Identifies plant species"""
    time.sleep(random.uniform(0.6, 1.1))
    species = ['Ficus', 'Monstera', 'Pothos', 'Snake Plant', 'Peace Lily']
    prediction = random.choice(species)
    confidence = random.uniform(0.79, 0.94)
    
    return {
        'model': 'Plant Species Identifier',
        'prediction': prediction,
        'confidence': round(confidence, 3),
        'care_difficulty': random.choice(['Easy', 'Moderate', 'Difficult']),
        'processing_time_ms': round(random.uniform(600, 1100), 2)
    }

def botanical_classifier(data):
    """Botanical Classifier API - Botanical classification"""
    time.sleep(random.uniform(0.5, 1.0))
    families = ['Rosaceae', 'Asteraceae', 'Fabaceae', 'Lamiaceae', 'Solanaceae']
    prediction = random.choice(families)
    confidence = random.uniform(0.81, 0.95)
    
    return {
        'model': 'Botanical Classifier',
        'family': prediction,
        'confidence': round(confidence, 3),
        'genus_count': random.randint(50, 500),
        'processing_time_ms': round(random.uniform(500, 1000), 2)
    }

def flora_recognition(data):
    """Flora Recognition API - General flora recognition"""
    time.sleep(random.uniform(0.5, 1.0))
    categories = ['Flowering Plant', 'Conifer', 'Fern', 'Succulent', 'Grass']
    prediction = random.choice(categories)
    confidence = random.uniform(0.83, 0.97)
    
    return {
        'model': 'Flora Recognition',
        'category': prediction,
        'confidence': round(confidence, 3),
        'edible': random.choice([True, False]),
        'processing_time_ms': round(random.uniform(500, 1000), 2)
    }

# ============================================================================
# GRUPO 5: FR AUD DETECTION - TRANSACTIONAL
# Input: amount, merchant_category, location, timestamp (mixed)
# ============================================================================

def fraud_detector(data):
    """Real-Time Transaction Fraud Detector API"""
    time.sleep(random.uniform(0.5, 1.0))
    amount = data.get('amount', 100.0)
    
    fraud_score = 0.0
    if amount > 1000:
        fraud_score += 0.3
    if data.get('location') == 'international':
        fraud_score += 0.2
    
    fraud_score += random.uniform(-0.1, 0.2)
    fraud_score = max(0.0, min(1.0, fraud_score))
    
    return {
        'model': 'Fraud Detector',
        'is_fraud': fraud_score > 0.5,
        'fraud_probability': round(fraud_score, 3),
        'risk_level': 'High' if fraud_score > 0.7 else 'Medium' if fraud_score > 0.4 else 'Low',
        'processing_time_ms': round(random.uniform(500, 1000), 2)
    }

def credit_card_fraud(data):
    """Credit Card Fraud Detector API"""
    time.sleep(random.uniform(0.5, 1.1))
    amount = data.get('amount', 100.0)
    
    fraud_score = random.uniform(0.1, 0.9)
    if amount > 2000:
        fraud_score = min(fraud_score + 0.2, 1.0)
    
    return {
        'model': 'Credit Card Fraud Detector',
        'is_fraud': fraud_score > 0.55,
        'fraud_score': round(fraud_score, 3),
        'decision': 'Block' if fraud_score > 0.8 else 'Review' if fraud_score > 0.5 else 'Approve',
        'processing_time_ms': round(random.uniform(500, 1100), 2)
    }

def payment_anomaly_detector(data):
    """Payment Anomaly Detector API"""
    time.sleep(random.uniform(0.4, 0.9))
    amount = data.get('amount', 100.0)
    
    anomaly_score = random.uniform(0.0, 1.0)
    is_anomaly = anomaly_score > 0.6
    
    return {
        'model': 'Payment Anomaly Detector',
        'is_anomaly': is_anomaly,
        'anomaly_score': round(anomaly_score, 3),
        'deviation_percentage': round(random.uniform(0, 150), 1),
        'processing_time_ms': round(random.uniform(400, 900), 2)
    }

def transaction_risk_scorer(data):
    """Transaction Risk Scorer API"""
    time.sleep(random.uniform(0.5, 1.0))
    amount = data.get('amount', 100.0)
    
    risk_score = random.uniform(0, 100)
    if amount > 5000:
        risk_score = min(risk_score + 30, 100)
    
    return {
        'model': 'Transaction Risk Scorer',
        'risk_score': round(risk_score, 1),
        'risk_band': 'Very High' if risk_score > 80 else 'High' if risk_score > 60 else 'Medium' if risk_score > 40 else 'Low',
        'recommended_action': 'Deny' if risk_score > 80 else 'Manual Review' if risk_score > 60 else 'Approve',
        'processing_time_ms': round(random.uniform(500, 1000), 2)
    }

def financial_fraud_classifier(data):
    """Financial Fraud Classifier API"""
    time.sleep(random.uniform(0.6, 1.2))
    
    fraud_types = ['Card Fraud', 'Identity Theft', 'Account Takeover', 'Legitimate', 'Suspicious']
    prediction = random.choice(fraud_types)
    confidence = random.uniform(0.75, 0.95)
    
    return {
        'model': 'Financial Fraud Classifier',
        'fraud_type': prediction,
        'confidence': round(confidence, 3),
        'requires_investigation': prediction != 'Legitimate',
        'processing_time_ms': round(random.uniform(600, 1200), 2)
    }

# ============================================================================
# API ENDPOINTS - 25 MODELS
# ============================================================================

# Grupo 1: Computer Vision
@app.route('/api/v1/vision/chest-xray', methods=['POST'])
def api_chest_xray():
    start = time.time()
    try:
        result = chest_xray_classifier(request.get_json())
        log_execution('Chest X-Ray Classifier', '/api/v1/vision/chest-xray', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Chest X-Ray Classifier', '/api/v1/vision/chest-xray', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/vision/pneumonia', methods=['POST'])
def api_pneumonia():
    start = time.time()
    try:
        result = pneumonia_detector(request.get_json())
        log_execution('Pneumonia Detector', '/api/v1/vision/pneumonia', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Pneumonia Detector', '/api/v1/vision/pneumonia', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/vision/covid19', methods=['POST'])
def api_covid19():
    start = time.time()
    try:
        result = covid19_screener(request.get_json())
        log_execution('COVID-19 Screener', '/api/v1/vision/covid19', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('COVID-19 Screener', '/api/v1/vision/covid19', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/vision/lung-nodule', methods=['POST'])
def api_lung_nodule():
    start = time.time()
    try:
        result = lung_nodule_detector(request.get_json())
        log_execution('Lung Nodule Detector', '/api/v1/vision/lung-nodule', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Lung Nodule Detector', '/api/v1/vision/lung-nodule', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/vision/tuberculosis', methods=['POST'])
def api_tuberculosis():
    start = time.time()
    try:
        result = tuberculosis_classifier(request.get_json())
        log_execution('Tuberculosis Classifier', '/api/v1/vision/tuberculosis', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Tuberculosis Classifier', '/api/v1/vision/tuberculosis', 'error', start)
        return jsonify({'error': str(e)}), 500

# Grupo 2: NLP Sentiment
@app.route('/api/v1/nlp/ecommerce-sentiment', methods=['POST'])
def api_ecommerce_sentiment():
    start = time.time()
    try:
        result = ecommerce_sentiment(request.get_json())
        log_execution('E-commerce Sentiment', '/api/v1/nlp/ecommerce-sentiment', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('E-commerce Sentiment', '/api/v1/nlp/ecommerce-sentiment', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/nlp/twitter-sentiment', methods=['POST'])
def api_twitter_sentiment():
    start = time.time()
    try:
        result = twitter_sentiment(request.get_json())
        log_execution('Twitter Sentiment', '/api/v1/nlp/twitter-sentiment', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Twitter Sentiment', '/api/v1/nlp/twitter-sentiment', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/nlp/product-review', methods=['POST'])
def api_product_review():
    start = time.time()
    try:
        result = product_review_classifier(request.get_json())
        log_execution('Product Review Classifier', '/api/v1/nlp/product-review', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Product Review Classifier', '/api/v1/nlp/product-review', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/nlp/customer-feedback', methods=['POST'])
def api_customer_feedback():
    start = time.time()
    try:
        result = customer_feedback_analyzer(request.get_json())
        log_execution('Customer Feedback Analyzer', '/api/v1/nlp/customer-feedback', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Customer Feedback Analyzer', '/api/v1/nlp/customer-feedback', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/nlp/social-media', methods=['POST'])
def api_social_media():
    start = time.time()
    try:
        result = social_media_sentiment(request.get_json())
        log_execution('Social Media Sentiment', '/api/v1/nlp/social-media', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Social Media Sentiment', '/api/v1/nlp/social-media', 'error', start)
        return jsonify({'error': str(e)}), 500

# Grupo 3: Health Regression
@app.route('/api/v1/health/bmi', methods=['POST'])
def api_bmi():
    start = time.time()
    try:
        result = bmi_calculator(request.get_json())
        log_execution('BMI Calculator', '/api/v1/health/bmi', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('BMI Calculator', '/api/v1/health/bmi', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/health/body-fat', methods=['POST'])
def api_body_fat():
    start = time.time()
    try:
        result = body_fat_estimator(request.get_json())
        log_execution('Body Fat Estimator', '/api/v1/health/body-fat', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Body Fat Estimator', '/api/v1/health/body-fat', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/health/bmr', methods=['POST'])
def api_bmr():
    start = time.time()
    try:
        result = bmr_calculator(request.get_json())
        log_execution('BMR Calculator', '/api/v1/health/bmr', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('BMR Calculator', '/api/v1/health/bmr', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/health/ideal-weight', methods=['POST'])
def api_ideal_weight():
    start = time.time()
    try:
        result = ideal_weight_predictor(request.get_json())
        log_execution('Ideal Weight Predictor', '/api/v1/health/ideal-weight', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Ideal Weight Predictor', '/api/v1/health/ideal-weight', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/health/risk-assessment', methods=['POST'])
def api_health_risk():
    start = time.time()
    try:
        result = health_risk_assessor(request.get_json())
        log_execution('Health Risk Assessor', '/api/v1/health/risk-assessment', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Health Risk Assessor', '/api/v1/health/risk-assessment', 'error', start)
        return jsonify({'error': str(e)}), 500

# Grupo 4: Tabular Classification
@app.route('/api/v1/classification/iris', methods=['POST'])
def api_iris():
    start = time.time()
    try:
        result = iris_classifier(request.get_json())
        log_execution('Iris Classifier', '/api/v1/classification/iris', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Iris Classifier', '/api/v1/classification/iris', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/classification/flower', methods=['POST'])
def api_flower():
    start = time.time()
    try:
        result = flower_type_classifier(request.get_json())
        log_execution('Flower Type Classifier', '/api/v1/classification/flower', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Flower Type Classifier', '/api/v1/classification/flower', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/classification/plant', methods=['POST'])
def api_plant():
    start = time.time()
    try:
        result = plant_species_identifier(request.get_json())
        log_execution('Plant Species Identifier', '/api/v1/classification/plant', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Plant Species Identifier', '/api/v1/classification/plant', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/classification/botanical', methods=['POST'])
def api_botanical():
    start = time.time()
    try:
        result = botanical_classifier(request.get_json())
        log_execution('Botanical Classifier', '/api/v1/classification/botanical', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Botanical Classifier', '/api/v1/classification/botanical', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/classification/flora', methods=['POST'])
def api_flora():
    start = time.time()
    try:
        result = flora_recognition(request.get_json())
        log_execution('Flora Recognition', '/api/v1/classification/flora', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Flora Recognition', '/api/v1/classification/flora', 'error', start)
        return jsonify({'error': str(e)}), 500

# Grupo 5: Fraud Detection
@app.route('/api/v1/fraud/transaction', methods=['POST'])
def api_fraud_transaction():
    start = time.time()
    try:
        result = fraud_detector(request.get_json())
        log_execution('Fraud Detector', '/api/v1/fraud/transaction', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Fraud Detector', '/api/v1/fraud/transaction', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/fraud/credit-card', methods=['POST'])
def api_credit_card():
    start = time.time()
    try:
        result = credit_card_fraud(request.get_json())
        log_execution('Credit Card Fraud', '/api/v1/fraud/credit-card', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Credit Card Fraud', '/api/v1/fraud/credit-card', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/fraud/anomaly', methods=['POST'])
def api_anomaly():
    start = time.time()
    try:
        result = payment_anomaly_detector(request.get_json())
        log_execution('Payment Anomaly Detector', '/api/v1/fraud/anomaly', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Payment Anomaly Detector', '/api/v1/fraud/anomaly', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/fraud/risk-scorer', methods=['POST'])
def api_risk_scorer():
    start = time.time()
    try:
        result = transaction_risk_scorer(request.get_json())
        log_execution('Transaction Risk Scorer', '/api/v1/fraud/risk-scorer', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Transaction Risk Scorer', '/api/v1/fraud/risk-scorer', 'error', start)
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/fraud/classifier', methods=['POST'])
def api_fraud_classifier():
    start = time.time()
    try:
        result = financial_fraud_classifier(request.get_json())
        log_execution('Financial Fraud Classifier', '/api/v1/fraud/classifier', 'success', start)
        return jsonify(result), 200
    except Exception as e:
        log_execution('Financial Fraud Classifier', '/api/v1/fraud/classifier', 'error', start)
        return jsonify({'error': str(e)}), 500

def log_execution(model, endpoint, status, start_time):
    """Helper to log executions"""
    execution_log.append({
        'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        'model': model,
        'endpoint': endpoint,
        'status': status,
        'duration': round((time.time() - start_time) * 1000, 2)
    })
    # Keep only last 100 executions
    if len(execution_log) > 100:
        execution_log.pop(0)

@app.route('/')
def dashboard():
    """Dashboard showing all 25 models"""
    html = """
    <!DOCTYPE html>
    <html>
    <head>
        <title>🤖 AI Model Server - 25 Models Dashboard</title>
        <meta charset="utf-8">
        <style>
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body {
                font-family: system-ui, -apple-system, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                padding: 20px;
                color: #333;
            }
            .container { max-width: 1400px; margin: 0 auto; }
            .header {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                margin-bottom: 30px;
                text-align: center;
            }
            .header h1 { color: #667eea; font-size: 2.5rem; }
            .status {
                display: inline-block;
                background: #10b981;
                color: white;
                padding: 8px 20px;
                border-radius: 20px;
                font-weight: 600;
                margin-top: 10px;
            }
            .stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }
            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
            .stat-card .number {
                font-size: 2rem;
                font-weight: bold;
                color: #667eea;
            }
            .groups-section {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }
            .group {
                margin-bottom: 40px;
            }
            .group h2 {
                color: #667eea;
                margin-bottom: 15px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e5e7eb;
            }
            .models-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 15px;
                margin-top: 15px;
            }
            .model-card {
                border: 2px solid #e5e7eb;
                padding: 15px;
                border-radius: 8px;
                transition: all 0.3s;
            }
            .model-card:hover {
                border-color: #667eea;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102,126,234,0.2);
            }
            .model-card h3 {
                font-size: 1rem;
                margin-bottom: 8px;
                color: #333;
            }
            .endpoint {
                background: #f3f4f6;
                padding: 6px 10px;
                border-radius: 5px;
                font-family: monospace;
                font-size: 0.75rem;
                color: #667eea;
                margin-top: 8px;
                word-break: break-all;
            }
            .refresh-btn {
                background: #667eea;
                color: white;
                border: none;
                padding: 12px 30px;
                border-radius: 8px;
                font-size: 1rem;
                cursor: pointer;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>🤖 AI Model Server</h1>
                <p style="color: #666;">25 Mock Models for Benchmarking</p>
                <div class="status">● ONLINE</div>
            </div>
            
            <div class="stats">
                <div class="stat-card">
                    <div class="number">25</div>
                    <div style="color: #666; font-size: 0.9rem;">Available Models</div>
                </div>
                <div class="stat-card">
                    <div class="number">5</div>
                    <div style="color: #666; font-size: 0.9rem;">Model Groups</div>
                </div>
                <div class="stat-card">
                    <div class="number">{{ total_requests }}</div>
                    <div style="color: #666; font-size: 0.9rem;">Total Requests</div>
                </div>
                <div class="stat-card">
                    <div class="number">8080</div>
                    <div style="color: #666; font-size: 0.9rem;">Server Port</div>
                </div>
            </div>
            
            <div class="groups-section">
                <div class="group">
                    <h2>👁️ Group 1: Medical Imaging (Computer Vision)</h2>
                    <p style="color: #666; margin-bottom: 10px;">Input: image_url, image_size</p>
                    <div class="models-grid">
                        <div class="model-card">
                            <h3>Chest X-Ray Classifier</h3>
                            <div class="endpoint">POST /api/v1/vision/chest-xray</div>
                        </div>
                        <div class="model-card">
                            <h3>Pneumonia Detector</h3>
                            <div class="endpoint">POST /api/v1/vision/pneumonia</div>
                        </div>
                        <div class="model-card">
                            <h3>COVID-19 Screener</h3>
                            <div class="endpoint">POST /api/v1/vision/covid19</div>
                        </div>
                        <div class="model-card">
                            <h3>Lung Nodule Detector</h3>
                            <div class="endpoint">POST /api/v1/vision/lung-nodule</div>
                        </div>
                        <div class="model-card">
                            <h3>Tuberculosis Classifier</h3>
                            <div class="endpoint">POST /api/v1/vision/tuberculosis</div>
                        </div>
                    </div>
                </div>
                
                <div class="group">
                    <h2>💭 Group 2: Sentiment Analysis (NLP)</h2>
                    <p style="color: #666; margin-bottom: 10px;">Input: text</p>
                    <div class="models-grid">
                        <div class="model-card">
                            <h3>E-commerce Sentiment</h3>
                            <div class="endpoint">POST /api/v1/nlp/ecommerce-sentiment</div>
                        </div>
                        <div class="model-card">
                            <h3>Twitter Sentiment</h3>
                            <div class="endpoint">POST /api/v1/nlp/twitter-sentiment</div>
                        </div>
                        <div class="model-card">
                            <h3>Product Review Classifier</h3>
                            <div class="endpoint">POST /api/v1/nlp/product-review</div>
                        </div>
                        <div class="model-card">
                            <h3>Customer Feedback Analyzer</h3>
                            <div class="endpoint">POST /api/v1/nlp/customer-feedback</div>
                        </div>
                        <div class="model-card">
                            <h3>Social Media Sentiment</h3>
                            <div class="endpoint">POST /api/v1/nlp/social-media</div>
                        </div>
                    </div>
                </div>
                
                <div class="group">
                    <h2>⚖️ Group 3: Health Metrics (Regression)</h2>
                    <p style="color: #666; margin-bottom: 10px;">Input: weight_kg, height_m</p>
                    <div class="models-grid">
                        <div class="model-card">
                            <h3>BMI Calculator</h3>
                            <div class="endpoint">POST /api/v1/health/bmi</div>
                        </div>
                        <div class="model-card">
                            <h3>Body Fat Estimator</h3>
                            <div class="endpoint">POST /api/v1/health/body-fat</div>
                        </div>
                        <div class="model-card">
                            <h3>BMR Calculator</h3>
                            <div class="endpoint">POST /api/v1/health/bmr</div>
                        </div>
                        <div class="model-card">
                            <h3>Ideal Weight Predictor</h3>
                            <div class="endpoint">POST /api/v1/health/ideal-weight</div>
                        </div>
                        <div class="model-card">
                            <h3>Health Risk Assessor</h3>
                            <div class="endpoint">POST /api/v1/health/risk-assessment</div>
                        </div>
                    </div>
                </div>
                
                <div class="group">
                    <h2>🌸 Group 4: Flora Classification (Tabular)</h2>
                    <p style="color: #666; margin-bottom: 10px;">Input: sepal_length, sepal_width, petal_length, petal_width</p>
                    <div class="models-grid">
                        <div class="model-card">
                            <h3>Iris Classifier</h3>
                            <div class="endpoint">POST /api/v1/classification/iris</div>
                        </div>
                        <div class="model-card">
                            <h3>Flower Type Classifier</h3>
                            <div class="endpoint">POST /api/v1/classification/flower</div>
                        </div>
                        <div class="model-card">
                            <h3>Plant Species Identifier</h3>
                            <div class="endpoint">POST /api/v1/classification/plant</div>
                        </div>
                        <div class="model-card">
                            <h3>Botanical Classifier</h3>
                            <div class="endpoint">POST /api/v1/classification/botanical</div>
                        </div>
                        <div class="model-card">
                            <h3>Flora Recognition</h3>
                            <div class="endpoint">POST /api/v1/classification/flora</div>
                        </div>
                    </div>
                </div>
                
                <div class="group">
                    <h2>🔒 Group 5: Fraud Detection (Transactional)</h2>
                    <p style="color: #666; margin-bottom: 10px;">Input: amount, merchant_category, location, timestamp</p>
                    <div class="models-grid">
                        <div class="model-card">
                            <h3>Fraud Detector</h3>
                            <div class="endpoint">POST /api/v1/fraud/transaction</div>
                        </div>
                        <div class="model-card">
                            <h3>Credit Card Fraud</h3>
                            <div class="endpoint">POST /api/v1/fraud/credit-card</div>
                        </div>
                        <div class="model-card">
                            <h3>Payment Anomaly Detector</h3>
                            <div class="endpoint">POST /api/v1/fraud/anomaly</div>
                        </div>
                        <div class="model-card">
                            <h3>Transaction Risk Scorer</h3>
                            <div class="endpoint">POST /api/v1/fraud/risk-scorer</div>
                        </div>
                        <div class="model-card">
                            <h3>Financial Fraud Classifier</h3>
                            <div class="endpoint">POST /api/v1/fraud/classifier</div>
                        </div>
                    </div>
                </div>
                
                <button class="refresh-btn" onclick="location.reload()">🔄 Refresh Dashboard</button>
            </div>
        </div>
        <script>
            setTimeout(() => location.reload(), 10000);
        </script>
    </body>
    </html>
    """
    return render_template_string(html, total_requests=len(execution_log))

@app.route('/api/v1/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'models': 25,
        'groups': 5,
        'total_requests': len(execution_log),
        'timestamp': datetime.now().isoformat()
    }), 200

if __name__ == '__main__':
    print("=" * 80)
    print("🤖 AI Model Mock Server - 25 Models Edition")
    print("=" * 80)
    print(f"📊 Dashboard: http://localhost:8080")
    print(f"🔥 25 Models Ready for Benchmarking!")
    print(f"")
    print(f"📁 Model Groups:")
    print(f"   1️⃣  Medical Imaging (5 models) - Vision")
    print(f"   2️⃣  Sentiment Analysis (5 models) - NLP")
    print(f"   3️⃣  Health Metrics (5 models) - Regression")
    print(f"   4️⃣  Flora Classification (5 models) - Tabular")
    print(f"   5️⃣  Fraud Detection (5 models) - Transactional")
    print("=" * 80)
    print("✨ Server ready!")
    print("=" * 80)
    
    app.run(host='0.0.0.0', port=8080, debug=False)
