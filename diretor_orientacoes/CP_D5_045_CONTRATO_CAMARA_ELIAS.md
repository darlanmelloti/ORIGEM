# CP-D5-045 — Contrato de câmara de Elias em QA

**Escopo:** harness isolado em `levels/dev5/`, sem alteração a `Player.gd`, câmaras de produção ou módulos regionais.

## Objectivo

Confirmar que uma cena Dev5 pode mostrar a apresentação de Elias em terceira pessoa sem permitir que a câmara interna da apresentação substitua a câmara QA responsável pela captura. O contrato evita concorrência de câmaras em testes futuros e preserva a separação entre apresentação técnica e controlador principal.

| Verificação | Resultado |
|---|---|
| Apresentação usada | `EliasThirdPersonPresentation` |
| Câmara de Elias | `follow_camera.current=false` |
| Câmara QA externa | `CameraQAExterna.current=true` |
| Proprietário da viewport | `CameraQAExterna` |
| Câmaras activas no harness | 1 |
| Alteração a `Player.gd` | 0 |
| Alteração a módulos regionais | 0 |

## Validação

O parser Godot 4.7.1 passou. A cena decorreu durante 36 segundos sem `SCRIPT ERROR`, `Parse Error` ou asserção e gerou captura interna. A imagem confirma a silhueta de Elias sob a câmara QA externa; a apresentação não tomou controlo da viewport.

**Estado:** aprovado como contrato técnico QA. Qualquer futura cena Dev5 que instancie Elias deve manter este contrato ou documentar explicitamente uma excepção antes de activar outra câmara.

## Próxima tarefa automática

**CP-D5-046 — Auditoria de integridade de câmara dos harnesses Elias.** Criar uma varredura que detecte cenas Dev5 com `EliasThirdPersonPresentation` e confirme uma única câmara activa por cena. A auditoria não altera produção.
