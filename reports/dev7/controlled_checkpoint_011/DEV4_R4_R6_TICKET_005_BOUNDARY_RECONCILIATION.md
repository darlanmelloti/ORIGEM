# ORIGEM — Dev7: Reconciliação de Fronteira do Bilhete Dev4/R6 005

## Marco observado

| Campo | Registo |
|---|---|
| **Fonte externa** | `origin/dev4/r4-dense-forest` no commit `8b97d35b4af765c5f8e807f80aa7e453bbfa150d` |
| **Integração de referência do bilhete** | `876092a90f30` |
| **Bilhete externo** | `DIRECTOR_RESUME_TICKET_005_DEV4_INLET_ALPHA_QA` |
| **Estado externo declarado** | `QA_CANDIDATE_AUTHORIZED` |
| **Resultado externo declarado** | `QA_TECHNICAL_ISOLATION_PASS` |
| **Bilhete Dev7 aplicável** | `DEV7-ENVIRONMENT-DIRECTION-ALIGNMENT-022` |
| **Estado de máquina Dev7** | `READY_FOR_HYPOTHESIS — pausa controlada` |
| **Produção alterada por Dev7** | Não; `production_mutations=0` |

O marco Dev4 contém uma candidata de QA transitória e isolada para a lâmina do **afluente R4**, com `ALPHA = 0.82` aplicado somente a uma cópia de material em memória. O seu relatório declara que `LagoDasRuinasSubmersas` R6 preserva alfa canónico `1.0`, as quatro luzes R6 e os recursos de produção sem escrita. Dev7 consumiu este marco somente como evidência documental de fronteira, não como autorização para executar ou repetir a candidata.

> O estado `QA_CANDIDATE_AUTHORIZED` pertence ao alvo R4 e aos proprietários explicitamente indicados no bilhete. Ele não satisfaz os requisitos do bilhete Dev7 022 para nova atividade R6: hipótese visual falsificável para R6, conjunto de alvos R6 nomeado por identidade/`NodePath` e enquadramento de prova expressamente aprovado por Dev6/R6.

## Matriz de não sobreposição

| Elemento | Bilhete Dev4/R6 005 | Consequência Dev7 |
|---|---|---|
| **Alvo da candidata** | `AfluenteCartograficoRioParaBacia/LaminaDoAfluenteCartografico` (R4) | Fora do escopo de mutação Dev7. Não executar, reencenar nem capturar. |
| **Consumidor R6 protegido** | `RuinasSubmersasDoLago/LagoDasRuinasSubmersas` | Continua imutável sob o contrato Dev7. |
| **Mecanismo permitido no bilhete externo** | Cópia de `ShaderMaterial` em memória descartada com a instância da prova. | Não cria autorização para material, override ou variante Dev7. |
| **Luzes R6** | Quatro luzes canónicas preservadas. | Invariante Dev7 confirmada por referência; não repetir auditoria sem delta Dev7/Dev6 ou integração. |
| **Validação externa** | Verificador regional R4, gate R4 e `git diff --check`. | Evidência técnica Dev4 não substitui o gate R6, intake Dev1 ou autorização R6 exigidos por Dev7. |
| **Promoção visual** | Requer captura 16:9 com enquadramento aprovado e decisão conjunta Dev4, Dev6 e Dev1/Diretor. | Não autorizada; nenhum comparativo Dev7 será iniciado. |

## Decisão Dev7

| Questão | Decisão |
|---|---|
| O bilhete 005 autoriza Dev7 a alterar R6? | **Não.** O seu objeto é a prova transitória R4; R6 é explicitamente consumidor protegido. |
| O resultado técnico externo muda o estado Dev7? | **Não.** Dev7 permanece `READY_FOR_HYPOTHESIS` no bilhete 022. |
| Deve Dev7 repetir a prova ou a captura visual? | **Não.** Repetição criaria duplicação de responsabilidade e excederia o escopo. |
| É necessária nova CI, gate R6 ou integração Dev7? | **Não neste marco.** Não há delta em Dev1, Dev6 ou integração, nem modificação Dev7 de produção. |
| Qual é o próximo passo Dev7? | Consumir uma baseline Dev1 publicada ou autorização Dev6/R6 explicitamente completa, ambas em regime somente de leitura até decisão regional. |

## Invariantes preservadas

| Invariante Dev7 | Estado |
|---|---|
| Sem captura ambiental Dev7 duplicada | Preservado. |
| Sem variante, material ou override em R6 | Preservado. |
| Sem alteração de água, luz, física, colisores, rota, Player, câmara ou ancoragens | Preservado. |
| Quatro luzes R6 e handoff R6→R7 | Protegidos. |
| Sem bypass, force-push, CI manual ou monitor persistente | Preservado. |
