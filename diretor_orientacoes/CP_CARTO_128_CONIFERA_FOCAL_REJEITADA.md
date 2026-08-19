# CP-CARTO-128 — Substituição de conífera focal rejeitada

## Hipótese

A instância PBR focal `NucleoDeArvoreEstrada_01` foi substituída reversivelmente por uma árvore CC0 escura, mantendo a mesma âncora, orientação, escala, rota e orçamento LOD.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay Casa Voss→Arco | 36 segundos |
| Captura tardia | 1600×900 no segundo 30 |
| Colisão e rota | Sem alteração |
| Ganho visual na tomada | Insuficiente |

A comparação demonstrou que a instância não ocupa uma área determinante no enquadramento real de saída da Casa Voss. A troca não melhorou a leitura da vegetação nem do Arco e foi revertida.

> Evidência rejeitada: `/home/ubuntu/qa_evidence_dev1_cp245/voss_to_road_cp128_dark_tree/voss_to_road_36s.png`

## Decisão

**REJEITADO.** Não voltar a trocar esta instância por cor ou espécie. O próximo passe deve atribuir as árvores realmente projectadas na tomada inicial, em vez de inferir o candidato a partir da posição cartográfica.
