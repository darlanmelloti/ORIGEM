# CP-CARTO-61 — Rejeição do Material das Rochas do Limiar Florestal

## Hipótese

As cinco instâncias `RochaLimiarFloresta` do limiar Arco→Floresta não tinham material explícito e poderiam explicar fragmentos claros no corredor.

## Validação

O parser Godot 4.7.1 passou e a sessão `forest_to_majestic` completou 36 segundos sem erros. A captura `cp_carto61_forest_threshold_1600x900.png` não mostrou ganho perceptível quando as rochas receberam `ruin_material`.

## Decisão

O ensaio foi revertido integralmente. Não repetir a materialização das rochas do limiar florestal como tentativa de remover os orbes ou props visuais do corredor. CP-CARTO-56 continua aguardando a publicação Dev2 para a integração R6→R7.
