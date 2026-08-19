# CP-CARTO-114 — Transição Lajes→Arco Validada

## Alteração promovida

As lajes do troço final da Estrada do Rio passaram a aumentar progressivamente a sua profundidade visual entre Z=76 e Z=120. A malha fica mais contínua na aproximação ao Arco, sem mover o eixo da estrada, as âncoras, a posição do marco, as luzes, os colisores existentes ou a água.

## Validação obrigatória

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | PASS |
| Gameplay Casa Voss→Arco | 36 s, PASS |
| Captura 1920×1080 | PASS |
| Continuidade visual da rota | PASS |
| Luzes dinâmicas novas | 0 |
| Âncoras e rota física | Preservadas |

A captura mostra uma leitura contínua das lajes até ao marco, eliminando a quebra visual dominante dos degraus isolados no limiar do Arco. O ganho é local, observável e compatível com a cartografia oficial.

**Evidência:** `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_cp114_slab_transition/road_to_arch_36s.png`
