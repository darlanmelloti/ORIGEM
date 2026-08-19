# CP-D5-284 — Auditoria contratos de altura contínua

## Resultado

A cena `CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os seis contratos cartográficos foram auditados sem alterar os módulos de produção, preservando as rejeições canónicas de arco estrutural e cais de lajes.

| Região | Anchor X/Z | Proprietário | Candidato | Modo/decisão |
|---|---|---|---|---|
| R1 Casa Voss | `(-22,8)` | `VossHouse.gd` | anexo Casa Voss | raycast obrigatório |
| R2 Estrada do Rio | `(-21,4;12)` | `RiverRoadJourney.gd` | Ponte Marco 2 | raycast no terreno; tabuleiro físico preservado |
| R3 Arco das Ruínas | `(-16,741,48)` | `RiverRoadJourney.gd` | nenhum | arco estrutural rejeitado; reservado |
| R4 Floresta Densa | `(-9,116)` | `ForestLakeRegion.gd` | vegetação média R4 | raycast sem TerrainPatch, fora de laje/corredor |
| R5 Acampamento Majestic | `(-88,178)` | `ForestLakeRegion.gd` | pavilhão Majestic | raycast no terreno lateral; anel preservado |
| R6 Ruínas Submersas | `(60,252)` | `ForestLakeRegion.gd` | nenhum | cais rejeitado; margem futura reservada |

| Contrato | Resultado |
|---|---|
| Cobertura | 6 regiões |
| Proprietários de terreno | 3 scripts de produção identificados |
| Módulos de produção alterados | `false` |
| Rejeições preservadas | arco estrutural CP-D5-010 e cais CP-D5-017 |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-284_HEIGHT_CONTRACTS_RUNTIME.log`.
