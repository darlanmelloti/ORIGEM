# ORIGEM — STATUS R6: Pipeline de Regressão de Rotas 011

**Tarefa:** `DEV6-R6-ROUTE-REGRESSION-PIPELINE-011`  
**Estado:** VALIDADO LOCALMENTE  
**Âmbito:** QA R6 exclusivamente; sem alteração de produção.

## Implementação

Foi adicionado `tools/qa/run_r6_route_regression_pipeline.sh`, um orquestrador reprodutível que recebe um diretório de evidências e executa, com falha imediata, as três etapas QA já aprovadas: captura da matriz de rotas, extração de telemetria e verificação contra a baseline versionada. A pipeline não altera `ForestLakeRegion.gd`, `TempleLevel.gd`, âncoras cartográficas, água, luz, física, spawn, alvo, velocidade, câmara ou corredor físico.

| Etapa | Ferramenta encadeada | Resultado |
|---|---|---|
| Captura | `capture_r6_route_matrix.sh` | PASS nas três rotas |
| Extração | `extract_r6_route_telemetry.sh` | PASS; três vetores gerados |
| Baseline | `verify_r6_route_telemetry_baseline.sh` | PASS; desvio máximo `0.000 m` com tolerância `0.050 m` |

## Evidência preservada

A execução completa foi preservada em `reports/r6/route_regression_pipeline_011/`. O diretório inclui as capturas `1600×900`, logs runtime, composição, telemetria TSV/Markdown, log consolidado da pipeline e somas SHA-256 dos artefactos principais.

> Marcador de aprovação: `[ORIGEM_R6_ROUTE_REGRESSION_PIPELINE_OK]` com `routes=3` e `tolerance=0.050`.

## Garantias verificadas

| Garantia | Resultado |
|---|---|
| Produção R6 | Sem ficheiro de produção alterado |
| Rotas | `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` capturadas e verificadas |
| Água, luz e física | Sem alteração; a pipeline apenas consome telemetria e capturas runtime |
| Evidência visual | Uma captura pós-carregamento por rota, `1600×900` |
| Reprodutibilidade | Diretório de evidência parametrizável, execução linear e falha imediata por etapa |

## Sucessão

A tarefa seguinte deve analisar o relatório consolidado e garantir que a execução de regressão continua a ser acionável sem modificar a produção R6. Apenas uma tarefa Dev6 permanece ativa no contrato canónico após a atualização documental.
