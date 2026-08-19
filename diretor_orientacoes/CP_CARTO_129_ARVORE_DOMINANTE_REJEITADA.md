# CP-CARTO-129 — Árvore dominante da saída Casa Voss rejeitada

## Hipótese

A auditoria de projecção identificou `NucleoDeArvoreEstrada_00` como a copa de maior presença no quadrante direito da saída da Casa Voss. A instância foi substituída reversivelmente pela árvore CC0 escura, mantendo posição, escala, orientação, rota e orçamento LOD.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay Casa Voss→Estrada | 36 segundos |
| Captura tardia | 1600×900 no segundo 30 |
| Rota e colisores | Preservados |
| Ganho visual | Insuficiente |

A substituição não corrigiu a dominante cromática das árvores que permanecem mais visíveis na tomada e não elevou a leitura do vale para o limiar de aceitação. Foi revertida.

> Evidência rejeitada: `/home/ubuntu/qa_evidence_dev1_cp245/voss_to_road_cp129_dominant_tree/voss_to_road_36s.png`

## Decisão

**REJEITADO.** Não repetir a troca desta instância. A próxima hipótese deve actuar sobre uma lacuna estrutural de composição ou caminho, não numa árvore isolada.
