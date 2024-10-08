import mlflow
import mlflow.sklearn
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

# Optionally set the tracking URI
# mlflow.set_tracking_uri("http://localhost:5000")  # Uncomment if needed

# Load dataset
data = load_iris()
X, y = data.data, data.target

# Split dataset
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Start an MLflow run
with mlflow.start_run():
    # Train the model
    model = RandomForestClassifier()
    model.fit(X_train, y_train)

    # Log the model with registration
    mlflow.sklearn.log_model(model, "iris_model", registered_model_name="iris_model")
    print("Model logged and registered as iris_model.")

    # Log metrics (optional)
    accuracy = model.score(X_test, y_test)
    mlflow.log_metric("accuracy", accuracy)
    print(f"Logged model with accuracy: {accuracy:.2f}")
