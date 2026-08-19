# CP-D5-202 — Auditoria de luzes dinâmicas Dev5

## Resultado

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A tentativa inicial com `LightBudgetAuditPreview.tscn` foi descartada porque o recurso não existe; a validação foi repetida com o auditor cartográfico real, sem alterar produção.

| Verificação | Resultado |
|---|---|
| Candidatos auditados | 6 |
| Scripts de produção | 0 |
| Luzes dinâmicas dos activos | 0 |
| Offsets | `(0,0)` em todos |
| QA | Aprovado com timeout controlado |
| Estado | `approved` |

Os seis candidatos Casa Voss, Ponte Marco 2, Floresta Densa, Majestic, Ruínas Submersas e Vegetação Média emitiram `production_script=false`; a linha global confirmou `dynamic_lights=0`. A luz unitária reportada por candidato pertence ao ambiente QA criado pelo próprio preview, não aos activos Dev5. O log está em `CP-D5-202_LIGHT_BUDGET_RUNTIME.log`.
