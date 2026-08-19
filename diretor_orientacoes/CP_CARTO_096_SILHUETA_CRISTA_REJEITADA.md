# CP-CARTO-096 — Silhueta Vegetal da Crista Rejeitada

## Decisão

**PASS técnico; REJECTED_VISUAL.** Uma terceira árvore detalhada CC0 foi introduzida temporariamente em `z=132`, afastada do eixo da rota e da clareira do Arco. O parser Godot 4.7.1 e 36 segundos de gameplay Casa Voss→Arco passaram sem regressões de rota ou colisão.

A captura não mostrou ganho perceptível de silhueta, de profundidade ou de legibilidade. A instância isolada foi integralmente removida de `RiverRoadJourney.gd`; permanecem apenas as duas árvores detalhadas originais, dentro do orçamento LOD.

## Evidência

| Verificação | Resultado |
|---|---|
| Gameplay real | 36 segundos, PASS |
| Captura | `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_ridge_tree/road_to_arch_36s.png` |
| Rota / colisores / luzes | Sem alteração |
| Estado final | Produção revertida |

## Regra derivada

Não repetir uma árvore detalhada isolada na crista `z≈132` com a mesma posição, escala ou orientação. A próxima hipótese ambiental deve actuar numa causa visual de maior dimensão e demonstrar diferença mensurável antes de promoção.
