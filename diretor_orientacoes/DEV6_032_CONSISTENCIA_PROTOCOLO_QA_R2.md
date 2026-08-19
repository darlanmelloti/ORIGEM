# DEV6-032 — Consistência do Protocolo QA R2

O script, a telemetria, o manifesto e a matriz de aceitação descrevem a mesma sessão R2 sem divergências.

| Elemento | Condição confirmada | Estado |
|---|---|---:|
| Script QA | `ORIGEM_QA_ROUTE=road_to_arch`, 36 s e dois PNGs | PASS |
| Log runtime | R1–R6, 9/9 grounding, 0 luzes incrementais | PASS |
| Manifesto DEV6-028 | Log e dois PNGs passam SHA-256 | PASS |
| Matriz DEV6-014 | 36 s, 9/9, 0 luzes e terceira pessoa pendente | PASS |
| Decisão visual | Sem recaptura de terceira pessoa | `REJECTED_VISUAL` coerente |

A próxima recaptura pode reutilizar o mesmo harness, mas deve gerar um manifesto de sessão novo antes de ser avaliada pela matriz.
