# CP-D5-204 — Regressão dos contratos de altura e aterramento R1→R6

## Resultado

A cena `CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). As seis regiões mantiveram coordenadas X/Z canónicas, proprietários correctos e regras de raycast sem alterar a produção.

| Região | World X/Z | Proprietário | Candidato | Regra |
|---|---|---|---|---|
| R1 Casa Voss | `(−22,8)` | `VossHouse.gd` | `anexo_casa_voss` | Raycast obrigatório |
| R2 Estrada do Rio | `(−21,4;12)` | `RiverRoadJourney.gd` | `ponte_marco_2` | Raycast no terreno; tabuleiro físico preservado |
| R3 Arco das Ruínas | `(−16,741;48)` | `RiverRoadJourney.gd` | Nenhum | Arco estrutural rejeitado; activo lateral futuro |
| R4 Floresta Densa | `(−9,116)` | `ForestLakeRegion.gd` | `vegetacao_media_r4` | Raycast no TerrainPatch, fora da laje |
| R5 Majestic | `(−88,178)` | `ForestLakeRegion.gd` | `pavilhao_majestic` | Raycast no terreno lateral; anel preservado |
| R6 Ruínas Submersas | `(60,252)` | `ForestLakeRegion.gd` | Nenhum | Cais de lajes rejeitado; margem futura |

| Verificação | Resultado |
|---|---|
| Cobertura | 6 regiões |
| Proprietários de terreno | 3 |
| Estado | `approved` |
| Módulos de produção alterados | `false` |

A regressão aprova os contratos de altura e aterramento e confirma que os candidatos estruturais rejeitados não foram reintroduzidos. O log está em `CP-D5-204_HEIGHT_CONTRACTS_RUNTIME.log`.
