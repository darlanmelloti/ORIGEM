# CP-D5-244 — Recaptura R1→R3 em terceira pessoa

## Resultado técnico

A cena `R1R3ThirdPersonCartographicPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A telemetria confirmou Elias em terceira pessoa, Arco no eixo canónico `z=92.0`, escala mundial de 70 m, um foco de luz e dois ciclos de rota livres.

| Verificação | Resultado |
|---|---|
| Estado técnico | `ready` |
| Actor | `Elias` |
| Câmara | `third_person` |
| Arco | visível no eixo `z=92.0` |
| Aterramento | `1` |
| Luzes | 1 |
| Escala mundial | 70 m |
| Ciclos de rota | 2, ambos `clear=true` |
| Arco visível | `true` |
| Parser | `PARSER_EXIT=0` |
| QA | 36 segundos, timeout controlado |

Os avisos `FSR1 is only available when using the Forward+ renderer` são específicos do renderer OpenGL Compatibility em headless. Esta prova confirma o contrato técnico, mas não promove a captura visual: a avaliação visual continua **REJECTED_VISUAL**, conforme CP-D5-130, devido ao terreno granular, marcadores técnicos, ruínas de baixa complexidade e silhueta provisória. Não foram alterados `Player.gd`, produção ou Regiões 7–12.

O log está em `CP-D5-244_R1_R3_RECAPTURE_RUNTIME.log`.
