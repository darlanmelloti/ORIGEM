# CP-D5-118 — Regressão da auditoria integrada de colisores

## Resultado

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A auditoria confirmou seis candidatos cartográficos nas âncoras canónicas, offsets zero, colisores de QA conforme a composição, iluminação limitada e nenhum script de produção.

| Verificação | Resultado |
|---|---|
| Candidatos | 6 |
| Scripts de produção | 0 |
| Luzes dinâmicas globais | 0 |
| Floresta R4 | passagem 2,4 m; isolada |
| Vegetação R4/R5 | 1 PBR, 3 médias e 4 distantes por composição |
| Ruínas R6 | submersas; emissivo falso; 0 luzes dinâmicas |
| Offsets X/Z | `(0,0)` em todos os candidatos |

A regressão confirma que os contratos de colisão, grounding, composição vegetal, luz e âncoras continuam isolados dos módulos de produção. O log está em `CP-D5-118_COLLISION_CONTRACT_RUNTIME.log`.
