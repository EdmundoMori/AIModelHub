-- Create validation_datasets table for model benchmarking
CREATE TABLE IF NOT EXISTS validation_datasets (
    id VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    task_type VARCHAR(50) NOT NULL, -- classification, regression, nlp, vision
    samples INTEGER NOT NULL,
    description TEXT,
    features_schema JSONB, -- Schema of input features
    data JSONB NOT NULL, -- The actual dataset samples
    labels_column VARCHAR(100), -- Name of the target/label column
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on task_type for faster queries
CREATE INDEX IF NOT EXISTS idx_validation_datasets_task_type ON validation_datasets(task_type);

-- Insert sample validation datasets
-- Classification datasets
INSERT INTO validation_datasets (id, name, task_type, samples, description, features_schema, data, labels_column)
VALUES 
(
    'iris-150',
    'Iris Dataset',
    'classification',
    150,
    'Classic iris flower classification dataset with 4 features',
    '{
        "fields": [
            {"name": "sepal_length", "type": "float", "min": 4.3, "max": 7.9},
            {"name": "sepal_width", "type": "float", "min": 2.0, "max": 4.4},
            {"name": "petal_length", "type": "float", "min": 1.0, "max": 6.9},
            {"name": "petal_width", "type": "float", "min": 0.1, "max": 2.5}
        ]
    }'::jsonb,
    '{
        "samples": [
            {"sepal_length": 5.1, "sepal_width": 3.5, "petal_length": 1.4, "petal_width": 0.2, "species": "setosa"},
            {"sepal_length": 4.9, "sepal_width": 3.0, "petal_length": 1.4, "petal_width": 0.2, "species": "setosa"},
            {"sepal_length": 7.0, "sepal_width": 3.2, "petal_length": 4.7, "petal_width": 1.4, "species": "versicolor"},
            {"sepal_length": 6.4, "sepal_width": 3.2, "petal_length": 4.5, "petal_width": 1.5, "species": "versicolor"},
            {"sepal_length": 6.3, "sepal_width": 3.3, "petal_length": 6.0, "petal_width": 2.5, "species": "virginica"},
            {"sepal_length": 5.8, "sepal_width": 2.7, "petal_length": 5.1, "petal_width": 1.9, "species": "virginica"}
        ]
    }'::jsonb,
    'species'
),
(
    'wine-178',
    'Wine Quality',
    'classification',
    178,
    'Wine classification dataset based on chemical properties',
    '{
        "fields": [
            {"name": "alcohol", "type": "float"},
            {"name": "malic_acid", "type": "float"},
            {"name": "ash", "type": "float"},
            {"name": "alcalinity", "type": "float"}
        ]
    }'::jsonb,
    '{
        "samples": [
            {"alcohol": 14.23, "malic_acid": 1.71, "ash": 2.43, "alcalinity": 15.6, "class": 0},
            {"alcohol": 13.20, "malic_acid": 1.78, "ash": 2.14, "alcalinity": 11.2, "class": 0},
            {"alcohol": 13.16, "malic_acid": 2.36, "ash": 2.67, "alcalinity": 18.6, "class": 1},
            {"alcohol": 14.37, "malic_acid": 1.95, "ash": 2.50, "alcalinity": 16.8, "class": 1}
        ]
    }'::jsonb,
    'class'
);

-- Regression datasets
INSERT INTO validation_datasets (id, name, task_type, samples, description, features_schema, data, labels_column)
VALUES 
(
    'boston-506',
    'Boston Housing',
    'regression',
    506,
    'House price prediction based on neighborhood features',
    '{
        "fields": [
            {"name": "crim", "type": "float", "description": "Per capita crime rate"},
            {"name": "rm", "type": "float", "description": "Average number of rooms"},
            {"name": "age", "type": "float", "description": "Proportion of owner-occupied units built before 1940"},
            {"name": "dis", "type": "float", "description": "Weighted distances to employment centres"}
        ]
    }'::jsonb,
    '{
        "samples": [
            {"crim": 0.00632, "rm": 6.575, "age": 65.2, "dis": 4.0900, "medv": 24.0},
            {"crim": 0.02731, "rm": 6.421, "age": 78.9, "dis": 4.9671, "medv": 21.6},
            {"crim": 0.02729, "rm": 7.185, "age": 61.1, "dis": 4.9671, "medv": 34.7},
            {"crim": 0.03237, "rm": 6.998, "age": 45.8, "dis": 6.0622, "medv": 33.4}
        ]
    }'::jsonb,
    'medv'
),
(
    'diabetes-442',
    'Diabetes Dataset',
    'regression',
    442,
    'Disease progression prediction based on baseline measurements',
    '{
        "fields": [
            {"name": "age", "type": "float"},
            {"name": "bmi", "type": "float"},
            {"name": "bp", "type": "float"},
            {"name": "s1", "type": "float"}
        ]
    }'::jsonb,
    '{
        "samples": [
            {"age": 0.038, "bmi": 0.061, "bp": 0.021, "s1": -0.044, "target": 151.0},
            {"age": -0.001, "bmi": -0.044, "bp": -0.051, "s1": -0.045, "target": 75.0},
            {"age": 0.085, "bmi": 0.044, "bp": -0.005, "s1": -0.036, "target": 141.0}
        ]
    }'::jsonb,
    'target'
);

-- NLP datasets
INSERT INTO validation_datasets (id, name, task_type, samples, description, features_schema, data, labels_column)
VALUES 
(
    'imdb-2000',
    'IMDB Reviews',
    'nlp',
    2000,
    'Sentiment analysis dataset from movie reviews',
    '{
        "fields": [
            {"name": "text", "type": "string", "description": "Review text"}
        ]
    }'::jsonb,
    '{
        "samples": [
            {"text": "This movie was absolutely wonderful. The acting was superb and the plot kept me engaged throughout.", "sentiment": "positive"},
            {"text": "Terrible waste of time. Poor acting and even worse directing.", "sentiment": "negative"},
            {"text": "A masterpiece! Every scene was beautifully crafted.", "sentiment": "positive"},
            {"text": "Boring and predictable. I fell asleep halfway through.", "sentiment": "negative"}
        ]
    }'::jsonb,
    'sentiment'
),
(
    'ag-news-1000',
    'AG News',
    'nlp',
    1000,
    'News categorization dataset with 4 categories',
    '{
        "fields": [
            {"name": "text", "type": "string", "description": "News article text"}
        ]
    }'::jsonb,
    '{
        "samples": [
            {"text": "Wall Street rallies as tech stocks surge on earnings reports", "category": "Business"},
            {"text": "Scientists discover new species in Amazon rainforest", "category": "Sci/Tech"},
            {"text": "Championship game ends in dramatic overtime victory", "category": "Sports"},
            {"text": "New climate policy announced by government officials", "category": "World"}
        ]
    }'::jsonb,
    'category'
);

-- Vision datasets
INSERT INTO validation_datasets (id, name, task_type, samples, description, features_schema, data, labels_column)
VALUES 
(
    'mnist-1000',
    'MNIST Sample',
    'vision',
    1000,
    'Handwritten digit images (28x28 pixels)',
    '{
        "fields": [
            {"name": "pixels", "type": "array", "shape": [784], "description": "Flattened 28x28 grayscale image"}
        ]
    }'::jsonb,
    '{
        "samples": [
            {"image_id": "mnist_001", "label": 5, "note": "Image data stored separately for performance"},
            {"image_id": "mnist_002", "label": 0, "note": "Image data stored separately for performance"},
            {"image_id": "mnist_003", "label": 4, "note": "Image data stored separately for performance"}
        ]
    }'::jsonb,
    'label'
),
(
    'cifar10-500',
    'CIFAR-10 Sample',
    'vision',
    500,
    '10-class object recognition (32x32 color images)',
    '{
        "fields": [
            {"name": "pixels", "type": "array", "shape": [32, 32, 3], "description": "RGB image"}
        ]
    }'::jsonb,
    '{
        "samples": [
            {"image_id": "cifar_001", "label": "airplane", "note": "Image data stored separately for performance"},
            {"image_id": "cifar_002", "label": "automobile", "note": "Image data stored separately for performance"}
        ]
    }'::jsonb,
    'label'
);

-- Generic/other dataset
INSERT INTO validation_datasets (id, name, task_type, samples, description, features_schema, data, labels_column)
VALUES 
(
    'custom-100',
    'Custom Validation Set',
    'other',
    100,
    'User-provided custom validation dataset',
    '{
        "fields": [
            {"name": "feature_1", "type": "float"},
            {"name": "feature_2", "type": "float"}
        ]
    }'::jsonb,
    '{
        "samples": [
            {"feature_1": 0.5, "feature_2": 1.0, "target": 0},
            {"feature_1": 1.5, "feature_2": 2.0, "target": 1}
        ]
    }'::jsonb,
    'target'
);

-- Grant permissions
GRANT SELECT ON validation_datasets TO ml_assets_user;
