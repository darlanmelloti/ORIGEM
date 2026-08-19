# CP-D5-281 — Recaptura R1→R3 contínua

## Resultado

A cena `R1R3ThirdPersonCartographicPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias foi apresentado em terceira pessoa na travessia R1→R3, com o Arco visível no eixo `z=92`, escala mundial de 70 m e dois ciclos de rota livres.

| Verificação | Resultado |
|---|---|
| Actor | Elias |
| Câmara | terceira pessoa |
| Arco | `arch_z=92.0` |
| Aterramento | `grounded=1` |
| Luzes da cena | 1 direccional QA |
| Escala mundial | 70 m |
| Ciclos de rota | 2, ambos `clear=true` |
| Arco visível | `true` nos dois ciclos |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, `QA_EXIT=124` |
| Produção / `Player.gd` | preservados |
| Estado técnico | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. A avaliação visual permanece separada da aprovação técnica, conforme a orientação histórica; o log está em `CP-D5-281_R1_R3_RECAPTURE_RUNTIME.log`.
