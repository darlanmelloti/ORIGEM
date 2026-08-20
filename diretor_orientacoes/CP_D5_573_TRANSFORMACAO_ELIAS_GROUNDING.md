# CP-D5-573 — Transformação espacial de Elias sobre grounding R2/R3/R6

## Resultado

O preview isolado do Integrador de Mundo foi ampliado para materializar a posição de Elias imediatamente acima do ponto de impacto de cada raycast cartográfico, mantendo clearance de `0.02 m`. A transformação usa as âncoras espaciais do contrato e não altera `Player.gd` nem módulos de produção.

## Matriz de telemetria

| Região | Âncora XZ | Ground Y | Posição de Elias | Colisor | Erro |
|---|---:|---:|---:|---|---:|
| R2 — Estrada/Rio | `(-21.400, 25.000)` | `0.000` | `(-21.400, 0.020, 25.000)` | `R2_RoadGround` | `0.000 m` |
| R3 — Arco/Ruínas | `(-16.741, 70.000)` | `1.500` | `(-16.741, 1.520, 70.000)` | `R3_ArchGround` | `0.000 m` |
| R6 — Ruínas Submersas | `(60.000, 252.000)` | `-0.500` | `(60.000, -0.480, 252.000)` | `R6_ShoreGround` | `0.000 m` |

O parser Godot 4.7.1 terminou com `PARSER_EXIT=0`. A QA headless completou a janela controlada de 36 segundos com `QA_EXIT=124`. A telemetria confirmou `Elias=third_person`, `dynamic_lights=0`, `production_modules_changed=false` e `player_gd_changed=false`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless.

**STATUS_CODE: PASSED / ELIAS_TRANSFORM_GROUNDED / VERTICAL_SLICE_R1_R6.**
