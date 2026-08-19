# CP-D5-111 — Correcção e validação da colocação cartográfica

## Resultado

A execução inicial detectou `Parse Error: Unexpected "if" in class body` em `CartographicPlacementPreview.gd`, causado pela indentação dos fallbacks do snapshot headless. A correcção ficou limitada a `levels/dev5/CartographicPlacementPreview.gd`, sem tocar módulos de produção.

Após a correcção, o parser terminou com `PARSER_EXIT=0` e a sessão QA atingiu 36 segundos pelo timeout controlado (`QA_EXIT=124`). As seis âncoras foram emitidas com X/Z canónicos e os respectivos pontos no canvas do mapa.

| Âncora | Marco | X/Z |
|---:|---|---|
| 1 | Casa Voss | `(-22.0, 8.0)` |
| 2 | Estrada do Rio | `(-21.4, 12.0)` |
| 3 | Arco das Ruínas | `(-16.741, 48.0)` |
| 4 | Floresta Densa | `(-9.0, 116.0)` |
| 5 | Acampamento Majestic | `(-88.0, 178.0)` |
| 6 | Ruínas Submersas | `(60.0, 252.0)` |

A falha de parser foi eliminada, o fallback continua seguro para viewport headless e o sistema de colocação voltou a validar todas as âncoras. O log corrigido está em `CP-D5-111_CARTOGRAPHIC_PLACEMENT_RUNTIME_FIXED.log`; o log da primeira execução permanece como evidência da regressão encontrada.
