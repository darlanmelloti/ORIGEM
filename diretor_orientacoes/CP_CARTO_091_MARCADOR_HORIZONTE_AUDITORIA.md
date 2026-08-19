# CP-CARTO-091 — Auditoria do Marcador Residual no Horizonte R1→R3

## Decisão

**PASS técnico; hipótese visual rejeitada.** A sonda transitória de nós visíveis foi executada na rota QA `road_to_arch` durante 36 segundos. A análise associou o candidato mais próximo no horizonte ao nó `MarcoRibeirinho_00`, parte de `MarcosDaMargemDoLago`, em `(-2.223816, 1.160844, 154.0)`.

Uma ocultação exclusiva de QA foi aplicada apenas à tampa rúnica e à luz do conjunto ribeirinho. A captura posterior permaneceu visualmente idêntica: o pequeno marcador azul-ciano persistiu. Por isso, `MarcoRibeirinho_00` e as respetivas tampas rúnicas foram excluídos como causa. A alteração foi integralmente revertida em `ForestLakeRegion.gd`; o jogo de produção continua inalterado.

## Validação

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay QA Casa Voss→Arco | 36 segundos, PASS |
| Sonda de nós visíveis | PASS; relatório emitido |
| Ocultação QA da hipótese | PASS técnico, sem ganho visual |
| Estado de produção após a prova | Revertido e preservado |

## Evidência

- Sonda: `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_node_probe_fixed/visible_nodes.txt`
- Captura de hipótese: `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_rune_cap_clean/road_to_arch_36s.png`
- Captura de referência PBR: `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_altpbr_clean/road_to_arch_36s.png`

## Próximo passo

Não repetir a hipótese `MarcoRibeirinho` nem ampliar filtros de cor. O marcador residual deve ser tratado apenas depois de uma nova atribuição por projecção/câmara que demonstre a correspondência exacta entre o nó e o pixel observado. O refinamento ambiental continua independente desta investigação.
