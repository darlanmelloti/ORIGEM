# ORIGEM — Checkpoint QA R6 015

**Tarefa ativa:** `DEV6-R6-MIDGROUND-COMPOSITION-CHECKPOINT-QA-015`  
**Checkpoint de produção pendente:** `5581765` — `feat(dev6): compor vestígios arqueológicos R6`  
**Base de integração observada:** `b58aade`  
**PR preservada:** [#390](https://github.com/darlanmelloti/ORIGEM/pull/390)

## Objetivo

Esta rodada confirma o checkpoint R6 já validado sem executar nova mutação de produção, nova captura runtime ou novo disparo de CI. A sucessora 015 existe exclusivamente para preservar a rastreabilidade da entrega 014 até que a associação regular de checks permita promoção normal.

| Verificação reutilizada | Marcador confirmado | Resultado |
|---|---|---|
| Prova específica de composição 014 | `[ORIGEM_R6_MIDGROUND_ARCHAEOLOGY_OK]` | PASS |
| Porta regional R6 | `[GATE:R6] PASS` | PASS |
| Pipeline de regressão de rotas | `[ORIGEM_R6_ROUTE_REGRESSION_PIPELINE_OK]` | PASS |
| Baseline `forest_to_ruins` | `max_delta=0.000`, tolerância `0.050 m` | PASS |
| Baseline `majestic_to_lake` | `max_delta=0.000`, tolerância `0.050 m` | PASS |
| Baseline `ruins_arrival` | `max_delta=0.000`, tolerância `0.050 m` | PASS |

## Limites preservados

O checkpoint `5581765` continua limitado a escala e rotação locais de três vestígios visuais da chegada R6. Esta rodada não cria nem altera nós, meshes, materiais, água, luz, shader, física, colisores, lajes, rotas, âncoras, handoff R6→R7 ou conteúdo de R7.

> A ausência de associação regular de checks não invalida a validação local. Ela impede apenas a integração da PR #390, que permanece aberta sem bypass administrativo, força de histórico, cancelamento de execução ou disparos agressivos de CI.

## Próximo marco seguro

A próxima verificação da sucessora 015 somente ocorrerá quando a ponta de `integration/r1-r6-sprint1` ou o estado de associação regular de checks da PR #390 mudar. Até esse marco, não se repete runtime, captura, gate ou CI.
