# CP-D5-056 — Leitura R6 com Elias, baliza e vegetação

## Resultado

A cena correcta publicada para este checkpoint é `R6EliasVegetationReadPreview.tscn`. O caminho inicialmente presumido `SubmergedEliasMonolithReadPreview.tscn` não existe; a descoberta foi corrigida consultando os ficheiros efectivamente publicados. A cena correcta passou 36 segundos em Compatibility.

| Critério | Resultado |
|---|---|
| Baliza monolítica R6 | Grounded, X/Z `(52,260)` |
| Elias | Câmara QA externa; `elias_camera_current=false` |
| Trajecto | X = `60`, dois ciclos `clear=true` |
| Folga | `6,05 m` |
| Vegetação | 3 elementos aterrados |
| Lajes de cais | 0 |
| Parede de árvores | `false` |
| Produção | `production_modules_changed=false` |
| Runtime | 36 segundos sem `SCRIPT ERROR` ou `Parse Error` |

A leitura R6 preserva a silhueta da baliza, o corredor central e uma composição vegetal leve, sem repetir a linguagem rejeitada de cais com lajes. A advertência FSR1 é do renderer local e não afecta a prova técnica.

O log está em `CP-D5-056_R6_ELIAS_VEGETATION_RUNTIME.log`.
