# ORIGEM — STATUS R4_CANOPY_004: Cadência Estática das Copas

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-CANOPY-CADENCE-004`
**Escopo:** massas laterais da Floresta Densa entre o Arco das Ruínas e o Acampamento Majestic

## Implementação

A tarefa adiciona `levels/regions/r4/ForestCanopyCadence.gd`, um módulo aditivo que altera apenas transformações de copas já instanciadas em `FlorestaDensaRegional` e `CopasFocaisDaFlorestaDensa`. A variação é determinística e estática: deslocamento adicional para o lado exterior do corredor, escala horizontal e vertical moderada e rotação Y limitada. Não adiciona malhas, colisores, luzes, partículas, vento, shaders, pós-processamento, lógica de câmara ou alterações de rota.

A faixa da clareira Orion em `Z=126–151` é explicitamente excluída. Toda posição proposta é rejeitada caso fique a menos de seis metros da curva do trilho físico.

| Critério | Resultado |
|---|---|
| Copas ajustadas | 26 copas existentes receberam variação estática |
| Clareira protegida | 20 copas na faixa Orion permaneceram sem modulação |
| Corredor | 0 propostas rejeitadas por invasão; nenhuma copa validada a menos de 6 m do trilho |
| Luz e física | 0 luzes e 0 colisores criados pelo módulo |
| Desempenho | Transformações de instâncias existentes, sem animação ou materiais novos |

## Prova própria

A prova `qa/regions/verify_r4_canopy_cadence.gd` instanciou R4 em isolamento e confirmou:

> `[ORIGEM_R4_CANOPY] ajustadas=26 clareira_protegida=20 corredor_rejeitado=0 luzes=0`
>
> `[ORIGEM_R4_CANOPY_OK] cadência estática lateral, clareira Orion e corredor R4 preservados.`

A entrega segue para a porta canónica R4 e as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` antes de publicação.
