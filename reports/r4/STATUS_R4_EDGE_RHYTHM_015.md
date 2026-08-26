# ORIGEM — STATUS R4_EDGE_RHYTHM_015: Cadência da Borda

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-FOREST-EDGE-RHYTHM-015`
**Escopo:** pedras húmidas R4 existentes entre `Z=174` e `Z=182`

## Implementação

A tarefa introduz `levels/regions/r4/ForestEdgeRhythm.gd`. O módulo reposiciona uma pedra húmida R4 existente junto ao conector para Majestic, preservando uma leitura lateral progressiva e deixando o conector livre.

A tarefa não altera rota, câmara, lajes, clareira Orion, física, módulos Dev5, iluminação, partículas, vento, pós-processamento, interface ou narrativa explícita.

| Critério | Resultado |
|---|---|
| Pedra ajustada | 1 instância R4 existente |
| Faixa regional | `Z=174–182`, exterior à clareira Orion |
| Conector e corredor | 0 propostas rejeitadas; distância mínima de 6 m preservada |
| Integração R5 | Nenhum módulo, ativo ou sistema Dev5 alterado |
| Dinâmica | Zero `Light3D`, colisores, partículas, vento ou animação criados |

## Prova própria

A prova `qa/regions/verify_r4_edge_rhythm.gd` confirmou:

> `[ORIGEM_R4_EDGE_RHYTHM] ajustadas=1 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_EDGE_RHYTHM_OK] borda, conector, corredor e clareira R4 preservados.`

O parser Godot, a porta canónica R4 e as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` foram aprovados antes da publicação na branch `dev4/r4-dense-forest`.

Os avisos `ERROR: Parameter "material" is null.` observados após os harnesses pertencem ao backend dummy de renderização no encerramento headless. Não constituíram regressão: os marcadores de prova e a porta regional finalizaram com sucesso, sem novo erro de parser, script ou falha fatal.
