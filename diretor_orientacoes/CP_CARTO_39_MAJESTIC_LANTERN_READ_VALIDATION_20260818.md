# CP-CARTO-39 — Leitura das Lanternas Majestic→Ruínas

**Branch:** `feature/cine07-final`  
**Escopo:** `ForestLakeRegion.gd`, conector físico entre o Acampamento Majestic e a margem das Ruínas Submersas.  
**Fronteira:** não foram alteradas Regiões 7–12, geometria de subida R7, rota de lajes, colisores nem o total de luzes da integração futura.

## Alteração aceite

As quatro lanternas laterais do conector eram materialmente lidas como marcadores vermelhos de protótipo. A geometria física de lanterna, os rolos de campo, os afloramentos e os pilares foram preservados. Foi reduzida exclusivamente a saturação e a energia de emissão, juntamente com o alcance e a energia da luz auxiliar de cada lanterna. O resultado mantém orientação a curta distância, mas deixa o percurso e a paisagem serem os elementos dominantes.

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Gameplay real | **30 segundos aprovados** via `ORIGEM_QA_ROUTE=forest_to_ruins` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto39_lantern_1600x900.png` |
| Rota de lajes | **Livre e legível** |
| Marcadores vermelhos isolados | **Reduzidos a brasas âmbar discretas** |
| Luzes dinâmicas | **Sem adições; energia e alcance reduzidos** |
| Regiões 7–12 | **Sem alterações** |

## Continuidade

O CP-CARTO-39 é uma melhoria localizada aceite. A imagem ainda contém sinalizações azuis e silhuetas de vegetação que exigem refinamento estrutural futuro; não serão removidas por troca cega. A próxima tarefa aberta é uma auditoria visual e física dos marcos laterais restantes para distinguir elementos de gameplay necessários de sinais de protótipo substituíveis.
