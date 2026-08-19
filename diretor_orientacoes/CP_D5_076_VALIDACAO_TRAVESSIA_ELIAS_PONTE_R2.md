# CP-D5-076 — Travessia Elias na ponte modular R2

## Resultado

A primeira execução detectou uma asserção transitória de grounding antes de o frame de física concluir. O preview foi corrigido para aguardar um `physics_frame` adicional antes de validar o contrato, sem alterar geometria, colisão ou orçamento. A sessão final passou 36 segundos.

| Critério | Resultado |
|---|---|
| Âncora | R2 |
| Ponte X/Z | `(-21,4;28)` |
| Grounding | `true` |
| Colisor | `tabuleiro_continuo` |
| Tipo | `modular_not_glb` |
| Câmara de Elias actual | `false` |
| Folga do tabuleiro | `0,21 m` |
| Folga exigida | `0,20 m` |
| Ciclos de travessia | 3 |
| Luzes dinâmicas | 1, conforme contrato |
| `SCRIPT ERROR` final | 0 |

A travessia modular R2 foi validada sem integrar GLB nem alterar módulos de produção ou `Player.gd`. A advertência FSR1 pertence ao renderer Compatibility local.

Os logs são `CP-D5-076_ELIAS_BRIDGE_RUNTIME.log` e `CP-D5-076_ELIAS_BRIDGE_RUNTIME_FIXED.log`.
