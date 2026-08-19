# CP-D5-067 — Elias na Floresta Densa R4

**Escopo:** harness QA isolado em `levels/dev5/`. Não altera `ForestLakeRegion.gd`, `TempleLevel.gd`, `Player.gd` ou geometria de produção.

## Objectivo

Validar que Elias pode atravessar o eixo central da Floresta Densa mantendo a abertura definida pela composição vegetal Dev5. O candidato não recria o portal florestal estrutural rejeitado e não usa uma parede de árvores.

| Critério | Resultado QA |
|---|---|
| Âncora | R4 `(-9,116)` |
| Vegetação | 6 instâncias reais aterradas por raycast |
| Corredor | Largura central de `5,20 m` |
| Folga mínima calculada | `2,75 m` após raio de Elias (`0,55 m`) |
| Aterramento | `grounded=true` e X/Z preservado em 6/6 candidatos |
| Passagem | 3 ciclos em 36 segundos, sem bloqueio técnico |
| Paredes / portal | `wall_of_trees=false`, `forest_portal=false` |
| Luzes | Uma direccional QA; zero Omni/Spot |

## Validação

O primeiro parser identificou uma inferência de tipo ambígua no cálculo de folga. A variável foi tipada explicitamente e a segunda validação passou no Godot 4.7.1, em sessão gráfica de 36 segundos e captura interna. A composição visual permanece QA; não constitui aprovação artística da Floresta Densa nem promoção automática a produção.

## Próxima tarefa automática

**CP-D5-068 — Comparação de corredor R4/R5.** Auditar lado a lado as garantias de passagem de Elias na Floresta Densa e no Acampamento Majestic, assegurando que os dois corredores preservam aterramento, câmara externa e ausência de paredes vegetais.
