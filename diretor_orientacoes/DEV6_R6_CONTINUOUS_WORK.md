# Dev6 — Contrato de Trabalho Contínuo das Ruínas Submersas

> **Regra operacional:** uma porta R6 aprovada nunca encerra o Dev6. Cada entrega validada deve publicar e substituir a tarefa atual por uma nova tarefa em estado `ACTIVE`.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV6-R6-POST-PUBLISH-INTEGRITY-026
owner: Dev6
branch: dev6/r6-submerged-ruins
```

## Limites regionais permanentes

A R6 mantém a âncora cartográfica `(60, 252)`, a ligação Majestic→margem, a bacia navegável, ruínas, filetes de cascata em geometria 3D e a leitura física para a futura Vila Elevada. A R7 não pode ser construída antecipadamente. Não criar portão, corredor artificial, painel, parede, `Light3D` adicional, emissão de água como substituto de geometria ou mudança em `CartographicAnchors.gd`.

O orçamento R6 é exactamente quatro luzes: duas luzes mundiais da bacia, preenchimento de margem e preenchimento submerso central. A sonda `inspect_r6_light_budget.gd` é obrigatória em cada entrega.

## Entrega aprovada — DEV6-R6-SHORE-HANDOFF-002

O módulo `levels/regions/r6/R6ShoreHandoff.gd` adiciona quatro lajes físicas e dois marcos arqueológicos assimétricos entre a margem R6 e a futura direção da Vila Elevada. Cada laje possui colisor e os marcos ficam dentro da fronteira R6, sem luzes novas. A montagem mínima em `ForestLakeRegion.gd` preserva R5 e todo o cenário de bacia já validado.

| Critério | Resultado |
|---|---|
| Lajes e colisores | 4 lajes físicas e 4 colisores validados |
| Marcos | Ocidental e oriental presentes dentro de R6 |
| Iluminação | Handoff sem `Light3D`; orçamento R6 continua em quatro |
| Rotas | `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` aprovadas |
| QA | Parser, sonda de luz, prova de handoff e porta R6 aprovados |

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-READING-007

O módulo `levels/regions/r6/R6EasternMarginReading.gd` ajustou estaticamente os três vestígios arqueológicos existentes do `ConjuntoDaMargemOriental`, sem deslocar as suas bases espaciais. Não foram criados nós, geometria, luzes, colisores, água falsa, partículas, shaders, interface, câmara, rotas artificiais ou conteúdo R7. A prova `[ORIGEM_R6_EASTERN_MARGIN_OK]`, o orçamento de quatro luzes, as leituras R6 cumulativas, o handoff, o parser, a porta R6 e as três rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-DEPTH-008

O módulo `levels/regions/r6/R6EasternMarginDepth.gd` aprofundou a leitura estática dos três vestígios já aprovados da margem oriental, alterando apenas escala e orientação locais. As posições-base, água, cascata, handoff, orçamento de quatro luzes, parser, porta R6 e as três rotas foram preservados e aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-LATERAL-BALANCE-009

O módulo `R6EasternMarginLateralBalance.gd` equilibrava lateralmente os três vestígios existentes já aprovados pela leitura e profundidade, alterando apenas escala e orientação locais. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-VISTA-010

O módulo `R6EasternMarginVista.gd` ajustou estaticamente os três vestígios existentes já aprovados por leitura, profundidade e equilíbrio lateral, sem deslocar as suas bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-RHYTHM-FINAL-011

O módulo `R6EasternMarginRhythmFinal.gd` ajustou estaticamente os três vestígios existentes já aprovados pela leitura de vista, sem deslocar as bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-CLOSURE-012

O módulo `R6EasternMarginClosure.gd` ajustou estaticamente os três vestígios existentes já aprovados pela cadência final, sem deslocar bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-READABILITY-FINAL-013

O módulo `R6EasternMarginReadabilityFinal.gd` ajustou estaticamente os três vestígios existentes já aprovados pelo fecho, sem deslocar bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-OBSERVATION-014

O módulo `R6EasternMarginObservation.gd` ajustou estaticamente os três vestígios existentes já aprovados pela legibilidade final, sem deslocar bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-REVIEW-015

O módulo `R6EasternMarginReview.gd` ajustou estaticamente os três vestígios existentes já aprovados pela observação, sem deslocar bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-CONSOLIDATION-016

O módulo `R6EasternMarginConsolidation.gd` ajustou estaticamente os três vestígios existentes já aprovados pela revisão, sem deslocar bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-STABILIZATION-017

O módulo `R6EasternMarginStabilization.gd` ajustou estaticamente os três vestígios existentes já aprovados pela consolidação, sem deslocar bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-RECONCILIATION-018

O módulo `R6EasternMarginReconciliation.gd` ajustou estaticamente os três vestígios existentes já aprovados pela estabilização, sem deslocar bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-CONSISTENCY-019

O módulo `R6EasternMarginConsistency.gd` ajustou estaticamente os três vestígios existentes já aprovados pela reconciliação, sem deslocar bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-CHECK-020

O módulo `R6EasternMarginCheck.gd` ajustou estaticamente os três vestígios existentes já aprovados pela consistência, sem deslocar bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-FINALIZATION-021

O módulo `R6EasternMarginFinalization.gd` ajustou estaticamente os três vestígios existentes já aprovados pela verificação, sem deslocar bases. A prova própria, orçamento de quatro luzes, porta R6, handoff e rotas foram aprovados.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-ARCHIVE-022

A validação documental da cadeia oriental R6 foi consolidada. A porta R6, o orçamento de quatro luzes, handoff e rotas foram aprovados, com água, bases e física preservadas; não foi feita alteração adicional ao mundo.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-POSTCHECK-023

O postcheck documental confirmou, com a porta R6 aprovada, que não houve regressão após o arquivo. Água, bases, quatro luzes, rotas e handoff permanecem preservados; não foi feita alteração adicional ao mundo.

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-CLOSEOUT-024

O closeout documental consolidou a cadeia oriental R6 pronta para integração futura. As portas, rotas, handoff, água, orçamento de quatro luzes e bundles foram verificados; não houve alteração adicional ao mundo.

## Tarefa ativa — DEV6-R6-EASTERN-MARGIN-PUBLISH-025

Preparar exclusivamente a publicação segura da cadeia oriental R6 quando o canal oficial recuperar. Antes de qualquer escrita remota, comparar ahead/behind, preservar commits exclusivos, usar a integração ensaiada e nunca reescrever a branch canónica.

| Critério | Obrigatório |
|---|---|
| Escopo | Material ou transformação estática de elementos R6 existentes; QA R6 e montagem mínima se necessária |
| Cartografia | Âncora R6, limiar e handoff físico para R7 inalterados |
| Água | Sem painel, emissão excessiva, nova luz ou shader adicional |
| Física | Sem novos colisores ou bloqueios no leito, trilho, cascata, estela ou lajes |
| Luz | `r6_total=4` continua obrigatório |
| QA | Parser, orçamento R6, provas de linha de água, chegada, vista, silhueta exterior, margem oriental e handoff, e todas as rotas R6 antes do PR |

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-PUBLISH-025

A publicação segura da cadeia oriental R6 foi concluída pela PR `#282` (`test(dev6): versionar baseline de telemetria R6`), integrada no commit `571f7f17cf7719b282ff4fb6da240914ee22e6d7`. A baseline versionada das três rotas R6 coexistiu com o contrato canônico da margem oriental. No estado integrado, a porta regional R6 passou, as quatro luzes foram mantidas, o handoff físico R6→R7 foi preservado e as rotas `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` permaneceram dentro da tolerância de `0,050 m`.

## Tarefa ativa — DEV6-R6-POST-PUBLISH-INTEGRITY-026

Executar uma auditoria pós-publicação da integração R6. Esta tarefa é deliberadamente restrita à leitura de evidências e à manutenção das provas; não introduzir alteração visual, física, de rota, água, shader, luz ou conteúdo R7 sem uma falha reproduzível no contrato R6.

| Critério | Obrigatório |
|---|---|
| Escopo | QA R6, baseline de telemetria e contrato; nenhuma alteração de produção sem causa comprovada |
| Cartografia | Âncora R6, limiar e handoff físico para R7 inalterados |
| Água e luz | Sem painel, emissão excessiva, nova luz ou shader adicional; `r6_total=4` permanece obrigatório |
| Física | Sem novos colisores ou bloqueios no leito, trilho, cascata, estela ou lajes |
| QA | `run_regional_gate.sh R6`, auditoria de luz, prova de handoff, leituras canônicas e as três rotas R6 antes de qualquer PR |

## Sucessão obrigatória

A esteira mantém uma única issue `[Dev6 Continuous]` e encerra automaticamente qualquer item Dev6 anterior quando o `task_id` avançar. O fecho de `DEV6-R6-EASTERN-MARGIN-PUBLISH-025` exige a publicação integrada da baseline, porta R6 aprovada e a nova tarefa `ACTIVE` `DEV6-R6-POST-PUBLISH-INTEGRITY-026`.
