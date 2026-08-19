# CP-D5-132 — Regressão dos contratos de altura cartográfica

## Resultado

A cena `CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A regressão confirmou a cobertura dos seis marcos, os três proprietários de módulos e as regras de raycast/grounding sem alterar produção.

| Verificação | Resultado |
|---|---|
| Cobertura | 6 marcos R1–R6 |
| Proprietários | VossHouse.gd, RiverRoadJourney.gd, ForestLakeRegion.gd |
| R1/R2/R4/R5 | Raycast obrigatório antes da integração |
| R3 | Arco estrutural rejeitado; candidato reservado |
| R6 | Cais de lajes rejeitado; candidato reservado |
| Preservação X/Z | Confirmada nas âncoras canónicas |
| Estado | `approved` |
| Produção | Inalterada |

A regressão impede que candidatos rejeitados sejam reintroduzidos como integração cartográfica e mantém o grounding separado dos módulos de produção. O log está em `CP-D5-132_HEIGHT_CONTRACTS_RUNTIME.log`.
