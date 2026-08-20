# CP-D5-572 — Contrato de grounding do vertical slice R2, R3 e R6

## Finalidade

Este contrato reorienta a frente Dev5 para a função de **Integrador de Mundo**, subordinando as transformações espaciais à autoridade cartográfica e preservando a direcção visual do Dev3. O escopo é isolado em `levels/dev5/` e `diretor_orientacoes/`; não altera módulos de produção nem `Player.gd`.

## Matriz de integração

| Região | Marco cartográfico XZ | Colisor esperado | Método | Erro vertical máximo |
|---|---:|---|---|---:|
| R2 — Estrada/Rio | `(-21.4, 25.0)` | `R2_RoadGround` | Raycast descendente | `0.05 m` |
| R3 — Arco/Ruínas | `(-16.741, 70.0)` | `R3_ArchGround` | Raycast descendente | `0.05 m` |
| R6 — Ruínas Submersas | `(60.0, 252.0)` | `R6_ShoreGround` | Raycast descendente | `0.05 m` |

Cada raycast nasce acima do terreno, utiliza comprimento suficiente para a região e deve posicionar a apresentação de Elias com clearance de `0.02 m`. O preview deve manter câmara `CameraQA`, terceira pessoa, zero luzes dinâmicas e conformidade com o limite de 16 luzes da GTX 1050 Ti.

> A autoridade espacial é o mapa cartográfico; a autoridade visual é a direcção cinemática do Dev3. O grounding Dev5 integra ambas sem substituir o design visual nem a lógica de gameplay do Dev1.

## Critérios de aceitação

O contrato machine-readable está em `levels/dev5/R2R3R6GroundingContract.json`. A implementação seguinte deve emitir telemetria por região, comprovar `grounded=true`, confirmar o colisor esperado, manter `production_modules_changed=false` e `player_gd_changed=false`, passar o parser Godot 4.7.1 e completar QA headless de 36 segundos.

**STATUS_CODE: CONTRACT_DEFINED / READY_FOR_IMPLEMENTATION.**
