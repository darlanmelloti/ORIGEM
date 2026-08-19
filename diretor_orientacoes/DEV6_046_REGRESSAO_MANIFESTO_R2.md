# DEV6-046 — Regressão e Manifesto de Sessão R2

A regressão DEV6-046 executou o parser Godot, a rota `road_to_arch` por 36 segundos e o manifesto SHA-256 da sessão, sem alterar câmara, jogador, rota ou geometria.

| Verificação | Resultado |
|---|---:|
| Parser Godot 4.7.1 | PASS |
| Rota `road_to_arch` | PASS — 36 s |
| Escopo | PASS — R1–R6 |
| Grounding | PASS — 9/9, X/Z preservado |
| Luzes incrementais | PASS — 0 |
| Manifesto DEV6-046 | PASS — 3/3 hashes válidos |
| Recaptura de terceira pessoa | Não disponível |
| Aceitação visual | Mantém `REJECTED_VISUAL` |

A integração R2 continua tecnicamente estável e não será promovida visualmente até existir uma recaptura de terceira pessoa que satisfaça a matriz DEV6-014.
