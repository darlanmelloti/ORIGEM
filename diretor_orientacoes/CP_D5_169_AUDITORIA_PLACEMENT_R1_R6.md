# CP-D5-169 — Auditoria de colocação cartográfica R1→R6

## Resultado

A cena `CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). As seis âncoras Dev5 foram emitidas com coordenadas X/Z canónicas e posições correspondentes no canvas do mapa.

| Âncora | Região | Mundo X/Z | Canvas X/Y |
|---:|---|---|---|
| 1 | Casa Voss | `(−22.0,8.0)` | `(80.0,452.0)` |
| 2 | Estrada do Rio | `(−21.4,12.0)` | `(234.0,462.0)` |
| 3 | Arco das Ruínas | `(−16.741,48.0)` | `(362.0,463.0)` |
| 4 | Floresta Densa | `(−9.0,116.0)` | `(334.0,244.0)` |
| 5 | Acampamento Majestic | `(−88.0,178.0)` | `(187.0,258.0)` |
| 6 | Ruínas Submersas | `(60.0,252.0)` | `(408.0,351.0)` |

O renderer emitiu avisos FSR1 incompatíveis com o modo Compatibility, mas não houve falha de parser ou script Dev5; a sessão QA terminou pelo timeout controlado. A auditoria mantém a produção inalterada. O log está em `CP-D5-169_PLACEMENT_AUDIT_RUNTIME.log`.
