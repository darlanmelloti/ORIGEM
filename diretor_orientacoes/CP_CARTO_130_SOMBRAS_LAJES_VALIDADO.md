# CP-CARTO-130 — Sombras das lajes validadas

## Hipótese

A saída da Casa Voss apresentava faixas escuras repetitivas entre as lajes da Estrada do Rio. Como as lajes são apenas a camada visual do caminho e os seus colisores baixos permanecem independentes, foi testada a desactivação da projecção de sombra apenas nessas malhas.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay Casa Voss→Estrada | 36 segundos |
| Captura tardia | 1600×900 no segundo 30 |
| Eixo, material e colisores | Preservados |
| Luzes dinâmicas adicionais | 0 |
| Resultado visual | PASS |

A captura demonstrou a leitura contínua e mais clara das lajes desde a soleira exterior até ao Arco. As faixas negras de sombra deixaram de fragmentar a rota, sem transformar o caminho em painel nem alterar a navegação.

> Evidência aprovada: `/home/ubuntu/qa_evidence_dev1_cp245/voss_to_road_cp130_slab_shadows/voss_to_road_36s.png`

## Decisão

**PROMOVIDO.** A configuração reduz pressão visual e de sombra na GTX 1050 Ti, preservando os volumes tridimensionais, o material PBR, o corredor físico e as âncoras cartográficas.
