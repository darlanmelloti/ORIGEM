# CP-CARTO-64 — Rejeição da Máscara QA Tardia Casa Voss→Estrada

## Hipótese

A prova reconhecida `road_return_voss` ainda apresentava um orbe ciano. Foi testada uma máscara repetida, exclusiva de QA, que reutilizava a limpeza técnica do prólogo nos primeiros 1,8 segundos de criação regional.

## Validação

Godot 4.7.1 passou e a sessão de gameplay durou 36 segundos. A captura `cp_carto64_delayed_mask_1600x900.png` manteve o orbe residual na mesma posição e não apresentou ganho visual mensurável.

## Decisão

A máscara QA foi removida integralmente. Não repetir este tratamento de marcadores tardios sem uma atribuição directa por nó e projecção. O harness reconhecido `road_return_voss` de CP-CARTO-63 permanece válido. CP-CARTO-56 continua aguardando Dev2.
