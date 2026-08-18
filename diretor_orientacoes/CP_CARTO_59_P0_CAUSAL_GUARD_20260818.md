# CP-CARTO-59 — Guarda Causal dos Sinais P0

## Evidência

A sessão `forest_to_majestic` completou 36 segundos sem erro de script e a captura `cp_carto59_forest_majestic_1600x900.png` voltou a mostrar pontos ciano ao longo do corredor. A inspecção de `ForestLakeRegion.gd` confirmou que os três objectos `SinalP0Florestal_00..02`, posicionados em z=142, z=158 e z=174, usam material emissivo azul e cada um possui uma luz `BrilhoP0Florestal`.

## Decisão

A origem visual dos orbes do corredor foi atribuída de forma causal aos sinais P0. Contudo, a conversão desses sinais em pilares não emissivos já foi testada no CP-CARTO-34 e revertida por ausência de ganho perceptível. O código não é alterado neste checkpoint, impedindo uma repetição cega.

## Continuidade

CP-CARTO-56 continua aguardando a entrega Dev2 R6→R7. O próximo refinamento independente deve sair de uma lacuna não testada, fora dos sinais P0, das balizas de ruína, dos fetos ribeirinhos e das rochas de margem já auditadas.
