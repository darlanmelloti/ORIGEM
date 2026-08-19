# CP-D5-187 — Regressão da vegetação aterrada R4→R5

## Resultado

A cena `GroundedVegetationR4R5Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A continuidade vegetal entre Floresta Densa e Majestic manteve todos os candidatos aterrados por raycast, com X/Z preservados.

| Métrica | Resultado |
|---|---:|
| Candidatos aterrados | 12 |
| Pinheiro PBR focal | 1 |
| Árvores detalhadas médias | 3 |
| Folhagem leve distante | 6 |
| Feto | 2 |
| Luzes dinâmicas adicionais | 0 |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

Os seis elementos R4 e seis elementos R5 tiveram `grounded=true` e `xz_preserved=true`. A regressão aprova a continuidade visual e técnica sem obstruir o corredor ou reintroduzir composição proibida. O log está em `CP-D5-187_R4R5_VEGETATION_RUNTIME.log`.
