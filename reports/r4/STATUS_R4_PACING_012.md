# ORIGEM — STATUS R4_PACING_012: Ritmo Visual do Trilho

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-FOREST-TRAIL-PACING-012`
**Escopo:** pedras húmidas R4 existentes entre `Z=152` e `Z=170`

## Implementação

A tarefa introduz `levels/regions/r4/ForestTrailPacing.gd`. O módulo ajusta duas pedras húmidas R4 existentes, alternando a sua leitura entre as bordas exteriores do trilho. Nenhuma laje, rota, câmara, colisão ou elemento de Dev5 é alterado.

A clareira Orion permanece fora da faixa de intervenção. A entrega não cria geometria, materiais, luzes, colisores, partículas, vento, animação, shaders, pós-processamento, texto, interface ou eventos.

| Critério | Resultado |
|---|---|
| Pedras ajustadas | 2 instâncias R4 existentes |
| Faixa regional | `Z=152–170`, exterior à clareira Orion |
| Lajes e rota | Sem alteração |
| Corredor | 0 propostas rejeitadas; distância mínima de 6 m preservada |
| Dinâmica | Zero `Light3D`, colisores, partículas, vento ou animação criados |

## Prova própria

A prova `qa/regions/verify_r4_trail_pacing.gd` confirmou:

> `[ORIGEM_R4_PACING] ajustadas=2 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_PACING_OK] ritmo visual, lajes, corredor e clareira R4 preservados.`

A entrega segue para a porta canónica R4 e para as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` antes de publicação.
