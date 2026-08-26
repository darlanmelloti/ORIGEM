# ORIGEM — Arquivo da Evidência Baseline do Afluente R4 054

**Tarefa:** `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-BASELINE-ARCHIVE-054`
**Estado:** Arquivo documental aprovado; nenhuma candidata criada

## Índice de publicação

A evidência baseline 053 foi confirmada na ponta remota `dev4/r4-dense-forest`. Os artefactos abaixo existem no remoto e os hashes SHA-256 coincidem com a cópia local.

| Artefacto | SHA-256 confirmado |
|---|---|
| Relatório baseline 053 | `8b2cabe41845de1dba2615cdf3e3783ee01e33494eee15f317a80724fe21c8eb` |
| Imagem baseline `arch_to_forest_postload.png` | `c3e7cbd7f438d6f166fca9d04709f1d9a15205c3e16568091d8f0038856613d3` |
| Revisão visual baseline | `232b08082b8b1cbf0c9a29f59ef0faca8b796d544c2bcacfa8e58ad873130406` |
| Sumário de captura | `4aed05ba43e1198fc7503ea2009139bbbf89b721c683dcc29e4b293ab9e9db3b` |
| Log de parser | `c9da6ddb6a257c74e17f820d4abf5bf5af04c8ab993e7888af9849c9357a8311` |
| Log runtime | `373b36b38061514048c279434bea4253bcbb89c307fca49cfb2eda0017b71576` |

## Estado regional arquivado

A evidência continua a descrever somente o baseline canónico de `arch_to_forest`. A superfície ampla clara/opaca é preservada como referência, sem candidata modular, sem override local de material, sem alteração de água R6 e sem reabertura de transparência, cota, largura ou `cull_back`.

| Verificação | Resultado |
|---|---|
| Parser Godot headless | Aprovado |
| Auditoria de orçamento | `[QA-BUDGET-01] result=PASS` |
| Porta canónica R4 | `[GATE:R4] PASS` |
| `arch_to_forest` | Aprovada |
| `forest_to_majestic` | Aprovada |
| `forest_to_ruins` | Aprovada |
| Candidata ou produção adicional | Ausente |

A clareira Orion, o corredor `≥8 m`, a rota, a câmara, as âncoras, a física, as quatro luzes R6, a água e os limites R5/R6 permanecem preservados. Qualquer aviso de material nulo no final de harnesses headless é ruído conhecido do backend dummy após sucesso dos gates, não regressão.

## Continuidade

A tarefa activa seguinte é `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-BASELINE-PUBLISH-MONITOR-055`. Ela é exclusivamente documental: deve observar uma nova ponta canónica de integração ou publicação e confirmar a preservação da cadeia 050–054, sem criar candidata, executar comparação de variante ou alterar produção.
