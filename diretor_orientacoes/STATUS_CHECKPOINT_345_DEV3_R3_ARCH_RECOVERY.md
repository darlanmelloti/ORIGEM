# STATUS CHECKPOINT 345 — R3 Recuperação do Arco e Ciclo Dev3

**Branch canónica:** `dev3/r3-arch-ruins`
**Entrega recuperada:** `DEV3-R3-ARCH-AWAKENING-RECOVERY-001`
**Tarefa ativa:** `DEV3-R3-FOREST-HANDOFF-002`

## Diagnóstico de recuperação

O relatório enviado pelo utilizador declarava uma entrega Dev3 no commit `2f2aee0`, mas esse commit, a branch `dev3/r3-arch-ruins-sprint1` e os harnesses citados não estavam presentes no repositório remoto nem nos worktrees locais. A branch canónica R3 estava atrasada em relação à integração e não possuía commits exclusivos. Ela foi atualizada por avanço rápido, sem substituir trabalho de terceiros.

A recuperação preserva o Arco físico existente em Z aproximado 92 e acrescenta a camada modular `R3ArchAwakening`. As inscrições **“A PEDRA RECORDA”** e **“NÃO SIGAS A LUZ”** são apresentadas no próprio marco; o primeiro cruzamento ativa apenas uma vez o efeito visual moderado e emite `r3_arch_awakened` por `EventBus.world_event_triggered`. O estado participa do save através de `Persist`.

| Garantia | Evidência |
|---|---|
| Projeção | O mundo real mantém a raiz `ArcoDasRuinas_EstradaDoRio` em Z≈92 |
| Travessia | Os dois pilares laterais continuam os únicos colisores do marco; o vão central permanece aberto |
| Luz | A luz de preenchimento adicional foi removida; o Arco fica em exatamente duas OmniLight3D sem sombra |
| QA | `[ORIGEM_R3_ARCH_OK]` verifica Z, colisores, orçamento de luzes, componente e despertar idempotente |
| Regressão | `tools/qa/run_regional_gate.sh R3 HEAD` passou com parser, contratos, `road_to_arch` e `arch_to_forest` |

## Continuidade Dev3

A esteira regional agora reconhece `DEV3_R3_CONTINUOUS_WORK.md`, exige um estado **ACTIVE** para R3 e mantém uma única issue `[Dev3 Continuous]` aberta. A próxima tarefa, `DEV3-R3-FOREST-HANDOFF-002`, deve construir a transição aberta e arqueológica do Arco para R4, sem antecipar uma parede de árvores, adicionar luzes ou deslocar a cartografia.
