# Dev6 — Contrato de Trabalho Contínuo das Ruínas Submersas

> **Regra operacional:** uma porta R6 aprovada nunca encerra o Dev6. Cada entrega validada deve publicar e substituir a tarefa atual por uma nova tarefa em estado `ACTIVE`.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV6-R6-MIDGROUND-ARCHAEOLOGY-COMPOSITION-014
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

## Entrega aprovada — DEV6-R6-EASTERN-MARGIN-PUBLISH-025

A cadeia oriental R6 foi integrada em *fast-forward* no commit remoto `5e6445b` após reconciliação segura com a integração atual. As portas R4, R5 e R6, o orçamento global de luz, o handoff e as três rotas R6 foram aprovados antes da publicação; a CI comum integrada também concluiu com sucesso. Não houve alteração adicional ao mundo nesta entrega documental.

## Entregas QA integradas — DEV6-R6-RUNTIME-CAPTURE-PROTOCOL-007 a DEV6-R6-ROUTE-TARGET-TELEMETRY-009

A sequência pós-publicação R6 adicionou apenas instrumentação QA e documentação de captura: protocolo runtime, matriz de capturas e extração de vetores de rota. Estes incrementos não alteraram `ForestLakeRegion.gd`, âncoras, água, luz, física, spawn, alvo, velocidade, câmara ou corredor físico.

## Entrega aprovada — DEV6-R6-ROUTE-TELEMETRY-BASELINE-010

A baseline versionada dos vetores `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` foi integrada com tolerâncias explícitas de desvio. A extração, o ficheiro de baseline e a verificação são exclusivamente QA e não alteraram produção, âncoras, água, luz, física, spawn, alvo, velocidade, câmara ou corredor físico.

## Entrega aprovada — DEV6-R6-ROUTE-REGRESSION-PIPELINE-011

A pipeline `run_r6_route_regression_pipeline.sh` executou a matriz de captura, a extração e a baseline das três rotas numa única sequência reprodutível. A execução preservada em `reports/r6/route_regression_pipeline_011/` aprovou as três etapas com desvio máximo `0.000 m` sob tolerância `0.050 m`, sem alterar produção, rotas, água, luz, física ou âncoras.

## Entrega aprovada — DEV6-R6-ROUTE-REGRESSION-REPORT-012

A revisão do relatório confirmou as três capturas runtime, logs, telemetria, marcador final da pipeline e somas SHA-256 consistentes. A evidência foi preservada em `reports/r6/ROUTE_REGRESSION_REPORT_012.md`; não houve alteração de produção nesta entrega.

## Entrega aprovada — DEV6-R6-VISUAL-DEBT-ASSESSMENT-013

A avaliação visual confirmou que a leitura de protótipo se concentra no plano médio da chegada R6: terreno aberto, lajes isoladas e vestígios arqueológicos pouco agrupados. A evidência foi preservada em `reports/r6/VISUAL_DEBT_ASSESSMENT_013.md`; não houve alteração de produção.

## Tarefa ativa — DEV6-R6-MIDGROUND-ARCHAEOLOGY-COMPOSITION-014

Ajustar de forma estática escala e orientação de três a cinco vestígios arqueológicos R6 já existentes no plano médio da chegada. A entrega deve aumentar a massa composicional sem deslocar as posições-base, água, handoff, rotas, luzes ou física.

| Critério | Obrigatório |
|---|---|
| Alvos | Apenas vestígios R6 existentes; nenhum nó, mesh, material, colisor ou luz nova |
| Espacial | Posições-base preservadas; somente escala/rotação local estática |
| Rotas | `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` imutáveis |
| Água e luz | Exatamente quatro luzes; sem shader, painel ou emissão adicional |
| Física | Sem `StaticBody3D`, `CollisionShape3D` ou alteração de lajes |
| Validação | Prova específica, parser, orçamento R6, handoff e três rotas aprovados antes de publicar |

## Sucessão obrigatória

A esteira mantém uma única issue `[Dev6 Continuous]` e encerra automaticamente qualquer item Dev6 anterior quando o `task_id` avançar. A entrega deve avançar para uma tarefa R6 rastreável somente depois da QA cumulativa e da evidência visual aplicável.
