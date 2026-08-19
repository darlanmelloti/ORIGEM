# CP-D5-184 — Auditoria de regressão cartográfica R1→R6

## Resultado

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A auditoria cobriu seis candidatos e confirmou âncoras, posições cartográficas, colisores, offsets e escopo isolado.

| Métrica | Resultado |
|---|---:|
| Candidatos auditados | 6 |
| Scripts de produção instanciados | 0 |
| Luzes dinâmicas | 0 |
| Offset local dos candidatos | `(0,0)` |
| Estado | `approved` |

Casa Voss, ponte R2, Floresta Densa, Majestic, Ruínas Submersas e composição vegetal foram auditados nas âncoras canónicas. A Floresta manteve passagem isolada, as Ruínas permaneceram não emissivas e a composição vegetal manteve 1 PBR focal, 3 árvores médias e 4 elementos distantes sem parede de árvores.

Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. O log está em `CP-D5-184_CARTOGRAPHIC_AUDIT_RUNTIME.log`.
