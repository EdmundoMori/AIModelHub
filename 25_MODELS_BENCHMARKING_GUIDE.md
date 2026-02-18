# 25 HTTP Models Benchmarking Guide

## 📊 Overview

The AI Model Hub now includes a comprehensive benchmarking system with **25 HTTP models** organized into **5 coherent groups**. Each group contains 5 models that share identical input schemas, enabling fair comparative benchmarking.

## 🎯 Model Groups

### 1️⃣ **Medical Imaging (Vision - X-Ray Analysis)**
All models accept: `image_url` (string), `image_size` (string)

| Model | Endpoint | Purpose |
|-------|----------|---------|
| Chest X-Ray Classifier | `/api/v1/vision/chest-xray` | Detect chest X-ray abnormalities |
| Pneumonia Detector | `/api/v1/vision/pneumonia` | Detect pneumonia in X-rays |
| COVID-19 Detector | `/api/v1/vision/covid19` | Detect COVID-19 in chest X-rays |
| Lung Nodule Detector | `/api/v1/vision/lung-nodule` | Detect lung nodules |
| Tuberculosis Detector | `/api/v1/vision/tuberculosis` | Detect tuberculosis in X-rays |

**Use Case**: Compare different medical imaging models on same diagnosis task

---

### 2️⃣ **Sentiment Analysis (NLP - Text Classification)**
All models accept: `text` (string)

| Model | Endpoint | Purpose |
|-------|----------|---------|
| E-commerce Sentiment | `/api/v1/nlp/ecommerce-sentiment` | Analyze product reviews |
| Twitter Sentiment | `/api/v1/nlp/twitter-sentiment` | Analyze social media posts |
| Product Review Analyzer | `/api/v1/nlp/product-review` | Analyze customer feedback |
| Customer Feedback | `/api/v1/nlp/customer-feedback` | Analyze service feedback |
| Social Media Analyzer | `/api/v1/nlp/social-media` | General social media sentiment |

**Use Case**: Compare sentiment analysis models across different domains

---

### 3️⃣ **Health Metrics (Regression - Body Measurements)**
All models accept: `weight_kg` (float), `height_m` (float)

| Model | Endpoint | Purpose |
|-------|----------|---------|
| BMI Calculator | `/api/v1/health/bmi` | Calculate Body Mass Index |
| Body Fat Estimator | `/api/v1/health/body-fat` | Estimate body fat percentage |
| BMR Calculator | `/api/v1/health/bmr` | Calculate Basal Metabolic Rate |
| Ideal Weight Predictor | `/api/v1/health/ideal-weight` | Predict ideal weight |
| Health Risk Scorer | `/api/v1/health/health-risk` | Calculate health risk score |

**Use Case**: Compare health metric algorithms on same physical data

---

### 4️⃣ **Flora Classification (Tabular - Iris Dataset Style)**
All models accept: `sepal_length`, `sepal_width`, `petal_length`, `petal_width` (floats)

| Model | Endpoint | Purpose |
|-------|----------|---------|
| Iris Classifier | `/api/v1/classification/iris` | Classic Iris classification |
| Flower Classifier | `/api/v1/classification/flower` | General flower classification |
| Plant Classifier | `/api/v1/classification/plant` | Plant species classification |
| Botanical Classifier | `/api/v1/classification/botanical` | Botanical classification |
| Flora Recognition | `/api/v1/classification/flora-recognition` | Flora identification |

**Use Case**: Compare classification algorithms on structured tabular data

---

### 5️⃣ **Fraud Detection (Classification - Transactional Data)**
All models accept: `amount` (float), `merchant_category`, `location`, `timestamp` (mixed)

| Model | Endpoint | Purpose |
|-------|----------|---------|
| Transaction Checker | `/api/v1/fraud/transaction` | Check transaction validity |
| Credit Card Fraud | `/api/v1/fraud/credit-card` | Detect credit card fraud |
| Anomaly Detector | `/api/v1/fraud/anomaly` | Detect transaction anomalies |
| Risk Scorer | `/api/v1/fraud/risk-scorer` | Calculate fraud risk score |
| Fraud Classifier | `/api/v1/fraud/fraud-classifier` | Binary fraud classification |

**Use Case**: Compare fraud detection algorithms on financial transactions

---

## 🚀 Deployment

### Automatic Deployment

All 25 models are deployed automatically via `deploy.sh`:

```bash
cd /home/edmundo/AIModelHub/AIModelHub_Extensiones
./deploy.sh
```

The deployment script:
1. ✅ Checks if 25 HTTP models exist in database
2. ✅ Runs `006_insert_25_http_models.sql` if models are missing
3. ✅ Starts `mock_server_25_models.py` with all endpoints
4. ✅ Initializes all services (database, backend, frontend)

### Manual Model Installation

If needed, you can manually install models:

```bash
# Connect to database
docker exec -i postgres-inesdata psql -U postgres -d inesdata-catalog

# Run SQL script
\i /docker-entrypoint-initdb.d/006_insert_25_http_models.sql
```

### Verify Deployment

Check the mock server dashboard:
```
http://localhost:5001
```

You should see all 5 groups with their 25 endpoints active.

---

## 🔍 Using Search & Filters

### Search Bar

The Model Pool now includes a powerful search feature:

1. **Search by Name**: Type model name (e.g., "chest-xray", "sentiment")
2. **Search by Task**: Search for task types (e.g., "classification", "regression")
3. **Search by Algorithm**: Find by algorithm name (e.g., "logistic", "neural")
4. **Clear Search**: Click X button to reset

### Task Filters

Filter models by task type:

- **All Tasks**: Show all 25 models
- **Classification**: Show classification models only
- **Regression**: Show regression models only
- **NLP**: Show Natural Language Processing models
- **Vision**: Show Computer Vision models

### Combining Search & Filters

1. Select a filter (e.g., "NLP")
2. Narrow down with search (e.g., "twitter")
3. Click X to clear search while keeping filter
4. Click "All Tasks" to reset everything

---

## 🎯 Benchmarking Workflow

### Step 1: Search for Compatible Models

Example: Compare sentiment analysis models

```
1. Type "sentiment" in search bar
2. All 5 sentiment models appear
3. Notice they all have the same input: {"text"}
```

### Step 2: Select Models for Comparison

```
1. Select all 5 sentiment analysis models
2. Notice "5 selected" badge updates
3. System detects task type: NLP
4. Available metrics appear (Accuracy, F1, BLEU, etc.)
```

### Step 3: Configure Benchmark

```
1. Select metrics (e.g., Accuracy, F1 Score, BLEU)
2. Choose input mode: Single Input or Dataset
3. If dataset: Select validation dataset
4. Adjust cost settings ($/second)
```

### Step 4: Run Benchmark

```
1. Click "Run Benchmark"
2. Watch progress bar as models execute
3. View real-time results in Ranking Panel
4. See metrics side-by-side
5. Export results if needed
```

---

## 📊 Example Benchmarking Scenarios

### Scenario 1: Medical Imaging Comparison

**Goal**: Compare 5 X-ray analysis models

```json
Input:
{
  "image_url": "https://example.com/chest-xray.jpg",
  "image_size": "512x512"
}

Models:
- Chest X-Ray Classifier
- Pneumonia Detector
- COVID-19 Detector
- Lung Nodule Detector
- Tuberculosis Detector

Expected Output: Compare accuracy across different diagnosis tasks
```

### Scenario 2: Sentiment Analysis Bake-off

**Goal**: Find best sentiment analyzer for product reviews

```json
Input:
{
  "text": "This product exceeded my expectations! Great quality and fast shipping."
}

Models:
- E-commerce Sentiment
- Product Review Analyzer
- Customer Feedback
- Twitter Sentiment
- Social Media Analyzer

Expected Output: "positive" with confidence scores
```

### Scenario 3: Health Metrics Validation

**Goal**: Compare BMI calculation methods

```json
Input:
{
  "weight_kg": 75.5,
  "height_m": 1.75
}

Models:
- BMI Calculator
- Body Fat Estimator
- BMR Calculator
- Ideal Weight Predictor
- Health Risk Scorer

Expected Output: Compare health metrics consistency
```

### Scenario 4: Iris Dataset Classic

**Goal**: Benchmark classification algorithms

```json
Input:
{
  "sepal_length": 5.1,
  "sepal_width": 3.5,
  "petal_length": 1.4,
  "petal_width": 0.2
}

Models:
- Iris Classifier
- Flower Classifier
- Plant Classifier
- Botanical Classifier
- Flora Recognition

Expected Output: "setosa" classification accuracy
```

### Scenario 5: Fraud Detection Comparison

**Goal**: Compare fraud detection algorithms

```json
Input:
{
  "amount": 1250.75,
  "merchant_category": "electronics",
  "location": "NY",
  "timestamp": "2024-01-15T14:30:00Z"
}

Models:
- Transaction Checker
- Credit Card Fraud
- Anomaly Detector
- Risk Scorer
- Fraud Classifier

Expected Output: Fraud probability and risk scores
```

---

## 🔧 Troubleshooting

### Models Not Appearing in Pool

```bash
# Check mock server status
ps aux | grep mock_server_25_models

# Restart mock server
cd /home/edmundo/AIModelHub/AIModelHub_Extensiones/model-serving
pkill -f mock_server_25_models
nohup python3 mock_server_25_models.py > model-server.log 2>&1 &

# Verify endpoints
curl http://localhost:5001/api/v1/vision/chest-xray -d '{"image_url":"test.jpg"}' -H "Content-Type: application/json"
```

### Database Missing Models

```bash
# Check model count
docker exec postgres-inesdata psql -U postgres -d inesdata-catalog -c "SELECT COUNT(*) FROM assets WHERE id LIKE 'asset-vision-%' OR id LIKE 'asset-nlp-%' OR id LIKE 'asset-health-%' OR id LIKE 'asset-classification-%' OR id LIKE 'asset-fraud-%';"

# Should return 25

# If less than 25, re-run SQL
docker exec -i postgres-inesdata psql -U postgres -d inesdata-catalog < database-scripts/006_insert_25_http_models.sql
```

### Search Not Working

1. Check browser console for errors
2. Verify `FormsModule` is imported
3. Clear browser cache
4. Restart Angular dev server

### Filter Not Showing Results

1. Verify model task types in database
2. Check console logs: `🔍 Filtered models: X from 25`
3. Ensure task field matches filter conditions

---

## 📁 File Structure

```
AIModelHub/AIModelHub_Extensiones/
├── model-serving/
│   └── mock_server_25_models.py      # Flask server with 25 endpoints
├── database-scripts/
│   └── 006_insert_25_http_models.sql # SQL script with 25 model definitions
└── deploy.sh                          # Automatic deployment script

AIModelHub/AIModelHub_EDCUI/ui-model-browser/
└── src/app/pages/model-benchmarking/
    ├── model-benchmarking.component.ts   # Search/filter logic
    ├── model-benchmarking.component.html # Search bar UI
    └── model-benchmarking.component.scss # Search bar styling
```

---

## 🎓 Best Practices

### ✅ DO

- **Group Selection**: Select models from the same group for meaningful comparisons
- **Input Validation**: Ensure input matches the group's schema exactly
- **Multiple Metrics**: Use 3+ metrics for comprehensive evaluation
- **Save Results**: Export benchmark results for documentation

### ❌ DON'T

- **Mix Groups**: Don't compare models with different input schemas
- **Guess Inputs**: Always check model's input schema before benchmarking
- **Ignore Warnings**: Pay attention to compatibility warnings
- **Rush Testing**: Give benchmarks time to complete (some models are slower)

---

## 🚦 Model Status Indicators

| Color | Status | Meaning |
|-------|--------|---------|
| 🟢 Green | Success | Model executed successfully |
| 🟡 Yellow | Running | Model is currently executing |
| 🔴 Red | Failed | Model execution failed |
| ⚪ Gray | Pending | Model not yet executed |

---

## 📈 Performance Expectations

| Group | Avg Response Time | Typical Accuracy |
|-------|------------------|-----------------|
| Medical Imaging | 150-300ms | 85-95% |
| Sentiment Analysis | 50-100ms | 75-90% |
| Health Metrics | 10-30ms | N/A (regression) |
| Flora Classification | 20-50ms | 90-98% |
| Fraud Detection | 80-150ms | 80-95% |

---

## 🔗 Related Documentation

- [Main Deployment Guide](./GUIDE.md)
- [Step-by-Step Setup](./GUIA_PASO_A_PASO.md)
- [Image Update Guide](./GUIA_ACTUALIZACION_IMAGENES.md)
- [Connector Access Guide](./GUIA_ACCESO_CONECTORES.md)

---

## 📞 Support

If you encounter issues:

1. Check logs: `model-server.log`, `backend.log`
2. Verify all services running: `docker ps`
3. Test individual endpoints: `curl http://localhost:5001/api/v1/vision/chest-xray`
4. Review browser console for frontend errors

---

## 🎉 Quick Start Example

Try this complete workflow in under 5 minutes:

```bash
# 1. Deploy everything
cd /home/edmundo/AIModelHub/AIModelHub_Extensiones
./deploy.sh

# 2. Open browser
http://localhost:4200

# 3. Navigate to Model Benchmarking

# 4. Search "sentiment" in Model Pool

# 5. Select all 5 sentiment models

# 6. Configure:
#    - Metrics: Accuracy, F1 Score
#    - Input: {"text": "This is amazing!"}

# 7. Click "Run Benchmark"

# 8. View results in Ranking Panel
```

---

**Last Updated**: January 2024  
**Version**: 1.0  
**Models**: 25 HTTP endpoints across 5 groups
