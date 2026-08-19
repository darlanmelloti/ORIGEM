# CP-D5-264 — Auditoria de contratos de altura

## Resultado

A cena `CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os seis contratos regionais foram cobertos, com proprietários de terreno identificados, aterramento por raycast quando aplicável e rejeições históricas preservadas.

| Região | Âncora X/Z | Proprietário | Candidato | Regra |
|---|---|---|---|---|
| R1 Casa Voss | `(-22,8)` | `VossHouse.gd` | anexo Casa Voss | raycast obrigatório antes de integração |
| R2 Estrada do Rio | `(-21,4;12)` | `RiverRoadJourney.gd` | ponte Marco 2 | raycast no terreno; tabuleiro físico preservado |
| R3 Arco das Ruínas | `(-16,741;48)` | `RiverRoadJourney.gd` | nenhum | arco estrutural rejeitado, não repetir |
| R4 Floresta Densa | `(-9,116)` | `ForestLakeRegion.gd` | vegetação média R4 | raycast fora de laje e corredor jogável |
| R5 Acampamento Majestic | `(-88,178)` | `ForestLakeRegion.gd` | pavilhão Majestic | raycast lateral; anel e ligação física preservados |
| R6 Ruínas Submersas | `(60,252)` | `ForestLakeRegion.gd` | nenhum | cais de lajes rejeitado, não repetir |

| Contrato | Resultado |
|---|---|
| Cobertura | 6 regiões |
| Proprietários de terreno | 3 |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A auditoria aprova os contratos de altura sem reintroduzir o arco estrutural R3 nem o cais de lajes R6. Os avisos FSR1 são específicos do renderer Compatibility em headless. O log está em `CP-D5-264_HEIGHT_CONTRACTS_RUNTIME.log`.
