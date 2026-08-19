# CP-D5-043 — Elias junto ao Pavilhão Majestic R5

**Escopo:** harness QA em `levels/dev5/`. O checkpoint não altera `ForestLakeRegion.gd`, `Player.gd`, rotas de produção, colisores regionais ou iluminação de produção.

## Prova de passagem

A cena instanciou o Pavilhão Majestic pela biblioteca Dev5 e aplicou `CartographicGroundingSystem.gd` à âncora R5 `(-88, 178)`. Elias foi instanciado apenas pela apresentação isolada de terceira pessoa, com cápsula de QA independente, e percorreu um corredor central em `X=-80`.

| Verificação | Resultado |
|---|---|
| Pavilhão aterrado | Sim |
| Coordenada cartográfica do pavilhão | `(-88, 178)` |
| Eixo do corredor QA | `X=-80` |
| Largura semi-ocupada do pavilhão QA | `2,00 m` |
| Raio QA de Elias | `0,55 m` |
| Folga lateral | `5,45 m` |
| Mínimo QA | `4,00 m` |
| Ciclos completos em 36 s | 2 |
| Bloqueios `test_move` | 0 |
| Luzes dinâmicas adicionadas | 0 |

O parser Godot 4.7.1 passou, a sessão decorreu durante 36 segundos e a captura interna confirmou Elias e o pavilhão como volumes distintos, sem obstrução no trajecto. O resultado é uma prova de segurança de composição, não uma integração regional nem uma tomada cinematográfica final.

**Estado:** aprovado como QA técnico. A promoção do pavilhão ou da configuração de percurso exige revisão Dev1, 30 segundos de gameplay Floresta→Majestic→Margem e validação cartográfica no mundo real.

## Próxima tarefa automática

**CP-D5-044 — Auditoria de contrato de câmara de Elias.** Verificar que os harnesses Dev5 deixam `follow_camera.current=false` quando usam uma câmara QA externa, evitando concorrência de câmaras em possíveis integrações. Esta tarefa não altera `Player.gd` nem módulos regionais.
