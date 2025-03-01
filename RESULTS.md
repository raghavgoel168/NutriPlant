# NutriPlant Model Training and Evaluation Results

## 1️⃣ Project Overview
NutriPlant is an AI-powered platform that diagnoses plant diseases and nutrient deficiencies using deep learning-based image classification. The model is trained on a dataset of plant leaf images and leverages **Convolutional Neural Networks (CNNs)** to classify diseases with high accuracy.

## 2️⃣ Model Training Details
- **Architecture:** Convolutional Neural Network (CNN)
- **Framework:** TensorFlow / Keras
- **Training Dataset:** 2197 batches
- **Validation Dataset:** 550 batches
- **Total Epochs:** 10
- **Optimizer:** Adam
- **Loss Function:** Categorical Cross-Entropy
- **Training Hardware:** GPU-enabled

## 3️⃣ Performance Metrics

### 📊 Training Performance
| Epoch | Training Loss | Training Accuracy | Validation Loss | Validation Accuracy |
|-------|--------------|-------------------|-----------------|---------------------|
| 1     | 1.8301       | 46.78%            | 0.8455          | 73.69%              |
| 2     | 0.8521       | 73.31%            | 0.5182          | 84.07%              |
| 3     | 0.5964       | 80.90%            | 0.4069          | 86.68%              |
| 4     | 0.4577       | 85.34%            | 0.2932          | 90.79%              |
| 5     | 0.3715       | 88.00%            | 0.2695          | 91.10%              |
| 6     | 0.3113       | 89.90%            | 0.2569          | 91.69%              |
| 7     | 0.2670       | 91.26%            | 0.2283          | 92.44%              |
| 8     | 0.2321       | 92.32%            | 0.1699          | 94.30%              |
| 9     | 0.2076       | 93.06%            | 0.1556          | 94.88%              |
| 10    | 0.1819       | 93.96%            | 0.1607          | 94.62%              |

### ✅ Final Accuracy
- **Training Accuracy:** **96.60%**
- **Validation Accuracy:** **94.62%**

## 4️⃣ Model Evaluation
### 📊 Classification Report

| Class Name | Precision | Recall | F1-Score | Support |
|------------|------------|--------|----------|---------|
| Apple___Apple_scab | 0.77 | 0.99 | 0.87 | 504 |
| Apple___Black_rot | 0.99 | 0.96 | 0.97 | 497 |
| Apple___Cedar_apple_rust | 0.94 | 0.99 | 0.97 | 440 |
| Apple___healthy | 0.95 | 0.90 | 0.93 | 502 |
| Blueberry___healthy | 0.96 | 0.95 | 0.95 | 454 |
| Cherry_(including_sour)___Powdery_mildew | 0.99 | 0.97 | 0.98 | 421 |
| Cherry_(including_sour)___healthy | 0.99 | 0.96 | 0.97 | 456 |
| Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot | 0.89 | 0.94 | 0.91 | 410 |
| Corn_(maize)___Common_rust_ | 1.00 | 0.99 | 0.99 | 477 |
| Corn_(maize)___Northern_Leaf_Blight | 0.96 | 0.92 | 0.94 | 477 |
| Corn_(maize)___healthy | 0.99 | 1.00 | 0.99 | 465 |
| Grape___Black_rot | 0.95 | 0.97 | 0.96 | 472 |
| Grape___Esca_(Black_Measles) | 1.00 | 0.95 | 0.98 | 480 |
| Grape___Leaf_blight_(Isariopsis_Leaf_Spot) | 0.96 | 1.00 | 0.98 | 430 |
| Grape___healthy | 0.98 | 0.99 | 0.98 | 423 |
| Orange___Haunglongbing_(Citrus_greening) | 0.98 | 0.98 | 0.98 | 503 |
| Peach___Bacterial_spot | 0.98 | 0.91 | 0.94 | 459 |
| Peach___healthy | 0.97 | 0.99 | 0.98 | 432 |
| Pepper,_bell___Bacterial_spot | 0.96 | 0.87 | 0.91 | 478 |
| Pepper,_bell___healthy | 0.87 | 0.97 | 0.92 | 497 |
| Potato___Early_blight | 0.96 | 0.99 | 0.97 | 485 |
| Potato___Late_blight | 0.95 | 0.87 | 0.91 | 485 |
| Potato___healthy | 0.98 | 0.95 | 0.96 | 456 |



## 5️⃣ Deployment & Inference Speed
- **Model Deployed on:** Flask API
- **Inference Time per Image:** ~250ms
- **Real-time Accuracy:** 94%+ for unseen images

## 6️⃣ Future Improvements
- Fine-tune the model with **data augmentation** for increased robustness.
- Implement **attention mechanisms (e.g., Vision Transformers)** for better feature extraction.
- Expand dataset with **more diverse plant species**.
- Deploy on **mobile (Flutter) for real-time disease detection.**

---

### 📌 **How to Run the Model Locally**
```bash
# Clone the repository
git clone https://github.com/raghavgoel168/NutriPlant.git
cd nutriplant

# Install dependencies
pip install -r requirements.txt

# Run inference
python inference.py --image sample_leaf.jpg
```

📢 **For more details, check out the full documentation in the repo!** 🚀

