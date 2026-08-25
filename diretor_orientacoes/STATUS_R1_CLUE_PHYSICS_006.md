# STATUS CHECKPOINT — R1 CLUE PHYSICS 006

**Branch:** `integration/r1-r6-sprint1`  
**Responsável:** Dev1  
**Data:** 25 de agosto de 2026

## Verificação concluída

A camada narrativa da Casa Voss foi confrontada com os objetos físicos que o jogador realmente mira. Não foi necessária correção visual ou de colisão: os três gatilhos já existiam e foram confirmados na camada usada pelo `InteractRay`.

| Gatilho | Grupo | Camada física | Resultado QA |
|---|---|---:|---|
| `TomasTable` | `interactable` | 4 | PASS |
| `MountainMap` | `interactable` | 4 | PASS |
| `MiguelTools` | `interactable` | 4 | PASS |

O harness `ORIGEM_QA_INTERACT=voss_clues` agora confere explicitamente a existência do `StaticBody3D`, o grupo `interactable` e a camada 4 antes de executar cada leitura narrativa. Isto garante que a pista não é apenas texto disponível por código, mas um objeto que pode ser alcançado pelo jogador.

## Validação

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 — parser headless | PASS |
| QA de física dos três gatilhos | PASS |
| QA da primeira leitura das três pistas | PASS |
| Erro fatal / script na sessão de 12 s | Nenhum |
