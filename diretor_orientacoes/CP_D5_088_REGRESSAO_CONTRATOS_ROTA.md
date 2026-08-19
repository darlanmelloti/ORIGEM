# CP-D5-088 — Regressão dos contratos de rota R1–R6

## Resultado

O preview `CartographicSequenceR1R6Preview.tscn` foi reexecutado durante 36 segundos após as publicações recentes de QA. A sequência manteve os oito pontos, o desvio lateral R5 Majestic e a chegada às Ruínas R6.

| Verificação | Resultado |
|---|---|
| Checks da sequência | 8 |
| Saltos de âncora | 0 (`no_anchor_skip=true`) |
| Desvio lateral Majestic | Preservado (`majestic_lateral=true`) |
| Chegada R6 | Confirmada (`ruins_arrival=true`) |
| Destino posterior | Âncora 7, Vila Elevada |
| Runtime | 36 segundos |
| `SCRIPT ERROR` | 0 |
| Produção alterada | 0 |

A regressão confirma que os contratos de rumo R1→R6 continuam coerentes e reversíveis. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-088_ROUTE_REGRESSION_RUNTIME.log`.
