# CP-D5-211 — Regressão da legibilidade natural da Floresta Densa R4

## Resultado

A cena `DenseForestPortalPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O preview confirmou a passagem natural isolada da Floresta Densa sem depender de portal estrutural.

| Verificação | Resultado |
|---|---|
| Âncora R4 | `(−9.0,116.0)` |
| Largura da passagem | 2,4 m |
| Passagem isolada | `true` |
| Script regional alterado | `false` |
| Estado | `approved` |

A regressão aprova a legibilidade natural R4 e preserva a fronteira com os módulos de produção. Os avisos FSR1 do Compatibility renderer são conhecidos. O log está em `CP-D5-211_R4_DENSE_FOREST_RUNTIME.log`.
