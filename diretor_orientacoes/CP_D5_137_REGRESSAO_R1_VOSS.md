# CP-D5-137 — Regressão integrada da Casa Voss R1

## Resultado

A cena `R1LivingVossExteriorPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O exterior da Casa Voss confirmou dois elementos de fauna, cinco elementos de jardim, uma estação válida e oito instâncias aterradas.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Ciclos de rota | 4, todos `clear=true` |
| Distância fauna mínima | 9,07 m |
| Grounding | 8 |
| Estação Voss | Confirmada |
| Casa de produção | Não tocada |
| Porta | Não tocada |
| Módulos de produção | Inalterados |

A regressão confirma a saída R1→R2 sem interferir na Casa Voss ou na sua porta de produção. O log está em `CP-D5-137_R1_VOSS_RUNTIME.log`.
