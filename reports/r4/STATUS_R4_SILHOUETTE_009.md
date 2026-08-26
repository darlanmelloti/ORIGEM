# ORIGEM — STATUS R4_SILHOUETTE_009: Continuidade das Silhuetas

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-FOREST-SILHOUETTE-CONTINUITY-009`
**Escopo:** árvores e copas R4 estáticas entre `Z=152` e `Z=164`

## Implementação

A tarefa introduz `levels/regions/r4/ForestSilhouetteContinuity.gd`. O módulo altera somente oito árvores ou copas R4 existentes que não possuem colisores associados. O ajuste é determinístico e estático, aplicado por posição exterior, escala moderada e rotação Y para remover intervalos repetitivos sem criar parede vegetal.

Seis instâncias com colisores associados foram deliberadamente excluídas, preservando toda a física já aprovada. A tarefa não altera clareira Orion, rota, câmara, limites regionais, acampamento, módulos Dev5, iluminação, partículas, vento, shaders ou pós-processamento.

| Critério | Resultado |
|---|---|
| Silhuetas ajustadas | 8 instâncias R4 existentes sem colisores associados |
| Física preservada | 6 instâncias com colisores excluídas do ajuste |
| Faixa regional | `Z=152–164`, posterior à clareira e anterior à borda Majestic |
| Corredor | 0 propostas rejeitadas; faixa mínima de 6 m preservada |
| Dinâmica | Zero luzes, colisores, partículas, vento ou animação criados |

## Prova própria

A prova `qa/regions/verify_r4_silhouette_continuity.gd` confirmou:

> `[ORIGEM_R4_SILHOUETTE] ajustadas=8 colisores_ignorados=6 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_SILHOUETTE_OK] silhuetas R4, corredor, clareira e física existente preservados.`

A entrega segue para a porta canónica R4 e para as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` antes de publicação.
