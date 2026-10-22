#!/bin/bash

echo "======================================="
echo "Teste de Rotas - Binario Tech Core"
echo " Data/Hora: $(date)"
echo "======================================="

echo -e "\n[1] Testando Rota /status..."
curl -s http://localhost:3024/status | jq .

echo -e "\n[2] Testando Rota /scania/info..."
curl -s http://localhost:3024/scania/info | jq .

echo -e "\n[3] Testando Rota /vw/info..."
curl -s http://localhost:3024/vw/info | jq .

echo -e "\n----------------------------------"
echo "Testes Finalizados com Sucesso!"
