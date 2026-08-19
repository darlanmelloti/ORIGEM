# CP-D5-046 — Auditoria de integridade de câmara dos harnesses Elias

**Escopo:** `levels/dev5/` e documentação Dev5. Nenhum módulo regional, `Player.gd` ou câmara de produção foi alterado.

## Inventário

A varredura local identificou exactamente três harnesses Dev5 que instanciam `EliasThirdPersonPresentation`.

| Harness | Papel QA | Câmara da apresentação | Câmara de viewport |
|---|---|---|---|
| `EliasCameraContractPreview` | Contrato explícito de câmara | Inactiva | `CameraQAExterna` |
| `EliasR6ClearancePreview` | Passagem junto à baliza R6 | Inactiva | Câmara QA externa da cena |
| `EliasMajesticClearancePreview` | Passagem junto ao Pavilhão R5 | Inactiva | Câmara QA externa da cena |

## Correcção e validação

Durante a primeira varredura, os dois harnesses de percurso procuravam a apresentação pelo nome configurado antes de `_ready()`. Como a própria apresentação normaliza o nome do nó ao arrancar, a procura falhou e a asserção interrompeu a telemetria. A correcção guarda a instância `EliasThirdPersonPresentation` numa referência tipada no actor QA; assim, a auditoria não depende de nomes de nó mutáveis.

Após a correcção, o parser Godot 4.7.1 passou e cada harness de percurso executou 36 segundos, realizou dois ciclos completos e registou `elias_camera_current=false`. As capturas internas confirmam que a composição QA de R5 e R6 permaneceu visualmente inalterada.

| Critério | Resultado |
|---|---|
| Harnesses auditados | 3 de 3 |
| Cenas de percurso com 36 s | 2 de 2 |
| Câmara de Elias activa em harness QA externo | 0 |
| Erros de parser/script/assertion após correcção | 0 |
| Alterações em `Player.gd` | 0 |
| Alterações em módulos regionais | 0 |

**Estado:** aprovado. Qualquer novo harness Dev5 que utilize Elias deve conservar uma referência tipada à apresentação e verificar que a câmara QA externa é a proprietária da viewport.

## Próxima tarefa automática

**CP-D5-047 — Matriz de contratos de apresentação de Elias.** Consolidar os contratos de câmara, colisão QA, trajecto e isolamento de produção numa ficha única para revisão de integração Dev1. A tarefa é documental e não promove a apresentação de Elias ao jogador principal.
