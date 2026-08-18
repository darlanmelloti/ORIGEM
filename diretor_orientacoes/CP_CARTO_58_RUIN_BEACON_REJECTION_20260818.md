# CP-CARTO-58 — Rejeição de Desaturação das Balizas da Bacia

## Hipótese

Os `BrilhoMarcoRuina` da bacia R6 poderiam explicar a leitura ciano da tomada `ruins_arrival`. O ensaio reduziu a energia de 0,56 para 0,22, o alcance de 9,5 m para 6,0 m e substituiu o azul por uma luz neutra.

## Validação

O parser Godot 4.7.1 passou e a sessão `ruins_arrival` completou 36 segundos sem erros de script. A captura `cp_carto58_ruin_beacons_1600x900.png` manteve os props claros e o ponto ciano visíveis, sem ganho perceptível de leitura da bacia.

## Decisão

O ensaio foi revertido integralmente. As balizas dos marcos emergentes não são a fonte causal dos artefactos visuais em questão; não repetir esta hipótese. CP-CARTO-56 continua aguardando a publicação Dev2 para a integração R6→R7.
