# CP-D5-164 — Regressão de clearance Majestic R5

## Resultado

A cena `EliasMajesticClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O desvio lateral Majestic permaneceu navegável para Elias, com o pavilhão aterrado e margem superior ao mínimo contratado.

| Verificação | Resultado |
|---|---|
| Pavilhão aterrado | `true` |
| Pavilhão XZ | `(−88.00,178.00)` |
| Corredor QA | `CorredorMajesticEliasQA` |
| Rota X | `−80.00` |
| Clearance | 5,45 m |
| Mínimo requerido | 4,00 m |
| Ciclos limpos | 2 (`clear=true`) |
| Actor | Elias |
| Apresentação | `EliasThirdPersonPresentation` |
| Câmara de produção | `false` |
| Estado | `approved` |

A regressão aprova o desvio Majestic como leitura técnica, mantendo o estado visual rejeitado do pavilhão e sem alterar produção. O log está em `CP-D5-164_MAJESTIC_CLEARANCE_RUNTIME.log`.
