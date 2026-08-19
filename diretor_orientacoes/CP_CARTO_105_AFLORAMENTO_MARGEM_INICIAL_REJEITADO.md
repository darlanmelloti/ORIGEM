# CP-CARTO-105 — Afloramento da Margem Inicial Rejeitado

## Resultado

Foi acrescentado temporariamente um único afloramento CC0 em `z=17` na margem inicial, sem modificar a água, rota, colisores, luzes ou câmaras. O parser e 36 segundos de gameplay na tomada lateral Casa Voss passaram.

A captura não mostrou diferença visual suficiente na leitura da lâmina escura do rio. A entrada foi removida de `bank_data`; a margem de produção regressou ao estado anterior.

| Verificação | Resultado |
|---|---|
| Gameplay real | 36 segundos, PASS |
| Captura | `/home/ubuntu/qa_evidence_dev1_cp245/voss_lateral_cp105_near_bank/voss_lateral_36s.png` |
| Avaliação artística | REJECTED_VISUAL |
| Estado final | Revertido |

Não repetir o afloramento isolado em `z=17` com a mesma escala e rotação. A leitura plana do rio exige uma abordagem não incremental e não deve voltar a usar adição pontual de rocha como hipótese isolada.
