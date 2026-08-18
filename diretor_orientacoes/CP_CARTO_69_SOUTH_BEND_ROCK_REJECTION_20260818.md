# CP-CARTO-69 — Rejeição das Rochas da Curva Sul

## Hipótese

As três rochas laterais da curva sul do rio (z=115–132) ainda usavam o material base do activo e poderiam gerar props claros no corredor Arco→Floresta.

## Ensaio

Foi criado e aplicado `south_rock_material` com o material de ruína somente às três rochas laterais. O trilho, os fetos, as árvores, a água e os colisores permaneceram inalterados.

## Validação

O parser Godot 4.7.1 passou e a rota `arch_to_forest` correu por 36 segundos. A captura `cp_carto69_south_bend_1600x900.png` não mostrou ganho perceptível de leitura; a alteração escureceu pequenas rochas sem resolver os elementos claros ou oclusores restantes.

## Decisão

A aplicação de material e a variável local foram removidas integralmente. Não repetir esta materialização da curva sul sem nova evidência causal. CP-CARTO-56 continua aguardando Dev2.
