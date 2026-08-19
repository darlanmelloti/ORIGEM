# CP-D5-271 — Regressão corredor florestal R4

## Resultado

A cena `DenseForestPortalPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O corredor florestal R4 permanece isolado para QA, com passagem livre de 2,4 m e sem alterar o script da região de produção.

| Verificação | Resultado |
|---|---|
| Anchor R4 | `(-9,116)` |
| Largura de passagem | 2,4 m |
| Passagem isolada | `true` |
| Script da região alterado | `false` |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Estado | `approved` |

A regressão mantém a clareira jogável e não introduz portal estrutural nem parede de árvores. Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-271_DENSE_FOREST_RUNTIME.log`.
