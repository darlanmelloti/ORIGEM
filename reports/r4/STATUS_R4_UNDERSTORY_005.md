# ORIGEM — STATUS R4_UNDERSTORY_005: Transição Lateral do Sub-Bosque

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-UNDERSTORY-EDGE-005`
**Escopo:** elementos estáticos já existentes entre o Arco das Ruínas e a clareira Orion

## Implementação

A tarefa adiciona `levels/regions/r4/ForestUnderstoryEdge.gd`. O módulo reorganiza os doze elementos existentes de `SubBosqueDoLimiarArcoFloresta`: seis fetos e seis rochas. O ajuste é determinístico e estático, aplicando apenas afastamento lateral, deslocamento longitudinal pequeno, escala moderada e rotação Y aos objetos já instanciados.

Nenhum nó novo é criado no sub-bosque. A faixa da clareira Orion entre `Z=126` e `Z=151` permanece excluída, e cada elemento reposicionado mantém mais de seis metros de distância da curva do trilho.

| Critério | Resultado |
|---|---|
| Elementos reorganizados | 12 instâncias existentes, sem adição de malhas |
| Clareira Orion | Nenhum elemento deslocado para `Z=126–151` |
| Corredor | Distância mínima medida: 6,16 m |
| Luz e física | Zero luzes e zero colisores criados |
| Efeitos dinâmicos | Sem partículas, vento, animação, shaders ou pós-processamento |

## Prova própria

A prova `qa/regions/verify_r4_understory_edge.gd` confirmou:

> `[ORIGEM_R4_UNDERSTORY] ajustados=12 clareira_protegida=0 minima=6.16 luzes=0`
>
> `[ORIGEM_R4_UNDERSTORY_OK] sub-bosque lateral, clareira Orion e corredor R4 preservados.`

A próxima etapa obrigatória é a porta canónica R4, incluindo o parser e as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`.
