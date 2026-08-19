# CP-D5-141 — Regressão final do posicionamento cartográfico

## Resultado

A cena `CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). As seis âncoras canónicas foram resolvidas sem alterar os módulos de produção.

| Âncora | Landmark | World X/Z | Canvas X/Z |
|---:|---|---|---|
| 1 | Casa Voss | `(-22,8)` | `(80,452)` |
| 2 | Estrada do Rio | `(-21,4;12)` | `(234,462)` |
| 3 | Arco das Ruínas | `(-16,741;48)` | `(362,463)` |
| 4 | Floresta Densa | `(-9,116)` | `(334,244)` |
| 5 | Acampamento Majestic | `(-88,178)` | `(187,258)` |
| 6 | Ruínas Submersas | `(60,252)` | `(408,351)` |

A regressão confirma o mapeamento X/Z canónico das seis regiões, sem offsets arbitrários ou alteração dos módulos de produção. O log está em `CP-D5-141_PLACEMENT_RUNTIME.log`.
