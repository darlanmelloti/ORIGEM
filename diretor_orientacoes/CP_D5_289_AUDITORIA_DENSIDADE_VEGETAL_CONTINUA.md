# CP-D5-289 — Auditoria densidade vegetal contínua

## Resultado

A cena `VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição vegetal focal/média/frontal mantém o orçamento auditado sem luzes dinâmicas ou parede de árvores.

| Componente | Quantidade |
|---|---:|
| Pinheiro focal PBR | 1 |
| Árvore escura média | 3 |
| Árvore leve | 1 |
| Feto foreground | 2 |
| **Triângulos totais** | **27.208** |

| Contrato | Resultado |
|---|---|
| Luzes dinâmicas | 0 |
| Densidade parede | `false` |
| Compatibilidade alvo | GTX 1050 Ti |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-289_VEGETATION_DENSITY_RUNTIME.log`.
