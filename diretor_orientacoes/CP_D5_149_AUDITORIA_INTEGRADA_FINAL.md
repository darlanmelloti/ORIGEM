# CP-D5-149 — Auditoria integrada final dos contratos cartográficos

## Resultado

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os seis candidatos R1–R6 foram auditados com offsets zero e sem scripts de produção.

| Verificação | Resultado |
|---|---:|
| Candidatos | 6 |
| Scripts de produção | 0 |
| Luzes dinâmicas | 0 |
| Offsets cartográficos | 0 |
| Candidatos com colisores | R1: 12; R2: 14; R4: 20; R5: 4; R6: 18 |
| Vegetação PBR por composição | 1 |
| Vegetação média por composição | 3 |
| Vegetação distante por composição | 4 |
| Parede vegetal | `false` |
| R4 passagem | 2,4 m; isolada |
| R6 submersa | Confirmada; emissiva falsa |

A auditoria confirma os contratos cartográficos integrados, preserva a separação de produção e mantém o orçamento de iluminação em zero luzes dinâmicas adicionais. O log está em `CP-D5-149_INTEGRATED_AUDIT_RUNTIME.log`.
