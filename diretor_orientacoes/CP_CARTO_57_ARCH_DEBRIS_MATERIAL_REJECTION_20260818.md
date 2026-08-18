# CP-CARTO-57 — Rejeição do Material de Entulho do Arco

## Hipótese

Quatro instâncias `EntulhoArcoEstrada` herdavam o material base do activo `RUIN_ROCK`. Foi testada a aplicação do `ruin_material`, por analogia à correcção causal aprovada nas rochas da margem R6.

## Validação

O parser Godot 4.7.1 passou e a tomada oficial do estágio `arco` permaneceu estável durante 36 segundos. A captura `cp_carto57_arch_debris_1600x900.png` mostrou que os pequenos pontos ciano persistem e que não houve ganho visual perceptível no Arco.

## Decisão

O ensaio foi integralmente revertido. A origem dos pontos ciano não são as quatro instâncias de entulho do Arco; não repetir esta hipótese. O Arco e os seus materiais retornaram ao último estado publicado, preservando CP-CARTO-55 e o escopo exclusivo das Regiões 1–6.
