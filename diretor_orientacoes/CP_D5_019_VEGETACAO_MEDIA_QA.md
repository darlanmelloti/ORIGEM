# CP-D5-019 — Vegetação média dos marcos 4 e 5

## Resultado

Foi criada a cena QA `MediumVegetationCompositionPreview.tscn`, usando obrigatoriamente `CartographicPlacementSystem.gd` para os marcos 4 e 5. Cada composição declara o marco, a posição canónica no mapa e `local_offset=(0,0)`. O candidato permanece isolado e não toca `ForestLakeRegion.gd`.

Cada composição utiliza uma árvore PBR focal, três árvores detalhadas no plano médio e quatro alternativas leves no plano distante. As posições são irregulares, com rotações variadas e sem filas, parede contínua de árvores ou relva tridimensional. O limite PBR auditado no CP-D5-018 foi respeitado.

| Composição | Âncora | PBR focal | Plano médio | Plano distante |
|---|---|---:|---:|---:|
| Floresta Densa | Marco 4, `(-9, 116)` | 1 | 3 | 4 |
| Acampamento Majestic | Marco 5, `(-88, 178)` | 1 | 3 | 4 |

## Validação

A cena passou o parser e completou 36 segundos em Godot headless. O runtime confirmou os dois placement records, `pbr_per_composition=1`, `medium_per_composition=3`, `distant_per_composition=4`, `wall_of_trees=false` e `production_script=false`. Não foram encontrados erros Dev5; o aviso FSR1 é externo ao renderer de compatibilidade.

A próxima tarefa deve ser consultada no marcador após a publicação deste checkpoint.
