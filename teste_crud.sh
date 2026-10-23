#!/bin/bash

BASE_URL="http://localhost:3000/api/v1/veiculos"
LOG_FILE="crud_result.log"

echo "===== Execucao iniciada em $(date) =====" > "$LOG_FILE"

log() {
    echo "$1" | tee -a "$LOG_FILE"
}

log ""
log "----- Passo 1: Cadastrando veiculo 1 (Volvo FH 540) -----"
RESPOSTA_1=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -X POST "$BASE_URL" \
    -H "Content-Type: application/json" \
    -d '{"placa": "KLL-9090", "montadora": "Volvo", "modelo": "FH 540"}')

BODY_1=$(echo "$RESPOSTA_1" | sed '$d')
STATUS_1=$(echo "$RESPOSTA_1" | tail -n1 | cut -d':' -f2)
ID_1=$(echo "$BODY_1" | jq -r '.id')

log "Status HTTP: $STATUS_1"
log "Resposta: $BODY_1"
log "ID do veiculo 1: $ID_1"

log ""
log "----- Passo 2: Cadastrando veiculo 2 (Scania R450) -----"
RESPOSTA_2=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -X POST "$BASE_URL" \
    -H "Content-Type: application/json" \
    -d '{"placa": "SCN-2025", "montadora": "Scania", "modelo": "R450"}')

BODY_2=$(echo "$RESPOSTA_2" | sed '$d')
STATUS_2=$(echo "$RESPOSTA_2" | tail -n1 | cut -d':' -f2)
ID_2=$(echo "$BODY_2" | jq -r '.id')

log "Status HTTP: $STATUS_2"
log "Resposta: $BODY_2"
log "ID do veiculo 2: $ID_2"

log ""
log "----- Passo 3: Atualizando status do veiculo 1 (ID $ID_1) para EM_ROTA -----"
RESPOSTA_3=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -X PATCH "$BASE_URL/$ID_1/status" \
    -H "Content-Type: application/json" \
    -d '{"status": "EM_ROTA"}')

BODY_3=$(echo "$RESPOSTA_3" | sed '$d')
STATUS_3=$(echo "$RESPOSTA_3" | tail -n1 | cut -d':' -f2)

log "Status HTTP: $STATUS_3"
log "Resposta: $BODY_3"

log ""
log "----- Passo 4: Deletando veiculo 2 (ID $ID_2) -----"
RESPOSTA_4=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -X DELETE "$BASE_URL/$ID_2")

BODY_4=$(echo "$RESPOSTA_4" | sed '$d')
STATUS_4=$(echo "$RESPOSTA_4" | tail -n1 | cut -d':' -f2)

log "Status HTTP: $STATUS_4"
log "Resposta: $BODY_4"

log ""
log "===== Execucao finalizada em $(date) ====="
log ""
log "Resumo:"
log "  Veiculo 1 (ID $ID_1) - cadastrado e atualizado para EM_ROTA"
log "  Veiculo 2 (ID $ID_2) - cadastrado e deletado"

echo ""
echo "Script finalizado. Log completo salvo em: $LOG_FILE"
