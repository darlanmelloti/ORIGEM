# ORIGEM — STATUS R4_EDGE_008: Equilíbrio da Borda R4→R5

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-MAJESTIC-EDGE-BALANCE-008`
**Escopo:** elementos R4 estáticos entre `Z=165` e `Z=174`, antes do conector Majestic

## Implementação

A tarefa introduz `levels/regions/r4/ForestMajesticEdgeBalance.gd`. O módulo ajusta somente fetos e copas focais que já pertencem à R4: três instâncias existentes foram reposicionadas, escaladas e rodadas de forma determinística. A operação reduz a leitura de massa abrupta no limite anterior a Majestic sem modificar nenhum ativo, módulo, lógica, física ou iluminação de Dev5.

As transformações permanecem no intervalo R4 de `Z=165–174`, mantêm distância mínima de seis metros ao trilho e não introduzem qualquer nó novo de geometria, material, luz, colisão, partículas, vento, animação, shader ou pós-processamento.

| Critério | Resultado |
|---|---|
| Instâncias ajustadas | 3 fetos ou copas focais R4 existentes |
| Faixa regional | `Z=165–174`, antes da integração Dev5 |
| Corredor | 0 propostas rejeitadas; distância mínima de 6 m preservada |
| Integração R5 | Nenhum elemento Dev5 marcado ou modificado |
| Luz e física | Zero `Light3D` e zero `StaticBody3D` criados |

## Prova própria

A prova `qa/regions/verify_r4_majestic_edge_balance.gd` confirmou:

> `[ORIGEM_R4_EDGE] ajustados=3 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_EDGE_OK] borda R4→R5, corredor e módulos Dev5 preservados.`

A entrega segue para a porta canónica R4 e para as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` antes de publicação.
