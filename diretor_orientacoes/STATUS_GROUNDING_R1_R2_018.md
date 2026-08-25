# STATUS DEV1 — ESTABILIDADE FÍSICA R1–R2 018

**Branch:** `integration/r1-r6-sprint1`  
**Responsável:** Dev1  
**Data:** 25 de agosto de 2026

## Problema protegido

A fase inicial do projeto apresentou historicamente risco de queda livre quando o jogador era criado antes de o colisor regional estabilizar. Foi introduzida a prova **QA-GROUND-01** para vigiar esse comportamento em runtime.

## O que a prova mede

O runner `tools/qa/run_player_grounding.gd` aguarda a inicialização física, acompanha a menor altura de Elias e mede a variação vertical posterior. A execução falha se o jogador cair abaixo da altura segura ou se, após o aquecimento, não demonstrar contacto de chão ou posição vertical estável.

A métrica de variação vertical complementa `is_on_floor()`: alguns colisores regionais estabilizam o `CharacterBody3D` antes de o motor reportar contacto no primeiro ciclo de física. Assim, o teste continua a apanhar queda livre real sem reprovar uma aterragem curta prevista pelo spawn.

## Validações realizadas

| Cenário | Resultado |
|---|---|
| Spawn normal na Casa Voss | PASS — 180 frames de contacto de chão |
| Handoff Casa Voss → Estrada do Rio | PASS — posição vertical estável após aterragem |
| Porta R2 completa | PASS — estabilidade, contratos e três rotas |

## Integração contínua

A porta regional de R2 passa agora a executar a prova de estabilidade antes das rotas de Estrada do Rio. Portanto, qualquer regressão de spawn R1→R2 falhará automaticamente no GitHub antes da integração.
