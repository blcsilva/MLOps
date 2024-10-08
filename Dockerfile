# Usando a imagem base do Python
FROM python:3.9.20-alpine3.19

# Define o diretório de trabalho
WORKDIR /app

# Copia o requirements.txt e instala as dependências
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copia todos os arquivos do projeto para o contêiner
COPY . .

# Comando padrão para o servidor MLflow
CMD ["mlflow", "ui", "--host", "0.0.0.0", "--port", "5000"]
