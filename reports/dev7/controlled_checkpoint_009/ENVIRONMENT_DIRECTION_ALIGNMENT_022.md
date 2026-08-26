# Dev7 — Alinhamento à Direção Ambiental 022

| Campo | Decisão de QA |
|---|---|
| **Direção aplicável** | `ENVIRONMENT_DIRECTION_001` integrada na base canónica. |
| **Auditoria proprietária** | `DEV1-ENVIRONMENT-PLAYER-VIEW-BASELINE-002`. |
| **Responsável por capturas ambientais** | Dev1. |
| **Papel Dev7** | Reconciliação documental, preservação de evidência R6 e validação de invariantes caso a auditoria Dev1 publique um marco verificável. |
| **Captura duplicada por Dev7** | Não autorizada nesta tarefa. |
| **Produção R6** | Sem alteração. |

## Delimitação operacional

A direção ambiental define uma auditoria observacional de seis rotas reais do jogador em 1600×900. O baseline operativo atribui essa matriz a Dev1; por isso, Dev7 não reproduz as capturas `road_to_arch`, `arch_to_forest`, `forest_to_majestic`, `majestic_to_lake`, `forest_to_ruins` ou `ruins_arrival` em paralelo. Esta separação evita concorrência de evidências e mantém a regra de uma frente QA ativa por responsável.

A fronteira Dev7 permanece limitada à preservação dos contratos R6. Para a rota `forest_to_ruins`, as entradas que Dev7 poderá verificar depois da publicação Dev1 são orientação de rota, distinção trilho–água–ruínas, handoff R6→R7 e orçamento de quatro luzes. Essa verificação não autoriza ajuste de materiais, luzes, água, câmara, geometria, colisores ou rota.

> A existência de uma baseline ambiental não transforma observação em intervenção. Qualquer resultado `HIPOTESE_CAUSAL_REQUERIDA` continuará a depender de uma causa ligada a nó, material ou posição e da aprovação do dono regional Dev6/R6 antes de teste ou produção.

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
