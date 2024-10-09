# Usando uma imagem base Alpine com Python 3
FROM ubuntu:20.04


ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC
# Instalar dependências do sistema
RUN apt-get update && apt-get install -y git

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    libssl-dev \
    bash \
    sqlite3 \
    python3-dev \
    cmake \
    python3-pip \
    python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Criar diretório de trabalho
WORKDIR /app

# Criar um ambiente virtual e ativá-lo
RUN python3 -m venv /app/venv

# Ativar o ambiente virtual e instalar dependências
COPY requirements.txt .
RUN /app/venv/bin/pip install --prefer-binary --no-cache-dir -r requirements.txt

# Copiar o restante do código
COPY . .
RUN chmod +x start_web.sh


# Garantir que o ambiente virtual seja ativado para todos os comandos futuros
ENV PATH="/app/venv/bin:$PATH"

# Comando padrão
CMD ["./start_web.sh","flask", "run", "--host=0.0.0.0"]

