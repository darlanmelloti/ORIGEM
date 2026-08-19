# CP-D5-113 — Regressão dos contratos de altura R1–R6

## Resultado

A cena `CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A telemetria confirmou cobertura dos seis marcos, coordenadas X/Z canónicas, três proprietários de produção e exclusão explícita dos candidatos rejeitados.

| Verificação | Resultado |
|---|---|
| Cobertura | 6/6 marcos |
| Proprietários | 3: VossHouse, RiverRoadJourney e ForestLakeRegion |
| Grounding | Raycast obrigatório nos candidatos activos |
| R3 | Arco estrutural rejeitado; nenhum candidato integrado |
| R6 | Cais de lajes rejeitado; margem reservada a candidato aprovado |
| Produção | 0 módulos alterados |
| Estado | `status=approved` |

A regressão confirma que os contratos de altura continuam a impedir a repetição das geometrias rejeitadas e mantêm X/Z separados da resolução Y. O log completo está em `CP-D5-113_HEIGHT_CONTRACTS_RUNTIME.log`.
