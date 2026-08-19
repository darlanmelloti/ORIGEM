# CP-D5-121 — Regressão da clareira de Elias na Floresta R4

## Resultado

A cena `EliasForestClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Todos os seis elementos vegetais foram aterrados e o corredor de Elias permaneceu aberto em dois ciclos de rota.

| Verificação | Resultado |
|---|---|
| Âncora | R4 `(-9,116)` |
| Largura do corredor | 5,20 m |
| Distância mínima | 2,75 m |
| Grounding | 6/6 elementos |
| Ciclos | 2, ambos `corridor_open=true` |
| Câmara de Elias | Inactiva; contrato externo preservado |
| Portal da floresta | Ausente |
| Parede vegetal | Ausente |
| Produção | Inalterada |

A regressão confirma a clareira técnica de Elias na Floresta R4 sem bloquear a navegação nem reintroduzir portal estrutural. O log está em `CP-D5-121_ELIAS_FOREST_RUNTIME.log`.
