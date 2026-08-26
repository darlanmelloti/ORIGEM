# ORIGEM — Revisão de Evidências da Composição de Plano Médio R6 016

**Tarefa:** `DEV6-R6-MIDGROUND-COMPOSITION-EVIDENCE-REVIEW-016`  
**Escopo:** revisão e indexação de evidências já integradas; sem nova captura, execução runtime, gate ou alteração de produção.  
**Referência de produção:** `5581765` — composição arqueológica R6 integrada pela PR [#390](https://github.com/darlanmelloti/ORIGEM/pull/390) no commit canónico `8b5397f`.

## Situação integrada

A composição de plano médio R6 está integrada. Ela ajusta exclusivamente a escala e a rotação locais de `FragmentoDeColunaMargemR6`, `PedraLeituraMargemR6_00` e `PedraLeituraMargemR6_01`. A tarefa posterior 015 confirmou a regularização do checkpoint; esta revisão 016 indexa as evidências para a passagem de arte/QA, sem reabrir nem repetir a validação já concluída.

| Área | Referência integrada | Evidência indexada | Resultado preservado |
|---|---|---|---|
| Composição visual R6 | `levels/ForestLakeRegion.gd` e `levels/regions/r6/R6MidgroundArchaeologyComposition.gd` | `qa/regions/verify_r6_midground_archaeology_composition.gd` | Três vestígios existentes; posições-base preservadas; zero luzes, colisores e nós adicionais |
| Prova específica | `verify_r6_midground_archaeology_composition.gd` | Marcador `[ORIGEM_R6_MIDGROUND_ARCHAEOLOGY_OK]` registado no checkpoint 015 | PASS |
| Porta regional | `tools/qa/run_regional_gate.sh` | Marcador `[GATE:R6] PASS` registado no checkpoint 015 | Parser, quatro luzes, handoff e rotas aprovados |
| Regressão de rotas | `reports/r6/route_regression_pipeline_011/` | `pipeline.log`, `route_telemetry.tsv`, `route_telemetry.md`, `SHA256SUMS.txt` | Pipeline aprovada; tolerância `0.050 m` |
| Handoff arte/QA | `reports/r6/MIDGROUND_COMPOSITION_CHECKPOINT_QA_015.md` | Checkpoint 015 e relatório de rotas 012 | Referências prontas para consulta sem recaptura |

## Matriz de rotas preservada

| Rota | Distância horizontal | Desvio máximo | Estado |
|---|---:|---:|---|
| `forest_to_ruins` | `31.288 m` | `0.000 m` | PASS |
| `majestic_to_lake` | `85.107 m` | `0.000 m` | PASS |
| `ruins_arrival` | `50.257 m` | `0.000 m` | PASS |

A telemetria e as capturas pós-carregamento em `1600×900` permanecem preservadas no bundle `route_regression_pipeline_011`. O relatório `ROUTE_REGRESSION_REPORT_012.md` confirma a presença das três capturas, logs runtime, logs de composição e o manifesto SHA-256 correspondente.

## Invariantes confirmadas por referência

Nenhum elemento de produção foi criado ou alterado nesta revisão. A composição integrada conserva água, quatro luzes R6, lajes, física, rotas, âncoras cartográficas, handoff R6→R7 e a fronteira que impede construção antecipada de R7.

> Esta revisão é uma indexação de evidências. Ela não substitui a porta R6, não cria hipótese visual nova e não autoriza repetição de runtime, captura ou CI sem uma mudança comprovada de head, base, checks ou mergeabilidade.

## Encaminhamento

A revisão 016 está completa quando este índice for integrado por PR regular. A sucessora canónica deverá permanecer exclusivamente QA/documental até surgir uma causa técnica ou visual aprovada que justifique qualquer intervenção de produção R6.
