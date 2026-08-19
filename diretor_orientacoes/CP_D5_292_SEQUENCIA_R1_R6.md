# CP-D5-292 — Regressão da sequência cartográfica R1–R6

A cena `CartographicSequenceR1R6Preview.tscn` passou o parser e uma sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A telemetria confirmou oito handoffs consecutivos, sem salto de âncora, incluindo Majestic lateral, chegada às Ruínas e a passagem final para Vila Elevada.

| Marco | X/Z | Próximo | Rótulo |
|---|---|---:|---|
| `r1_voss` | `(-22.000, 8.000)` | 2 | RUMO À ESTRADA DO RIO |
| `r2_road_exit` | `(-21.400, 25.000)` | 3 | RUMO AO ARCO |
| `r3_arch` | `(-16.741, 70.000)` | 4 | RUMO À FLORESTA |
| `r4_forest` | `(-9.000, 140.000)` | 5 | RUMO AO MAJESTIC |
| `r5_east_approach` | `(0.000, 178.000)` | 5 | RUMO AO MAJESTIC |
| `r5_majestic_west` | `(-88.000, 178.000)` | 6 | RUMO ÀS RUÍNAS |
| `r6_approach` | `(60.000, 230.000)` | 6 | CHEGADA ÀS RUÍNAS |
| `r6_arrival` | `(60.000, 252.000)` | 7 | PASSAGEM: VILA ELEVADA |

**Estado:** `approved`, `checks=8`, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true`. A prova permanece uma cena QA Dev5; nenhum módulo de produção foi modificado. Evidência completa em `CP-D5-292_SEQUENCE_RUNTIME.log`.
