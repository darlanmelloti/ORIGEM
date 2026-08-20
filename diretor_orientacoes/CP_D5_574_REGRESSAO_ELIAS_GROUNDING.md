# CP-D5-574 — Regressão de Elias sobre grounding R2/R3/R6

## Resultado

A regressão confirmou a transformação espacial de Elias sobre os três pontos cartográficos do vertical slice. Cada raycast encontrou o colisor esperado, manteve erro vertical `0.000 m` e posicionou Elias com clearance de `0.02 m`.

| Região | Ground Y | Elias X/Y/Z | Colisor | Estado |
|---|---:|---:|---|---|
| R2 | `0.000` | `(-21.400, 0.020, 25.000)` | `R2_RoadGround` | `grounded=true` |
| R3 | `1.500` | `(-16.741, 1.520, 70.000)` | `R3_ArchGround` | `grounded=true` |
| R6 | `-0.500` | `(60.000, -0.480, 252.000)` | `R6_ShoreGround` | `grounded=true` |

O parser Godot 4.7.1 terminou com `PARSER_EXIT=0`; a QA headless completou a janela controlada de 36 segundos com `QA_EXIT=124`. A telemetria manteve `Elias=third_person`, `dynamic_lights=0`, `production_modules_changed=false` e `player_gd_changed=false`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless.

**STATUS_CODE: PASSED / ELIAS_GROUNDING_REGRESSION / VERTICAL_SLICE_R1_R6.**
