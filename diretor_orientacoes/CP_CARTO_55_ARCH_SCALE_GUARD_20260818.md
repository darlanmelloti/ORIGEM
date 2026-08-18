# CP-CARTO-55 — Guarda de escala cartográfica do Arco

A auditoria da orientação QA verificou uma aparente divergência entre `CartographicAnchors.ARCO_RUINAS = (-16.741, 48.0)` e o alvo físico `z=92.0` usado pelas tomadas Estrada→Arco.

Não é uma divergência de mapa. `RiverRoadJourney.gd` aplica `ROAD_MACRO_ORIGIN_Z = 8.0` e `ROAD_MACRO_FACTOR = 2.1`; a projecção física do intervalo cartográfico desde o início da estrada (`z=12`) até ao marco Arco (`z=48`) resulta em aproximadamente `8 + (48 - 8) × 2.1 = 92`. O alvo z=92 é, portanto, a posição física escalada coerente com o mapa oficial e não deve ser substituído directamente por z=48.

## Decisão

Não foi modificada qualquer câmara, FOV, âncora, rota, árvore ou geometria regional. A próxima prova macro deve tratar a composição e a oclusão com a relação de escala preservada. Esta guarda evita que uma tentativa de QA desloque artificialmente a câmara para o ponto cartográfico em vez de apontar para o marco físico correspondente.
