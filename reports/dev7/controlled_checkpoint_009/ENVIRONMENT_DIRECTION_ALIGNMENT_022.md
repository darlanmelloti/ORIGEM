# Dev7 — Alinhamento à Direção Ambiental 022

| Campo | Decisão de QA |
|---|---|
| **Referência canónica confirmada** | `876092a90f30` (prefixo publicado `876092a`). |
| **Estado de máquina** | **READY_FOR_HYPOTHESIS — pausa controlada** |
| **Bilhete aplicável** | `DEV7-ENVIRONMENT-DIRECTION-ALIGNMENT-022` |
| **Classificação de marco** | `ORIGEM — Classificação dos Relatos Anexados 019` |
| **Direção aplicável** | `ENVIRONMENT_DIRECTION_001` integrada na base canónica. |
| **Auditoria proprietária** | `DEV1-ENVIRONMENT-PLAYER-VIEW-BASELINE-002`. |
| **Responsável por capturas ambientais** | Dev1. |
| **Papel Dev7** | Reconciliação documental, preservação de evidência R6 e validação de invariantes quando a auditoria Dev1 publicar um marco verificável. |
| **Captura duplicada por Dev7** | Não autorizada neste bilhete. |
| **Produção R6** | Sem alteração. |

> A classificação `READY_FOR_HYPOTHESIS` formaliza que a ausência de hipótese Dev6/R6 é uma condição legítima de entrada. Não constitui paragem técnica, não cria obrigação de uma tarefa sucessora cosmética e não autoriza Dev7 a iniciar variante, captura comparativa ou produção.

## Delimitação operacional

A direção ambiental define uma auditoria observacional de seis rotas reais do jogador em 1600×900. O baseline operativo atribui essa matriz a Dev1; por isso, Dev7 não reproduz as capturas `road_to_arch`, `arch_to_forest`, `forest_to_majestic`, `majestic_to_lake`, `forest_to_ruins` ou `ruins_arrival` em paralelo. Esta separação evita concorrência de evidências e preserva a propriedade da auditoria.

A fronteira Dev7 permanece limitada à preservação dos contratos R6. Para a rota `forest_to_ruins`, as entradas que Dev7 poderá verificar depois da publicação Dev1 são orientação de rota, distinção trilho–água–ruínas, handoff R6→R7 e orçamento de quatro luzes. Essa verificação não autoriza ajuste de materiais, luzes, água, câmara, geometria, colisores ou rota.

> A existência de uma baseline ambiental não transforma observação em intervenção. Qualquer resultado `HIPOTESE_CAUSAL_REQUERIDA` continuará a depender de uma causa ligada a nó, material ou posição e da aprovação do dono regional Dev6/R6 antes de teste ou produção.

## Estado de máquina e condições de saída

| Elemento | Estado atual | Consequência para Dev7 |
|---|---|---|
| **Bilhete** | `DEV7-ENVIRONMENT-DIRECTION-ALIGNMENT-022` | Permanece o único item Dev7 governado no quadro. |
| **Estado de máquina** | `READY_FOR_HYPOTHESIS` | Não existe execução material autónoma. QA mantém-se somente de leitura. |
| **Baseline de vistas Dev1** | Não publicada como bundle observacional completo. | Não executar intake, não criar as seis capturas e não completar a auditoria em nome de Dev1. |
| **Hipótese Dev6/R6** | Não publicada com os três elementos obrigatórios. | Não iniciar teste R6, comparativo, material ou produção. |
| **Gatilho de reconciliação documental** | Relatório Dev1, seis PNGs 1600×900 e telemetria válidos. | Executar o verificador Dev7 somente de leitura e reconciliar invariantes, se `READY_FOR_DEV7_RECONCILIATION`. |
| **Gatilho de teste R6 futuro** | Hipótese visual falsificável, alvos nomeados por identidade/`NodePath` e enquadramento de prova, todos explicitamente aprovados por Dev6/R6. | Só então avaliar o escopo permitido, mantendo parser, `git diff --check`, gate R6, rota e auditoria de luz aplicáveis. |

## Matriz de responsabilidades

| Entrada | Dono | Uso por Dev7 |
|---|---|---|
| Capturas 1600×900 e telemetria das seis vistas | Dev1 | Consumir somente após publicação verificável. |
| Direção ambiental e restrições de composição | Direção / Dev1 | Aplicar como critério documental, sem escrever produção. |
| Gate R6, rota `forest_to_ruins` e orçamento de luz | Dev7, em fronteira regional | Revalidar somente num marco de integração ou pedido regional explícito. |
| Hipótese visual e conjunto de alvos R6 | Dev6/R6 | Obrigatórios antes de qualquer teste futuro. |

## Invariantes preservadas

| Invariante | Estado |
|---|---|
| Sem captura comparativa Dev7 duplicada | Preservado. |
| Sem mutação de produção R6 | Preservado. |
| Sem bypass, force-push ou CI paralela | Preservado. |
| Câmara e rota de produção | Não modificadas. |
| Handoff R6→R7 | Protegido. |
