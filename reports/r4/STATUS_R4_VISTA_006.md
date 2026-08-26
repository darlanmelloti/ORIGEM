# ORIGEM — STATUS R4_VISTA_006: Enquadramento Lateral de Orion

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-ORION-VISTA-FRAMING-006`
**Escopo:** copas laterais estáticas entre a entrada do Arco e a aproximação à clareira Orion

## Implementação

A tarefa introduz `levels/regions/r4/ForestOrionVistaFraming.gd`. O módulo altera somente transformações de copas já existentes em `TransicaoOrganicaArcoFloresta` e `CopasFocaisDaFlorestaDensa`: pequeno deslocamento para o exterior, escala moderada e rotação Y. A cadência resultante abre a revelação gradual de Orion sem tornar a floresta uma parede visual.

A faixa protegida `Z=126–151` não recebe modulação. As copas ajustadas mantêm-se além de seis metros do trilho físico, e o módulo não cria nós de geometria, materiais, luzes, colisores, partículas, vento, animação, shaders, pós-processamento, interface, texto ou alterações de câmara.

| Critério | Resultado |
|---|---|
| Copas ajustadas | 6 instâncias laterais existentes |
| Clareira Orion | 2 copas focais na faixa protegida mantidas sem alteração |
| Corredor | 0 propostas rejeitadas; nenhum elemento modulado a menos de 6 m |
| Luz e física | Zero `Light3D` e zero `StaticBody3D` criados |
| Desempenho | Apenas transformações estáticas de instâncias existentes |

## Prova própria

A prova `qa/regions/verify_r4_orion_vista_framing.gd` confirmou:

> `[ORIGEM_R4_VISTA] ajustadas=6 clareira_protegida=2 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_VISTA_OK] enquadramento lateral de Orion, clareira e corredor R4 preservados.`

A entrega segue para a porta canónica R4 e para as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` antes de publicação.
