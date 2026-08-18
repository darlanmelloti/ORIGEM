# CP-CARTO-43 — Integridade do Menu e Novo Jogo

**Branch:** `feature/cine07-final`  
**Escopo:** `ui/menus/MainMenu.tscn`, referência de script do menu principal.  
**Fronteira:** não foram alterados gameplay, regiões, geometria, materiais, combate, luzes ou módulos Dev2.

## Correcção

A validação visual anterior do fluxo público de entrada revelou um aviso de recurso: o `MainMenu.tscn` mantinha um UID já inexistente para `MainMenu.gd`. O Godot recuperava pelo caminho textual, mas registava um aviso que não deve acompanhar a base validada. Foi removido apenas o UID inválido; o caminho canónico `res://ui/menus/MainMenu.gd` e a ligação de `Novo Jogo` permanecem inalterados.

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Aviso de UID inválido do MainMenu | **Eliminado** |
| Menu principal | **Carregado** |
| Novo Jogo por fluxo público | **Aprovado** com botão focado e tecla Enter |
| Gameplay real após Novo Jogo | **30 segundos aprovados** |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto43_menu_newgame_1600x900.png` |
| Erros de carga, parse ou runtime | **Nenhum encontrado** |

## Registo de iterações rejeitadas

- **CP-CARTO-41:** relva procedimental lateral revertida. A evidência mostrou tufos demasiado grandes e esparsos, com leitura de protótipo inferior à base publicada.
- **CP-CARTO-42:** tonalização PBR global dos fetos revertida. Não alterou os props claros observados na tomada da bacia, logo não foi promovida.

## Continuidade

O estado publicado mantém somente melhorias com ganho demonstrado. A próxima lacuna é a leitura ampla da bacia das Ruínas: identificar por geometria e posição a origem dos pequenos props claros, sem repetir a alteração de fetos e sem tocar no limiar R6→R7 que depende do Dev2.
