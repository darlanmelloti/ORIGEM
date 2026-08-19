# CP-CARTO-113 — Crista Secundária Rejeitada

## Objectivo

Testar um segundo plano topográfico real entre o Arco das Ruínas e a Floresta Densa, sem alterar a rota, as âncoras, os marcos ou as Regiões 7–12.

## Alteração avaliada

Foi aplicada de forma reversível uma elevação ampla, centrada em Z=174, com colo preservado no eixo da rota. Não foram adicionadas malhas, painéis, luzes ou colisores.

## Validação

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay Casa Voss→Arco | 36 s, PASS |
| Rota, lajes e Arco | Preservados |
| Ganho de profundidade no enquadramento | Insuficiente |
| Decisão visual | REJECTED_VISUAL |

A crista não produziu uma separação de planos suficientemente clara na captura de gameplay. A alteração foi revertida integralmente.

**Evidência:** `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_cp113_forest_ridge/road_to_arch_36s.png`
