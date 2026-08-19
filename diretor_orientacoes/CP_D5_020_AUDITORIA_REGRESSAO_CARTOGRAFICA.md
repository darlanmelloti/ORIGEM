# CP-D5-020 — Auditoria de regressão cartográfica

## Resultado

A cena `CartographicRegressionAuditPreview.tscn` verificou os candidatos Dev5 publicados sem alterar módulos de produção. Cada candidato foi avaliado através de `CartographicPlacementSystem.gd`, com marco, posição canónica no mapa, posição mundial calculada e `local_offset=(0,0)`.

| Candidato | Marco | Canvas do mapa | World X/Z | Offset | Colisores | Luzes do candidato |
|---|---:|---|---|---|---:|---:|
| Casa Voss | 1 | `(80,452)` | `(-22,8)` | `(0,0)` | 12 | 0 |
| Ponte | 2 | `(234,462)` | `(-21,4;12)` | `(0,0)` | 14 | 0 |
| Floresta Densa | 4 | `(334,244)` | `(-9,116)` | `(0,0)` | 20 | 0 |
| Majestic | 5 | `(187,258)` | `(-88,178)` | `(0,0)` | 4 | 0 |
| Ruínas Submersas | 6 | `(408,351)` | `(60,252)` | `(0,0)` | 18 | 0 |
| Vegetação média | 4 | `(334,244)` | `(-9,116)` | `(0,0)` | 0 | 0 |

A saída do harness contabiliza uma luz por candidato porque cada cena preview possui uma luz direccional QA própria; essas luzes pertencem ao ambiente de teste, não aos objectos cartográficos. Nenhum candidato cria luz dinâmica adicional durante a auditoria e nenhum production script foi instanciado.

## Validação

A sessão headless completou 36 segundos, confirmou os seis placement records e não produziu erros de parser, script ou runtime Dev5. O aviso FSR1 é externo ao candidato e resulta do renderer de compatibilidade. Nenhuma geometria rejeitada foi repetida.

## Próxima tarefa

Após publicação, iniciar imediatamente o próximo item permitido pela escada de continuidade Dev5; uma fila explícita vazia abre a primeira tarefa derivada autorizada, nunca uma espera ou nova consulta passiva.
