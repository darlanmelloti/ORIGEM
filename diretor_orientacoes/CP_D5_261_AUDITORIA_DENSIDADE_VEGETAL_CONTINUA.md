# CP-D5-261 — Auditoria de densidade vegetal contínua

## Resultado

A cena `VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição focal/média da vegetação mantém o orçamento validado para GTX 1050 Ti, sem luzes dinâmicas e sem formar parede de árvores.

| Componente | Quantidade |
|---|---:|
| Pinheiro focal | 1 |
| Árvore escura média | 3 |
| Árvore leve | 1 |
| Feto foreground | 2 |
| Triângulos totais | 27.208 |
| Luzes dinâmicas | 0 |
| Densidade em parede | `false` |
| Estado | `approved` |

A auditoria confirma a densidade vegetal focal de Dev5 como tecnicamente compatível, preservando leitura cartográfica e performance sem adicionar iluminação dinâmica. O log está em `CP-D5-261_VEGETATION_DENSITY_RUNTIME.log`.
