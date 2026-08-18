# CP-CARTO-68 — Rejeição do Piloto de Árvore PBR da Estrada

## Hipótese

Uma única árvore PBR local no plano médio da Estrada do Rio poderia melhorar a silhueta vista no corredor Estrada→Arco sem substituir em massa os activos existentes.

## Ensaio

A instância `ArvoreEstrada_05` foi substituída por `PINE_MEDIUM`, mantendo posição, escala, rota e todos os restantes grupos arbóreos.

## Validação

O parser Godot 4.7.1 passou e o harness `road_to_arch` correu por 36 segundos. A captura `cp_carto68_road_tree_1600x900.png` não mostrou ganho perceptível na leitura da silhueta ou da composição do corredor.

## Decisão

A substituição foi revertida integralmente. Não repetir o piloto em `ArvoreEstrada_05` sem uma evidência de enquadramento nova. CP-CARTO-56 continua aguardando Dev2.
