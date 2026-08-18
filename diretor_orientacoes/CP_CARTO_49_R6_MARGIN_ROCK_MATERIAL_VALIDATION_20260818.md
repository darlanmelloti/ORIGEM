# CP-CARTO-49 — Material das Rochas de Margem R6

**Branch:** `feature/cine07-final`  
**Escopo:** rochas laterais da margem, acentos rochosos e afloramentos da chegada às Ruínas em `ForestLakeRegion.gd`.  
**Fronteira:** água, estela, lajes, colisores, luzes, combate e módulos R7–R12 não foram modificados.

## Diagnóstico causal e correcção aceite

O CP-CARTO-48 eliminou a hipótese de alfa dos fetos. A revisão do construtor R6 identificou então rochas instanciadas sem `_apply_material(...)`, que herdavam a aparência clara do activo base no modo OpenGL. Foi aplicado exclusivamente o `ruin_material` já usado pela arqueologia regional às rochas de margem, aos acentos e aos três afloramentos de chegada.

A comparação visual confirma que os pequenos props claros distribuídos no terreno desapareceram; a bacia recuperou continuidade material sem remover geometria nem reduzir a leitura física do caminho.

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Gameplay real | **30 segundos aprovados** no harness `ruins_arrival` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto49_margin_rock_1600x900.png` |
| Props claros de margem | **Eliminados** |
| Rota de chegada e colisores | **Preservados** |
| Luzes dinâmicas | **Sem alterações** |
| Regiões 7–12 | **Sem alterações** |

## Continuidade

O CP-CARTO-49 é aceite e fecha a investigação material iniciada no CP-CARTO-45. A próxima prova cartográfica deve avaliar a leitura da água e da estela após a limpeza material, mantendo a integração R6→R7 dependente da publicação Dev2 CP-D2-214.
