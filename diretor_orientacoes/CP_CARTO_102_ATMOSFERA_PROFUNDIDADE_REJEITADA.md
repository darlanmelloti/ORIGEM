# CP-CARTO-102 — Profundidade Atmosférica Rejeitada

## Resultado

Foi testado exclusivamente em QA um perfil de neblina moderadamente mais denso na rota Casa Voss→Arco. O teste técnico passou com 36 segundos de gameplay e a rota, a câmara, o FOV, as luzes, a água e a geometria foram preservados.

A captura reduziu o contraste dos detalhes intermédios e não criou uma separação de planos suficiente para superar o estado diurno actual. O perfil e a rota comparativa foram removidos de `LevelEnvironment.gd` e `TempleLevel.gd`.

| Item | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay | 36 segundos, PASS |
| Evidência | `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_depth_cp102/road_to_arch_depth_36s.png` |
| Avaliação artística | REJECTED_VISUAL |
| Estado final | Produção restaurada |

A próxima melhoria não deve repetir ajuste de densidade, cor, saturação ou `fog_sky_affect` como tentativa isolada de resolver a profundidade do vale.
