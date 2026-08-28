# ORIGEM — Dev7: Alinhamento de Estado à Classificação dos Relatos Anexados 019

## Decisão de marco

| Campo | Registo |
|---|---|
| **Frente** | Dev7 — Direção Visual, Legibilidade Ambiental e Física Jogável |
| **Referência canónica** | `876092a90f30` |
| **Branch Dev7** | `dev7/visual-playable-physics` |
| **Base de integração** | `integration/r1-r6-sprint1` |
| **Bilhete aplicável** | `DEV7-ENVIRONMENT-DIRECTION-ALIGNMENT-022` |
| **Estado de máquina anterior** | `ACTIVE — reconciliação QA documental, sem mutação de produção` |
| **Estado de máquina corrigido** | **`READY_FOR_HYPOTHESIS — pausa controlada`** |
| **Execução material em curso** | **Não** |
| **Produção R6 modificada por este marco** | **Não; `production_mutations=0`** |

A classificação 019 determina que Dev7 não está tecnicamente parado. A falta de hipótese explicitamente publicada por Dev6/R6 é uma entrada legítima ainda ausente. Portanto, o estado `ACTIVE` não deve ser usado apenas para sugerir atividade material inexistente; o bilhete 022 permanece no quadro sob o estado de máquina `READY_FOR_HYPOTHESIS`, pronto para consumir o próximo marco autorizado.

> **Pausa controlada** significa continuidade de responsabilidade com execução restrita: Dev7 conserva a evidência, o contrato e o intake somente de leitura, sem iniciar uma sucessora cosmética, sem monitor persistente e sem fabricar uma hipótese regional.

## Classificação operacional

| Pergunta de controlo | Resposta | Evidência / consequência |
|---|---|---|
| Existe baseline observacional Dev1 publicada como bundle completo? | **Não** | O protocolo existe, mas não há relatório acompanhado pelas seis imagens 1600×900 e telemetria a consumir. Dev7 não duplica a auditoria. |
| Existe autorização Dev6/R6 para novo teste R6? | **Não** | Não foi publicada a combinação de hipótese visual falsificável, alvos nomeados por identidade/`NodePath` e enquadramento de prova. |
| A captura R6 003 pode ser reaberta? | **Não** | A variante histórica continua rejeitada; o marco 019 não altera a sua conclusão nem autoriza captura duplicada. |
| Dev7 pode alterar produção, material ou luz R6? | **Não** | Permanecem protegidos cenas, nós, meshes, materiais, água, luzes, partículas, física, colisores, áreas, rota, Player, câmara, ancoragens e o handoff R6→R7. |
| É necessária nova CI, captura ou gate agora? | **Não** | Sem delta, autorização ou marco de integração, não há fundamento para repetição; a cadência permanece pontual. |

## Próximo marco permitido

| Entrada publicada | Verificação Dev7 permitida | Limite inviolável |
|---|---|---|
| Bundle Dev1 completo: relatório, seis PNGs 1600×900, telemetria de rota/câmara/luzes e decisões admitidas | Executar `check_environment_baseline_intake.py` somente de leitura. Se válido, reconciliar documentalmente os invariantes R6. | O resultado `READY_FOR_DEV7_RECONCILIATION` não autoriza produção R6. |
| Autorização Dev6/R6 com hipótese falsificável, alvos nomeados/`NodePath` e enquadramento | Verificar completude da autorização e delimitar a prova permitida antes de qualquer trabalho adicional. | Sem os três elementos, não criar teste, comparativo, variante ou produção. |
| Atualização canónica que toque ambiente ou R6 | Criar referência de segurança, analisar o delta e integrar de modo não destrutivo quando necessário; aplicar validação proporcional. | Sem bypass, auto-merge, force-push, cancelamento/reexecução agressiva de CI ou mutação não autorizada. |

## Invariantes atestadas neste marco

| Invariante | Estado |
|---|---|
| Proprietário das capturas ambientais | Dev1; preservado. |
| Escopo Dev7 até hipótese regional | QA somente de leitura; preservado. |
| Quatro luzes R6 e orçamento regional | Protegidos; sem alteração. |
| Rota `forest_to_ruins`, câmara e Player | Protegidos; sem alteração. |
| Água, física, colisores, ancoragens e handoff R6→R7 | Protegidos; sem alteração. |
| Política de integração e CI | Sem bypass e sem novo disparo manual; preservado. |

## Referências internas

| Documento | Papel |
|---|---|
| `qa/dev7/DEV7_TASK_CONTRACT.md` | Estado de máquina, bilhete 022 e semântica operacional Dev7. |
| `qa/dev7/ENVIRONMENT_BASELINE_INTAKE_CONTRACT_023.md` | Contrato de consumo da baseline Dev1 somente de leitura. |
| `reports/dev7/controlled_checkpoint_009/ENVIRONMENT_DIRECTION_ALIGNMENT_022.md` | Responsabilidades Dev1/Dev6/Dev7 e invariantes ambientais R6. |
| `reports/dev7/controlled_checkpoint_009/POST_CI_ATTESTATION_021.md` | Separação entre elegibilidade técnica e autorização artística R6. |
| `diretor_orientacoes/DEV6_R6_CONTINUOUS_WORK.md` | Autoridade regional sobre hipótese, alvos e enquadramento R6. |
