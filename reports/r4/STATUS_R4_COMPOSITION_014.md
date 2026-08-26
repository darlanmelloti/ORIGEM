# ORIGEM — STATUS R4_COMPOSITION_014: Composição da Aproximação

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-FOREST-APPROACH-COMPOSITION-014`
**Escopo:** copas focais R4 existentes entre `Z=152` e `Z=174`

## Implementação

A tarefa introduz `levels/regions/r4/ForestApproachComposition.gd`. O módulo equilibra duas copas focais R4 existentes sem colisores associados por pequenos ajustes de posição, escala e rotação. Uma copa com colisão associada foi deliberadamente preservada, mantendo a física de exploração já aprovada.

A tarefa mantém a abertura cartográfica, não cria parede vegetal e não altera a rota, a câmara, as lajes, a clareira Orion, a física, módulos Dev5, iluminação, partículas, vento, pós-processamento, interface ou narrativa explícita.

| Critério | Resultado |
|---|---|
| Copas ajustadas | 2 instâncias R4 existentes sem colisores associados |
| Física preservada | 1 copa com colisor associado excluída do ajuste |
| Faixa regional | `Z=152–174`, exterior à clareira Orion |
| Corredor | 0 propostas rejeitadas; distância mínima de 6 m preservada |
| Dinâmica | Zero `Light3D`, colisores, partículas, vento ou animação criados |

## Prova própria

A prova `qa/regions/verify_r4_approach_composition.gd` confirmou:

> `[ORIGEM_R4_COMPOSITION] ajustadas=2 colisores_ignorados=1 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_COMPOSITION_OK] composição, corredor, clareira e física R4 preservados.`

A entrega segue para a porta canónica R4 e para as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` antes de publicação.
