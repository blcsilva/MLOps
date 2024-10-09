#!/bin/bash

# Defina o número máximo de tentativas
MAX_RETRIES=5
# Tempo de espera entre as tentativas (em segundos)
SLEEP_TIME=5

function train {
    echo "Tentando carregar o modelo..."
    # Execute o script para carregar o modelo
    python train.py
    return $?  # Retorna o status da última execução
}

for ((i=1; i<=MAX_RETRIES; i++)); do
    train
    if [ $? -eq 0 ]; then
        echo "Modelo carregado com sucesso!"
        break
    else
        echo "Falha ao carregar o modelo. Tentativa $i de $MAX_RETRIES."
        sleep $SLEEP_TIME
    fi
done

# Função para tentar carregar o modelo
function load_model {
    echo "Tentando carregar o modelo..."
    # Execute o script para carregar o modelo
    python load_model.py
    return $?  # Retorna o status da última execução
}

# Tente carregar o modelo com reiteração
for ((i=1; i<=MAX_RETRIES; i++)); do
    load_model
    if [ $? -eq 0 ]; then
        echo "Modelo carregado com sucesso!"
        break
    else
        echo "Falha ao carregar o modelo. Tentativa $i de $MAX_RETRIES."
        sleep $SLEEP_TIME
    fi
done

# Inicie o servidor Flask
echo "Iniciando o servidor Flask..."
exec flask run --host=0.0.0.0
