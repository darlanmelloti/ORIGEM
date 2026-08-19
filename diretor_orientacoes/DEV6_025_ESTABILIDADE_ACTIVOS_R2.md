# DEV6-025 — Estabilidade dos Activos R2

A verificação de carregamento foi executada no editor Godot e numa sessão real `road_to_arch`. Não foram detectados erros de parser, de recurso em falta ou de abertura de ficheiro para os activos da integração R2.

| Verificação | Resultado |
|---|---:|
| Editor Godot headless | PASS — sem erros de recurso |
| Parser | PASS |
| Gameplay `road_to_arch` | PASS — 36 s |
| Fauna, vegetação, ponte e vestígios | PASS — integração registada no runtime |
| Grounding | PASS — 9/9 |
| Luzes incrementais | PASS — 0 |
| Recursos em falta | PASS — nenhum detectado |

A camada R2 está estável no carregamento. A única condição visual pendente continua a ser a recaptura de terceira pessoa, propriedade de Dev1/Dev3.
