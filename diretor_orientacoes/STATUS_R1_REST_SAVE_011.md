# STATUS CHECKPOINT — R1 REST SAVE 011

**Branch:** `integration/r1-r6-sprint1`  
**Responsável:** Dev1  
**Data:** 25 de agosto de 2026

## Entrega

A lareira da Casa Voss tornou-se o primeiro ponto de repouso funcional do ORIGEM. Ao interagir com ela, Elias recupera vida e stamina, o estado atual é guardado no slot 0 e o jogador recebe uma confirmação narrativa.

| Componente | Comportamento |
|---|---|
| `VossRestFire` | Gatilho físico interativo junto à lareira |
| `Player.rest_at_safe_point()` | Restaura vida e stamina ao máximo |
| `SaveManager.save_game(0)` | Grava a posição, rotação, vida, stamina e estados persistentes atuais |
| Feedback | Confirma recuperação e memória guardada |

## Correção transversal descoberta em QA

O primeiro carregamento revelou um erro real no `TimelineManager`: JSON retorna `Array` sem tipo, mas `visited_eras` é `Array[int]`. A desserialização agora reconstrói explicitamente `visited_eras` e `active_consequences` com os tipos adequados antes de restaurar o perfil temporal. A correção beneficia todos os saves do projeto, não só R1.

## Ficheiros

| Ficheiro | Alteração |
|---|---|
| `levels/VossHouse.gd` | Gatilho da lareira e harness QA de repouso |
| `scripts/main.gd` | Fluxo de recuperação e save do ponto de repouso |
| `entities/player/Player.gd` | Recuperação integral e persistência do estado/posição do jogador |
| `core/timeline/TimelineManager.gd` | Desserialização tipada de JSON para saves estáveis |

## Validação

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 — parser headless | PASS |
| Recuperação de vida e stamina | PASS |
| Save no slot 0 | PASS |
| Load do slot 0 | PASS |
| Estado do jogador após load | PASS |
| Erro temporal Array → Array[int] | Corrigido |
| Erro fatal / script na sessão de 14 s | Nenhum |
