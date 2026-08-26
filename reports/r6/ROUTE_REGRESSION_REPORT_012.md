# ORIGEM — Relatório de Regressão de Rotas R6 012

**Tarefa:** `DEV6-R6-ROUTE-REGRESSION-REPORT-012`  
**Estado:** VALIDADO LOCALMENTE  
**Âmbito:** auditoria de evidências QA; sem alteração de produção.

## Integridade verificada

A revisão confirmou que as três rotas R6 dispõem de captura pós-carregamento, log runtime e log de composição. As somas SHA-256 de `route_telemetry.tsv`, `route_telemetry.md` e `pipeline.log` correspondem ao manifesto preservado.

| Rota | Captura `1600×900` | Telemetria | Composição runtime |
|---|---:|---:|---:|
| `forest_to_ruins` | Presente | Presente | Marcador aprovado |
| `majestic_to_lake` | Presente | Presente | Marcador aprovado |
| `ruins_arrival` | Presente | Presente | Marcador aprovado |

O log da pipeline contém `[ORIGEM_R6_ROUTE_REGRESSION_PIPELINE_OK]`; a baseline das três rotas foi aprovada com tolerância `0.050 m` e desvio observado máximo `0.000 m`.

## Conclusão

Os artefactos são completos, verificáveis e coerentes com a baseline runtime. Não foi alterado `ForestLakeRegion.gd`, água, luz, física, âncoras, spawn, alvo, velocidade, câmara ou corredor físico.

## Sucessão

A tarefa seguinte deve utilizar este relatório para manter uma vigilância de regressão versionada ou tratar a dívida visual R6 como entrega artística modular separada, sem misturar QA e produção.
