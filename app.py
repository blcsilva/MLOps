import os
from flask import Flask, request, jsonify
import mlflow.pyfunc

app = Flask(__name__)

# Carregar o modelo registrado
model = mlflow.pyfunc.load_model("models:/iris_model/1")

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    prediction = model.predict([data['features']])
    return jsonify({'prediction': prediction.tolist()})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

