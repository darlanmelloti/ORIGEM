# ORIGEM — STATUS R4_READABILITY_011: Legibilidade Orion→Majestic

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-ORION-APPROACH-READABILITY-011`
**Escopo:** raízes R4 existentes entre `Z=152` e `Z=170`

## Implementação

A tarefa introduz `levels/regions/r4/ForestApproachReadability.gd`. O módulo ajusta quatro raízes expostas existentes, deslocando-as para as bordas exteriores do trilho e variando a rotação. A composição reforça a direção de avanço entre Orion e Majestic por leitura ambiental, sem texto, interface, gatilhos ou narrativa explícita.

A clareira Orion permanece fora da faixa de trabalho. O módulo não cria nós de geometria, materiais, luzes, colisores, partículas, vento, animação, shaders ou pós-processamento, nem toca em elementos de Dev5.

| Critério | Resultado |
|---|---|
| Raízes ajustadas | 4 instâncias R4 existentes |
| Faixa regional | `Z=152–170`, exterior à clareira Orion |
| Corredor | 0 propostas rejeitadas; distância mínima de 6 m preservada |
| Narrativa e UI | Nenhum texto, interface, evento ou gatilho criado |
| Dinâmica | Zero `Light3D`, colisores, partículas, vento ou animação criados |

## Prova própria

A prova `qa/regions/verify_r4_approach_readability.gd` confirmou:

> `[ORIGEM_R4_READABILITY] ajustadas=4 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_READABILITY_OK] legibilidade lateral, corredor e clareira R4 preservados.`

A entrega segue para a porta canónica R4 e para as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` antes de publicação.
