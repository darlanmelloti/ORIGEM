# CP-D5-246 — Regressão River Road R2 viva

## Resultado

A cena `R2LivingRiverRoadPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição R2 mantém a travessia modular do rio, abrigo e vegetação aterrados, rota livre e nenhum GLB de ponte rejeitado.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 4 elementos |
| Partes de abrigo | 2 |
| Ponte | modular, `modular_bridge=true` |
| GLB rejeitado | `bridge_glb=false` |
| Elementos aterrados | 9 |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |
| Ciclos de rota | 5, todos com `bridge_crossed=true` e `clear=true` |
| Distância de fauna | 12,08–12,93 |

A regressão aprova a River Road R2 viva e a travessia modular, preservando a regra de não introduzir o activo GLB rejeitado nem alterar produção. O log está em `CP-D5-246_R2_RIVER_ROAD_RUNTIME.log`.
