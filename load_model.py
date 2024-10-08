import mlflow
import pandas as pd

# Optionally set the tracking URI
# mlflow.set_tracking_uri("http://localhost:5000")  # Uncomment if needed

# Load the model for inference
try:
    model_uri = "models:/iris_model/1"  # Adjust version as needed
    loaded_model = mlflow.pyfunc.load_model(model_uri)
    print("Model loaded successfully.")

    # Make predictions (example input)
    sample_input = pd.DataFrame([[5.1, 3.5, 1.4, 0.2]], columns=['sepal length (cm)', 'sepal width (cm)', 'petal length (cm)', 'petal width (cm)'])
    prediction = loaded_model.predict(sample_input)
    print(f"Prediction for input {sample_input.values.tolist()}: {prediction}")

except mlflow.exceptions.MlflowException as e:
    print(f"Error loading model: {e}")
