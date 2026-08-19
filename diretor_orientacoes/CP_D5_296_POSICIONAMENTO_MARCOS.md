# CP-D5-296 — Regressão do posicionamento cartográfico R1–R6

A cena `CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A telemetria confirmou os seis marcos canónicos, com coordenadas X/Z de mundo e correspondência no canvas do mapa.

| Âncora | Marco | X/Z mundo | Canvas mapa |
|---:|---|---|---|
| 1 | Casa Voss | `(-22.0, 8.0)` | `(80.0, 452.0)` |
| 2 | Estrada do Rio | `(-21.4, 12.0)` | `(234.0, 462.0)` |
| 3 | Arco das Ruínas | `(-16.741, 48.0)` | `(362.0, 463.0)` |
| 4 | Floresta Densa | `(-9.0, 116.0)` | `(334.0, 244.0)` |
| 5 | Acampamento Majestic | `(-88.0, 178.0)` | `(187.0, 258.0)` |
| 6 | Ruínas Submersas | `(60.0, 252.0)` | `(408.0, 351.0)` |

Não foram observados erros de script ou parser. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-296_PLACEMENT_RUNTIME.log`.
