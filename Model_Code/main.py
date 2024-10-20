import streamlit as st
import tensorflow as tf
import numpy as np

# Tensorflow Model Prediction
def model_prediction(image_data):
    model = tf.keras.models.load_model("trained_plant_disease_model.keras")
    image = tf.image.decode_image(image_data, channels=3)
    image = tf.image.resize(image, [128, 128])
    image = np.expand_dims(image, axis=0)  # Convert single image to batch
    predictions = model.predict(image)
    return np.argmax(predictions)  # Return index of max element

# Apply unique custom theme and animations
st.markdown(
    """
    <style>
    /* Main page background */
    .main {
        background-color: #F0F8FF;
        padding: 20px;
        transition: background-color 1s ease;
    }
    
    /* Sidebar customization */
    .css-1y4p8pa {
        background-color: #2C3E50 !important;
        color: #2b2929 !important;  /* Updated text color for visibility */
        padding: 20px;
        transition: background-color 0.5s ease;
    }

    /* Sidebar header styling */
    .css-1y4p8pa h1 {
        color: #E74C3C !important;
        font-size: 26px;
        font-weight: bold;
        text-align: center;
        animation: fadeInDown 1s;
    }

    /* Custom animations */
    @keyframes fadeInDown {
        0% {
            opacity: 0;
            transform: translateY(-20px);
        }
        100% {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @keyframes glow {
        0% {
            box-shadow: 0 0 5px #E74C3C;
        }
        50% {
            box-shadow: 0 0 20px #E74C3C;
        }
        100% {
            box-shadow: 0 0 5px #E74C3C;
        }
    }

    /* Header customization */
    .stHeader {
        font-size: 36px;
        font-weight: bold;
        color: #2C3E50;
        text-align: center;
        margin-top: 20px;
        animation: fadeInDown 1s;
    }

    /* Button styling */
    .stButton>button {
        border-radius: 30px;
        background-color: #1ABC9C;
        color: white;
        width: 100%;
        padding: 15px;
        font-size: 20px;
        margin-top: 20px;
        border: none;
        transition: background-color 0.3s ease;
        animation: glow 2s infinite alternate;
    }

    .stButton>button:hover {
        background-color: #16A085;
    }

    /* Input and file uploader styling */
    .stTextInput, .stFileUploader {
        border-radius: 10px;
        background-color: #ECF0F1;
        padding: 15px;
        margin-bottom: 20px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        transition: box-shadow 0.3s ease;
    }

    .stTextInput>div>div>input, .stFileUploader>div>div>input {
        background-color: #ECF0F1;
        color: #2C3E50;
        border: none;
        font-size: 18px;
    }

    /* Markdown customization */
    .stMarkdown {
        font-size: 18px;
        color: #34495E;
        background-color: #F8F9F9;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        animation: fadeInDown 1.5s;
    }

    /* Success message styling */
    .custom-success {
        color: #27AE60;
        font-weight: bold;
        font-size: 20px;
        background-color: #D4EFDF;
        padding: 15px;
        border-radius: 10px;
        border: 1px solid #A9DFBF;
        text-align: center;
        animation: fadeInDown 2s;
    }

    </style>
    """,
    unsafe_allow_html=True
)

# Disease Recognition Page
st.markdown('<h1 class="stHeader">Disease Recognition</h1>', unsafe_allow_html=True)

# Upload or capture an image
image_file = st.file_uploader("Choose an image of a plant leaf to analyze or use the camera:")
camera_image = st.camera_input("Capture an image using the camera")

if image_file or camera_image:
    input_image = image_file.read() if image_file else camera_image.getvalue()
    st.image(input_image, use_column_width=True)
    
    # Predict button
    if st.button("Analyze Image"):
        # st.snow()
        st.write("Analyzing...")
        result_index = model_prediction(input_image)
        
        # Reading Labels
        class_name = ['Apple___Apple_scab', 'Apple___Black_rot', 'Apple___Cedar_apple_rust', 'Apple___healthy',
                      'Blueberry___healthy', 'Cherry_(including_sour)___Powdery_mildew', 
                      'Cherry_(including_sour)___healthy', 'Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot', 
                      'Corn_(maize)___Common_rust_', 'Corn_(maize)___Northern_Leaf_Blight', 'Corn_(maize)___healthy', 
                      'Grape___Black_rot', 'Grape___Esca_(Black_Measles)', 'Grape___Leaf_blight_(Isariopsis_Leaf_Spot)', 
                      'Grape___healthy', 'Orange___Haunglongbing_(Citrus_greening)', 'Peach___Bacterial_spot',
                      'Peach___healthy', 'Pepper,_bell___Bacterial_spot', 'Pepper,_bell___healthy', 
                      'Potato___Early_blight', 'Potato___Late_blight', 'Potato___healthy', 
                      'Raspberry___healthy', 'Soybean___healthy', 'Squash___Powdery_mildew', 
                      'Strawberry___Leaf_scorch', 'Strawberry___healthy', 'Tomato___Bacterial_spot', 
                      'Tomato___Early_blight', 'Tomato___Late_blight', 'Tomato___Leaf_Mold', 
                      'Tomato___Septoria_leaf_spot', 'Tomato___Spider_mites Two-spotted_spider_mite', 
                      'Tomato___Target_Spot', 'Tomato___Tomato_Yellow_Leaf_Curl_Virus', 'Tomato___Tomato_mosaic_virus',
                      'Tomato___healthy']
        
        # Display result with animation
        st.markdown(f'<div class="custom-success">Prediction: {class_name[result_index]}</div>', unsafe_allow_html=True)
