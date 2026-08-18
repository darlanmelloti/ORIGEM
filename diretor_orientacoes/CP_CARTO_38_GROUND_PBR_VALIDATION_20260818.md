# CP-CARTO-38 — Material PBR de Solo Húmido

**Branch:** `feature/cine07-final`  
**Escopo:** `TerrainPatch.gd`, material visual de terreno partilhado pelas Regiões 1–6.  
**Fronteira:** nenhuma geometria, colisão, luz dinâmica ou módulo das Regiões 7–12 foi alterado.

## Alteração aceite

A captura do corredor Floresta→Ruínas mostrava o solo excessivamente negro e uniforme no renderizador OpenGL de compatibilidade. O passe ajusta exclusivamente o shader do terreno: aumenta a participação da textura PBR de solo húmido, preserva roughness alta, conserva normal map e mantém a variação procedural de folha, terra e seixos. Não altera `height_at`, malha, lajes, água ou colisores.

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Gameplay real | **30 segundos aprovados** via `ORIGEM_QA_ROUTE=forest_to_ruins` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto38_ground_iter2_1600x900.png` |
| Leitura de micro-textura e valor no solo | **Melhorada** |
| Física / rota de lajes | **Inalterada e jogável** |
| Luzes dinâmicas | **Sem adições** |
| Regiões 7–12 | **Fora do harness e sem alterações** |

## Avaliação visual

A segunda calibração recupera variação terrosa e detalhe PBR no primeiro plano, sem introduzir reflexo molhado artificial nem apagar a continuidade das lajes. O passe é aceite como melhoria localizada, não como fecho estético do vale. A fila contínua mantém como próximo alvo a redução de leitura de protótipo dos elementos de escala no corredor, sem repetir os pilotos de árvores e de neblina que não demonstraram ganho.
