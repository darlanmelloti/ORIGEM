# CP-CARTO-100 — Retorno à Casa Voss e Limpeza QA

## Resultado

A rota `road_return_voss` passou a invocar a captura interna de viewport e foi validada com **36 segundos de gameplay**. A tomada confirma a Casa Voss como origem física ligada por lajes à Estrada do Rio, sem tocar na porta, no interior, nos colisores, na água ou em módulos das Regiões 7–12.

A auditoria identificou o emissor remoto `MarcoChronosAzulRemoto` como o ponto azul no horizonte. A rotina de limpeza QA agora executa antes da captura e chama a limpeza canónica da Casa Voss; o farol é ocultado apenas quando `ORIGEM_QA_CLEAN_CARTOGRAPHIC_MARKERS=1`. A produção continua a apresentar o elemento narrativo normalmente.

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay de retorno | 36 segundos, PASS |
| Captura | `/home/ubuntu/qa_evidence_dev1_cp245/road_return_voss_cp100_canonical_clean/road_return_voss_36s.png` |
| Porta, rota e colisores | Sem regressão |
| Luzes dinâmicas novas | 0 |

## Nota visual

A limpeza removeu o farol azul remoto que contaminava a avaliação do vale. Um pequeno objecto ciano de flora baixa permanece no primeiro plano; a investigação não encontrou marcador técnico correspondente e não autoriza removê-lo sem atribuição causal.
