# CP-D5-280 — Auditoria de aterramento vegetal R4–R5 contínua

## Resultado

A cena `GroundedVegetationR4R5Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Todos os 12 candidatos vegetais foram aterrados individualmente, com coordenadas X/Z preservadas, sem parede de árvores ou luzes dinâmicas.

| Região | Candidatos | Composição |
|---|---:|---|
| R4 Floresta | 6 | 1 pinheiro focal, 2 árvores médias, 2 folhagens leves, 1 feto |
| R5 Majestic | 6 | 1 árvore média, 4 folhagens leves, 1 feto |
| **Total** | **12** | **12 aterrados** |

| Contrato | Resultado |
|---|---|
| Coordenadas X/Z preservadas | `true` para os 12 |
| Luzes dinâmicas adicionadas | 0 |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A auditoria aprova o aterramento vegetal R4–R5 e mantém o orçamento de densidade para GTX 1050 Ti. Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-280_GROUNDED_VEGETATION_RUNTIME.log`.
