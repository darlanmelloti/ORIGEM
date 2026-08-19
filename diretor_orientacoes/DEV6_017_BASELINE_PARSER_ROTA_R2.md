# DEV6-017 — Baseline de Parser e Rota R2

A baseline foi executada para preparar a recaptura de terceira pessoa assim que Dev1/Dev3 publicar a câmara. O teste foi realizado sobre a configuração actual, sem alterar jogador ou câmara.

| Verificação | Resultado |
|---|---:|
| Parser Godot 4.7.1 | PASS |
| Rota QA | PASS — `road_to_arch` |
| Duração | PASS — 36 s |
| Mundo de prova | PASS — R1–R6 |
| Spawn | PASS — Estrada–Arco em `(-20.05, 0.606, 22.0)` |
| Foco cartográfico | PASS — `(-13.8, 0.0, 92.0)` |
| Grounding | PASS — 9/9, X/Z preservado |
| Luzes incrementais | PASS — 0 |

A próxima recaptura deve repetir exactamente este contrato depois de a câmara de terceira pessoa ser integrada, para permitir comparação sem regressões.
