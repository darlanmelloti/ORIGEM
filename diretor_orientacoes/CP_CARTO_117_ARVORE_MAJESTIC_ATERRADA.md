# CP-CARTO-117 — Árvore Majestic Aterrada

## Causa e correcção

A telemetria da tomada de chegada identificou a silhueta suspensa no talude esquerdo como `ArvoreDaFloresta_28`, uma instância de conífera alta. A comparação QA com descida vertical confirmou que era a fonte visual; contudo, a descida isolada deixava a árvore artificialmente enterrada.

A correcção de produção substitui somente esta instância por `DARK_TREE` à escala 0,52. A nova malha tem base compatível com o talude e preserva a densidade florestal, a clareira do conector, a rota, os colisores e a distribuição regional.

## Validação obrigatória

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | PASS |
| Gameplay Majestic→Lago | 36 s, PASS |
| Árvore suspensa no talude | Removida |
| Rota, lajes e colisores | Preservados |
| Luzes dinâmicas novas | 0 |
| Decisão | PROMOTED |

**Evidência:** `/home/ubuntu/qa_evidence_dev1_cp245/majestic_to_lake_cp117_tree28_production/majestic_to_lake_36s.png`
