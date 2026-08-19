# CP-CARTO-133 — Crista remota visível: rejeitada

## Hipótese

A massa escura atrás da Casa Voss foi atribuída ao modo `SHADOWS_ONLY` das `MontanhasReais`. Foi testada a renderização integral da mesma geometria 3D, sem alterar posição, distância, rotas ou número de luzes.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay Estrada→Casa Voss | 36 segundos |
| Captura tardia | 1600×900 no segundo 30 |
| Geometria | Real, sem painel plano |
| Resultado visual | REJECTED_VISUAL |

> Evidência: `/home/ubuntu/qa_evidence_dev1_cp245/road_return_voss_cp133_mountain_visible/road_return_voss_36s.png`

## Decisão

**REJEITADO.** Tornar a crista visível expôs a malha procedural de baixa resolução como uma série de cones com topos brancos, piorando a composição da Casa Voss. A alteração foi revertida. O próximo passe deve estudar uma silhueta de montanha por geometria mais densa ou por um activo 3D validado, nunca por painéis ou alterações de escala cartográfica.
