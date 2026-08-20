# CP-D5-575 — Auditoria de consistência cartográfica

## Resultado

Foi adicionada uma auditoria runtime ao preview isolado para provar que a transformação de Elias conserva a âncora cartográfica em X/Z e mantém exactamente `0.020 m` de clearance acima do ponto de impacto do raycast, dentro de tolerância de `0.001 m`.

| Região | Ground Y | Elias | Clearance | X/Z | Colisor |
|---|---:|---|---:|---|---|
| R2 | `0.000` | `(-21.400, 0.020, 25.000)` | `0.020 m` | `true` | `R2_RoadGround` |
| R3 | `1.500` | `(-16.741, 1.520, 70.000)` | `0.020 m` | `true` | `R3_ArchGround` |
| R6 | `-0.500` | `(60.000, -0.480, 252.000)` | `0.020 m` | `true` | `R6_ShoreGround` |

A validação terminou com `PARSER_EXIT=0`, QA controlada de `36 s` (`QA_EXIT=124` por término do timeout), `checks=3`, `consistency=3`, `Elias=third_person`, `dynamic_lights=0`, `production_modules_changed=false` e `player_gd_changed=false`.

**STATUS_CODE: PASSED / CARTOGRAPHIC_CONSISTENCY / VERTICAL_SLICE_R1_R6.**
