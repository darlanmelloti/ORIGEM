# CP-D5-041 — Elias em terceira pessoa na passagem R6

**Escopo:** harness QA em `levels/dev5/` e utilização da apresentação isolada `EliasThirdPersonPresentation`. Este checkpoint não substitui `Player.gd`, não altera a câmara de produção e não modifica regiões.

## Resultado

O actor QA `EliasActorQA` recebeu o corpo em terceira pessoa de Elias, incluindo colete, cabelo assimétrico, espada lateral e câmara própria desactivada para a captura estática. O actor percorreu o mesmo corredor central aprovado no CP-D5-040, junto à baliza monolítica aterrada R6.

| Verificação | Resultado |
|---|---|
| Apresentação utilizada | `EliasThirdPersonPresentation` |
| Eixo do percurso | `X=60,00` |
| Baliza R6 | `(52, 260)` |
| Folga lateral | `6,05 m` |
| Mínimo QA | `4,00 m` |
| Ciclos completos em 36 s | 2 |
| Bloqueio de `test_move` | 0 |
| Alteração a `Player.gd` | 0 |
| Luzes dinâmicas adicionais | 0 |

O parser Godot 4.7.1 passou. A sessão QA completou 36 segundos, sem erro de parser, script ou asserção, e gerou captura interna. A imagem confirma que a silhueta real de Elias e a baliza permanecem separadas, embora a composição continue deliberadamente uma prova técnica de margem e não uma tomada cinematográfica regional.

**Estado:** aprovado como prova técnica de compatibilidade de apresentação. A integração no jogador principal exige revisão Dev1 e não está autorizada por este checkpoint.

## Próxima tarefa automática

**CP-D5-042 — Auditoria de contrato da câmara de Elias.** Verificar que os harnesses Dev5 deixam `follow_camera.current=false` quando usam câmara QA externa, para impedir concorrência de câmaras em futuras integrações. Não alterar `Player.gd` nem cenas regionais.
