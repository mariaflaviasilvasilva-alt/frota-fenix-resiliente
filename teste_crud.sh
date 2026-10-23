#!/bin/bash

# Uso: ./teste_crud.sh [PORTA] [URL_BASE]
PORTA="${1:-3000}"
HOST="${2:-http://localhost}"
BASE_URL="$HOST:$PORTA/api/v1/veiculos"

echo "===== Teste CRUD - $(date) | $BASE_URL ====="

if ! curl -s -f "$HOST:$PORTA/api/v1/health" > /dev/null; then
    echo "ERRO: API nao responde em $HOST:$PORTA. Suba com: PORT=$PORTA node frota_api.js &"
    exit 1
fi

echo -e "\n--- POST: cadastrando veiculo ---"
RESP=$(curl -s -X POST "$BASE_URL" -H "Content-Type: application/json" \
    -d '{"placa": "IVC-1001", "montadora": "Iveco", "modelo": "Tector"}')
echo "$RESP" | jq .
ID=$(echo "$RESP" | jq -r '.id')
echo "ID capturado: $ID"

echo -e "\n--- PATCH: status do ID $ID ---"
curl -s -X PATCH "$BASE_URL/$ID/status" -H "Content-Type: application/json" \
    -d '{"status": "EM_ROTA"}' | jq .

echo -e "\n--- PUT: substituindo ID $ID ---"
curl -s -X PUT "$BASE_URL/$ID" -H "Content-Type: application/json" \
    -d '{"placa": "IVC-9999", "montadora": "Iveco", "modelo": "Stralis", "status": "DISPONIVEL"}' | jq .

echo -e "\n--- DELETE: removendo ID $ID ---"
curl -s -X DELETE "$BASE_URL/$ID" | jq .

echo -e "\n--- GET: confirmando remocao (esperado 404) ---"
echo "HTTP_STATUS: $(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/$ID")"
