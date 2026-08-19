# CP-D5-260 — Auditoria cartográfica integrada

## Resultado

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A auditoria confirmou seis candidatos cartográficos Dev5, todos com offset nulo, sem scripts de produção, e zero luzes dinâmicas adicionadas.

| Marco | Âncora | Colisões | Luzes | Script de produção |
|---|---:|---:|---:|---|
| Casa Voss | 1 | 12 | 1 estática | `false` |
| Ponte Marco 2 | 2 | 14 | 1 estática | `false` |
| Floresta Densa | 4 | 20 | 1 estática | `false` |
| Majestic | 5 | 4 | 1 estática | `false` |
| Ruínas Submersas | 6 | 18 | 1 estática | `false` |
| Vegetação média | 4 | 0 | 1 estática | `false` |

| Contrato | Resultado |
|---|---|
| Candidatos | 6 |
| Scripts de produção | 0 |
| Luzes dinâmicas adicionadas | 0 |
| Parede de árvores | `false` |
| Floresta: passagem | 2,4 m, isolada |
| Vegetação por composição | 1 PBR + 3 médias + 4 distantes |
| Ruínas submersas | emissive `false`, dynamic_lights `0` |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-260_CARTOGRAPHIC_AUDIT_RUNTIME.log`.
