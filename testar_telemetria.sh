#!/bin/bash
echo "======================================="
echo "Auditoria De Telemetria - Binario Tech "
echo " Data/Hora: $(date)"
echo "======================================="

echo -e "\n[1] Testando Rota Scania..."
curl -s http://localhost:3024/api/v1/scania|jq .

echo -e "\n[2] Testando Rota Mercedes-Benz..."
curl -s http://localhost:3024/api/v1/mercedes|jq .

echo -e "\n[3] Testando Rota Volkswagen..."
curl -s http://localhost:3024/api/v1/vw | jq . 

echo -e "\n----------------------------------"
echo "Auditoria Finalizada com Sucesso!"
