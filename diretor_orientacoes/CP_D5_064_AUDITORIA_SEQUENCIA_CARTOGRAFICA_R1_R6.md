# CP-D5-064 — Auditoria de sequência cartográfica R1–R6

## Resultado

O preview `CartographicSequenceR1R6Preview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless e verificou oito marcos sequenciais, sem saltos de âncora.

| Ordem | ID | X/Z | Próximo | Rumo |
|---:|---|---|---:|---|
| 1 | `r1_voss` | `(-22,8)` | 2 | Estrada do Rio |
| 2 | `r2_road_exit` | `(-21,4;25)` | 3 | Arco |
| 3 | `r3_arch` | `(-16,741;70)` | 4 | Floresta |
| 4 | `r4_forest` | `(-9,140)` | 5 | Majestic |
| 5 | `r5_east_approach` | `(0,178)` | 5 | Majestic |
| 6 | `r5_majestic_west` | `(-88,178)` | 6 | Ruínas |
| 7 | `r6_approach` | `(60,230)` | 6 | Chegada às Ruínas |
| 8 | `r6_arrival` | `(60,252)` | 7 | Vila Elevada |

A telemetria confirmou `checks=8`, `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`. A sequência preserva a transição lateral necessária no Majestic e não altera módulos de produção. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-064_CARTOGRAPHIC_SEQUENCE_RUNTIME.log`.
