# CP-D5-039 — Linha de base de performance dos previews QA

## Resultado

Foi medida a execução isolada das 17 cenas QA Dev5. Cada processo foi executado em Godot headless Compatibility durante cinco segundos, com cronómetro de arranque e verificação de erros de runtime. Todas as cenas terminaram com código 0 e sem `SCRIPT ERROR`, `Parse Error`, `Invalid call`, `Invalid get` ou falha de carregamento.

| Métrica | Resultado |
|---|---:|
| Cenas medidas | 17 |
| Falhas | 0 |
| Tempo de arranque observado | 230–236 ms |
| Outlier máximo | `VossWaystationPreview`: 236 ms |
| Erros Dev5 | 0 |

A dispersão de seis milissegundos entre o mínimo e o máximo não indica outlier operacional no ambiente de QA. A medição é uma linha de base de processo headless, não uma promessa de FPS no jogo completo. Também não altera a pendência visual de R4/R6 nem promove candidatos.

O log bruto está em `CP-D5-039_PERFORMANCE_BASELINE.log`.

## Próxima acção

Abrir o CP-D5-040 para a próxima auditoria/ficha QA ou melhoria de fundação permitida.
