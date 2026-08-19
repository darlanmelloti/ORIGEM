# CP-D5-072 — Leitura R6 de Elias com vegetação

## Resultado

O preview `R6EliasVegetationReadPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. Elias percorreu a leitura das Ruínas R6 com o monólito e a vegetação grounded, mantendo o corredor aberto em dois ciclos.

| Critério | Resultado |
|---|---|
| Monólito grounded | `true` |
| Monólito X/Z | `(52,260)` |
| Câmara | `CameraQAR6Leitura` |
| Câmara de Elias actual | `false` |
| Módulos de produção alterados | `false` |
| Vegetação | 3 elementos |
| Folga de rota | `6,05 m` |
| Lajes de cais | 0 |
| Parede de árvores | `false` |
| Ciclos de rota | 2, ambos `clear=true` |
| Actor | Elias |
| Runtime | 36 segundos |
| `SCRIPT ERROR` | 0 |

A advertência FSR1 pertence ao renderer Compatibility local. A captura visual final de R6 continua pendente de viewport gráfico válido.

O log está em `CP-D5-072_R6_VEGETATION_READ_RUNTIME.log`.
