# CP-CARTO-29 — Leitura de Props do Corredor Majestic→Ruínas

**Branch:** `feature/cine07-final`  
**Escopo:** Regiões 1–6 exclusivamente.  
**Estado:** validado tecnicamente; aceitação visual parcial e continuação automática aberta.

## Alteração aplicada

A passagem recupera a substituição dos caixotes cúbicos do corredor Majestic→Margem por rolos horizontais de campo, apoiados visualmente em afloramentos. As lanternas esféricas foram substituídas por lanternas cilíndricas baixas. Nos marcos ribeirinhos, os orbes Chronos foram reduzidos a tampas rúnicas discretas sobre pilares físicos; a sua emissão e alcance foram reduzidos sem remover o apoio de orientação de curta distância.

| Evidência | Resultado |
| --- | --- |
| Parser Godot 4.7.1 headless | **Aprovado** — sem erro de script, parse ou carregamento |
| Gameplay real | **Aprovado** — 30 segundos a partir de `ORIGEM_QA_ROUTE=forest_to_ruins` com `ORIGEM_QA_AUTOSTART_NEW_GAME=1` |
| Spawn do harness | **Aprovado** — Floresta→Ruínas: `(9.765063, 1.184086, 194.0)` com alvo `z=225.0` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto29_refined_forest_to_ruins_1600x900.png` |
| Integridade do diff | **Aprovado** — `git diff --check` sem saída |
| Fronteira Regiões 7–12 | **Preservada** |

## Avaliação visual

A captura confirma a redução dos elementos cúbicos e de parte dos orbes destacados, mas também confirma que a macro-leitura do corredor ainda não atinge o patamar visual de referência: a topografia e as massas florestais remotas continuam excessivamente uniformes no renderizador de compatibilidade. O estado não é tratado como conclusão artística.

> A validação técnica permite publicar este incremento; não autoriza uma pausa. A próxima tarefa aberta é um passe de composição do limiar da bacia, actuando sobre leitura de relevo, margens e massas orgânicas sem repetir ajustes já rejeitados de cor, água ou altura do leito.

## Continuidade Dev2

A ponta remota Dev2 ainda é `fd31a63`; a integração R6→R7 permanece em espera técnica legítima pelo CP-D2-214, enquanto a melhoria independente R1–R6 prossegue.
