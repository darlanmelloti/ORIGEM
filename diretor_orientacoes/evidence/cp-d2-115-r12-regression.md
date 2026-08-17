# CP-D2-115 — Região 12 — Regressão Pós-Composição

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Região 12 — Hub Temporal / Cúpula Final |
| **STATUS_CODE** | PASSED |
| **TAREFA_EM_EXECUCAO_AGORA** | Empacotar e sincronizar a regressão validada antes do próximo passe |
| **ESCOPO_BLOQUEADO** | Regiões 1–6 permanecem intocadas |
| **DEADLINE_PROXIMO_PUSH** | 2026-08-18 07:35 GMT+1 |

A regressão integral após o CP-D2-114 passou no Godot 4.7.1. A telemetria registou `fps=27–31` durante o percurso e `draw_calls=58–68`, sem erros de parser/runtime. A câmara continua baixa e aproximada, o chão dedicado permanece visível, a soleira e os monólitos mantêm silhueta contínua e não surgiram plataformas suspensas.

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `3669ad437c9db92ce1aa3ca39e07e9315e4fa23425144dd2231d4f1374084f3e` |
| `print-1600x900.jpg` | `dccdcc031c679baf7f119ea52b90c88424664a1700c54b2394af7abf0a94de1f` |
| Pacote CP-D2-115 | Será calculado no empacotamento final do ciclo |

## NEXT_ACTION_IMMEDIATE

Empacotar e publicar o CP-D2-115; depois iniciar o CP-D2-116 na Região 12, mantendo a rotina de leitura de orientações, QA visual, gameplay, print, ZIP, SHA-256 e scope guard.
