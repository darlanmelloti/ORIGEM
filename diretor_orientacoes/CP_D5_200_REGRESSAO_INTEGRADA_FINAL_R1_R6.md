# CP-D5-200 — Regressão integrada final da sequência R1→R6

## Resultado

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A sequência completa emitiu oito checks, sem saltos de âncora, com desvio lateral Majestic e chegada R6 ligada ao marcador R7.

| Check | Região/estado | Próximo destino |
|---:|---|---|
| 1 | R1 Casa Voss `(−22,8)` | Estrada do Rio |
| 2 | R2 saída `(−21,4;25)` | Arco |
| 3 | R3 arco `(−16,741;70)` | Floresta |
| 4 | R4 floresta `(−9,140)` | Majestic |
| 5 | R5 aproximação leste `(0,178)` | Majestic |
| 6 | R5 Majestic lateral `(−88,178)` | Ruínas |
| 7 | R6 aproximação `(60,230)` | Chegada às Ruínas |
| 8 | R6 chegada `(60,252)` | Vila Elevada id 7 |

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Saltos de âncora | `false` |
| Desvio Majestic lateral | `true` |
| Chegada R6 | `true` |
| Próximo marcador | `PASSAGEM: VILA ELEVADA` |
| Produção alterada | `false` |

A regressão integrada aprova a sequência cartográfica Dev5 completa, mantendo a apresentação de Elias e o limite R6→R7. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. O log está em `CP-D5-200_INTEGRATED_SEQUENCE_RUNTIME.log`.
