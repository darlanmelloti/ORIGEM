# ORIGEM — STATUS R4_DEPTH_010: Equilíbrio de Profundidade Lateral

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-FOREST-DEPTH-BALANCE-010`
**Escopo:** fetos R4 existentes entre `Z=153` e `Z=169`

## Implementação

A tarefa introduz `levels/regions/r4/ForestDepthBalance.gd`. O módulo reorganiza três fetos R4 existentes em dois planos laterais determinísticos, usando afastamentos de 6,35 m e 8,15 m do trilho. A composição acrescenta profundidade à leitura da floresta sem criar uma parede vegetal nem adicionar instâncias novas.

A clareira Orion permanece fora da faixa de trabalho. A tarefa não altera rota, câmara, física, módulos Dev5, iluminação, partículas, vento, shaders ou pós-processamento.

| Critério | Resultado |
|---|---|
| Fetos ajustados | 3 instâncias R4 existentes |
| Profundidade | Dois planos laterais estáticos e verificáveis |
| Faixa regional | `Z=153–169`, posterior à clareira e anterior ao conector Majestic |
| Corredor | 0 propostas rejeitadas; distância mínima de 6 m preservada |
| Dinâmica | Zero `Light3D`, colisores, partículas, vento ou animação criados |

## Prova própria

A prova `qa/regions/verify_r4_forest_depth_balance.gd` confirmou:

> `[ORIGEM_R4_DEPTH] ajustados=3 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_DEPTH_OK] profundidade lateral, corredor e clareira R4 preservados.`

A entrega segue para a porta canónica R4 e para as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` antes de publicação.
