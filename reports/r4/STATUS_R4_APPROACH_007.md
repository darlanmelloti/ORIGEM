# ORIGEM — STATUS R4_APPROACH_007: Cadência da Aproximação a Majestic

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-FOREST-APPROACH-RHYTHM-007`
**Escopo:** massas laterais R4 entre a saída da clareira Orion e a fronteira anterior ao conector Majestic

## Implementação

A tarefa introduz `levels/regions/r4/ForestApproachRhythm.gd`. O módulo reorganiza apenas árvores, copas focais e fetos já existentes entre `Z=152` e `Z=170`. Cada ajuste é determinístico e estático: afastamento lateral, deslocamento longitudinal curto, escala moderada e rotação Y. A sequência conduz visualmente o trilho para Majestic sem invadir a área controlada por Dev5.

A clareira Orion `Z=126–151` é excluída, e todo elemento modulado permanece a pelo menos seis metros do trilho. Não são criados nós de geometria, materiais, luzes, colisores, partículas, vento, animação, shaders ou pós-processamento.

| Critério | Resultado |
|---|---|
| Instâncias ajustadas | 24 árvores, copas ou fetos R4 já existentes |
| Clareira Orion | 23 elementos na faixa protegida permaneceram sem modulação |
| Corredor | 0 propostas rejeitadas; elementos modulados além de 6 m |
| Fronteira Dev5 | Faixa de ajuste encerrada em `Z=170`, antes do conector Majestic |
| Luz e física | Zero `Light3D` e zero `StaticBody3D` criados |

## Prova própria

A prova `qa/regions/verify_r4_forest_approach_rhythm.gd` confirmou:

> `[ORIGEM_R4_APPROACH] ajustados=24 clareira_protegida=23 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_APPROACH_OK] aproximação R4, clareira, corredor e fronteira Dev5 preservados.`

A entrega requer agora a porta canónica R4 e as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` antes de publicação.
