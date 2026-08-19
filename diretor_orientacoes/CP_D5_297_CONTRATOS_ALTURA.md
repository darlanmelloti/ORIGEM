# CP-D5-297 — Auditoria dos contratos de altura R1–R6

A cena `CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A telemetria confirmou cobertura dos seis marcos, três proprietários regionais, candidatos permitidos e exclusões explícitas dos elementos rejeitados.

| Região | X/Z | Proprietário | Contrato |
|---|---|---|---|
| R1 Casa Voss | `(-22.000, 8.000)` | `VossHouse.gd` | raycast obrigatório |
| R2 Estrada do Rio | `(-21.400, 12.000)` | `RiverRoadJourney.gd` | raycast sem alterar tabuleiro |
| R3 Arco | `(-16.741, 48.000)` | `RiverRoadJourney.gd` | arco estrutural rejeitado; activo lateral futuro |
| R4 Floresta | `(-9.000, 116.000)` | `ForestLakeRegion.gd` | raycast fora da laje/corredor |
| R5 Majestic | `(-88.000, 178.000)` | `ForestLakeRegion.gd` | raycast lateral; anel preservado |
| R6 Ruínas | `(60.000, 252.000)` | `ForestLakeRegion.gd` | cais rejeitado; activo de margem futuro |

**Estado:** `approved`, `coverage=6`, `terrain_owners=3`, `production_modules_changed=false`. Evidência completa: `CP-D5-297_HEIGHT_CONTRACTS_RUNTIME.log`.
