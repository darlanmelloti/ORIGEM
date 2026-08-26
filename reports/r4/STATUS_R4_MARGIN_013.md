# ORIGEM — STATUS R4_MARGIN_013: Continuidade da Margem Ambiental

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-FOREST-MARGIN-CONTINUITY-013`
**Escopo:** raízes R4 existentes entre `Z=171` e `Z=181`

## Implementação

A tarefa introduz `levels/regions/r4/ForestMarginContinuity.gd`. O módulo reorganiza duas raízes R4 existentes na margem exterior posterior à aproximação, suavizando a passagem visual sem criar elementos novos ou aproximar objetos do corredor.

A clareira Orion, a rota, as lajes, a câmara, a física, os módulos Dev5, a iluminação, as partículas, o vento e o pós-processamento permanecem inalterados.

| Critério | Resultado |
|---|---|
| Raízes ajustadas | 2 instâncias R4 existentes |
| Faixa regional | `Z=171–181`, exterior à clareira Orion |
| Corredor | 0 propostas rejeitadas; distância mínima de 6 m preservada |
| Integração R5 | Nenhum módulo, ativo ou sistema Dev5 alterado |
| Dinâmica | Zero `Light3D`, colisores, partículas, vento ou animação criados |

## Prova própria

A prova `qa/regions/verify_r4_margin_continuity.gd` confirmou:

> `[ORIGEM_R4_MARGIN] ajustadas=2 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_MARGIN_OK] margem ambiental, corredor e clareira R4 preservados.`

A entrega segue para a porta canónica R4 e para as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` antes de publicação.
