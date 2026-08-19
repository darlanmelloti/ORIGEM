# CP-D5-293 — Auditoria integrada dos candidatos Dev5 R1–R6

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A auditoria confirmou seis candidatos cartográficos, todos com `production_script=false`, preservação das âncoras e composição vegetal R4/R5 sem parede de árvores.

| Verificação | Resultado |
|---|---|
| Candidatos auditados | 6 |
| Scripts de produção | 0 |
| Luzes dinâmicas | 0 |
| Casa Voss | aprovada, aterrada, rota aberta, 12 colisões |
| Ponte Marco 2 | aprovada, modular, aterrada, clearance 0,21, 14 colisões |
| Floresta Densa | passagem 2,4 m, isolada, 20 colisões |
| Majestic | âncora 5, offset `(0,0)`, 4 colisões |
| Ruínas Submersas | submersa, não emissiva, 0 luzes dinâmicas, 18 colisões |
| Vegetação R4/R5 | 1 PBR focal, 3 médios, 4 distantes por composição, `wall_of_trees=false` |

A ferramenta permanece uma auditoria QA isolada e não autoriza integração automática nos módulos R1–R6. Evidência completa: `CP-D5-293_INTEGRATED_AUDIT_RUNTIME.log`.
