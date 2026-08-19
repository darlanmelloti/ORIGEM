# CP-D5-306 — Auditoria final de colisões e clearance R1–R6

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A auditoria confirmou todos os candidatos com colisores QA próprios, aterramento, rotas abertas e escopo sem módulos de produção.

| Candidato | Colisões | Verificação adicional |
|---|---:|---|
| Casa Voss | 12 | `grounded=true`, `route_open=true` |
| Ponte Marco 2 | 14 | `clearance=0.21`, `grounded=true`, `route_open=true` |
| Floresta Densa | 20 | passagem `2.4 m`, isolada |
| Majestic | 4 | âncora lateral preservada |
| Ruínas Submersas | 18 | submersa, não emissiva |
| Vegetação média | 0 | `wall_of_trees=false` |

Estado global: 6 candidatos, `production_scripts=0`, `dynamic_lights=0`. Não foram observados erros de parser ou script. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-306_CLEARANCE_RUNTIME.log`.
