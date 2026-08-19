# CP-D5-098 — Validação da ficha de integração R5

## Resultado

A ficha de integração do Acampamento Majestic vivo foi validada contra `R5LivingMajesticPreview.tscn` em ambiente Godot headless Compatibility. O parser terminou com `PARSER_EXIT=0`; a sessão QA terminou pelo limite controlado de 36 segundos e confirmou o contrato vivo da composição.

| Verificação | Resultado |
|---|---|
| Parser do projecto | Aprovado (`PARSER_EXIT=0`) |
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| Fauna | 2 cervos |
| Vegetação | 7 elementos dentro do limite LOD |
| Abrigo | 3 partes laterais |
| Pavilhão | Presente e aterrado |
| Grounding | 13 eventos confirmados |
| Cairn/portal | Ausentes (`cairn=false`, `wall_of_trees=false`) |
| Corredor | Livre; `route_cycle=1`, `clear=true` |
| Distância fauna | 27,41 m no ciclo registado |
| Módulos de produção | 0 alterados |

A mensagem de configuração FSR1, quando presente no log, é uma advertência do renderer Compatibility e não invalida o parser ou a QA. O log completo está em `CP-D5-098_R5_INTEGRATION_RUNTIME.log`.
