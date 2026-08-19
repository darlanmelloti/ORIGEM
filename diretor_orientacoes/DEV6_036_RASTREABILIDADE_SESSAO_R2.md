# DEV6-036 — Rastreabilidade da Sessão R2

A sessão DEV6-035 foi correlacionada entre manifesto, log e duas capturas. Os hashes SHA-256 passaram, e os tempos dos ficheiros são coerentes com uma única execução de 36 segundos: a captura intermédia precede o frame final e o log é gravado no final da sessão.

| Artefacto | Estado |
|---|---:|
| Log de rota | PASS — hash validado |
| Captura intermédia 1920×1080 | PASS — hash validado |
| Captura final 1920×1080 | PASS — hash validado |
| Ordenação temporal | PASS — intermédia antes do final/log |
| Critérios técnicos | PASS — DEV6-035 |
| Perspectiva de terceira pessoa | PENDENTE — Dev1/Dev3 |
| Composição cartográfica | PENDENTE — Dev3 |

A integridade da sessão não substitui a recaptura visual. A única condição que pode alterar o estado `REJECTED_VISUAL` continua a ser uma prova de terceira pessoa que passe a matriz DEV6-014.
