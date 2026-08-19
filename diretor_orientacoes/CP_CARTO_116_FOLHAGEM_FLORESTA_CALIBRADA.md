# CP-CARTO-116 — Folhagem da Floresta Densa Calibrada

## Causa identificada

A projecção da câmara no marcador de cor excessivamente ciana na rota Floresta Densa→Acampamento Majestic convergiu para `ArvoreDaFloresta_50`, uma instância do activo `tree_oak_dark`. A comparação QA que reduziu a componente azul da folhagem eliminou o sinal visível, preservando geometria, textura, tronco, escala e rota.

## Alteração promovida

Foi acrescentada uma calibração de material exclusivamente às instâncias `OAK_DARK` da Floresta Densa. A rotina duplica apenas materiais de folhagem com dominante verde-azulada e reduz a componente azul, sem alterar pinheiros, troncos, colisores, luzes, posições ou LOD.

## Validação obrigatória

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | PASS |
| Gameplay Floresta→Majestic | 36 s, PASS |
| Rota, lajes e colisores | Preservados |
| Luzes dinâmicas novas | 0 |
| Excesso ciano no carvalho causal | Corrigido |
| Decisão | PROMOTED |

**Evidência:** `/home/ubuntu/qa_evidence_dev1_cp245/forest_to_majestic_cp116_foliage/forest_to_majestic_36s.png`
