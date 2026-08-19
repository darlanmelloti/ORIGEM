# CP-D2-371 — IDs de handoff R7–R12 no espelho runtime

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Regiões 7–12 — continuidade Vila Elevada → Cúpula Final |
| **STATUS_CODE** | PASSED |
| **TAREFA_EXECUTADA** | As funções de continuidade R7→R8, R8→R9, R9→R10, R10→R11 e R11→R12 passaram a transportar `handoff_id` e `map_authority`; o overlay QA reporta os cinco contratos em runtime. |
| **QA_RUNTIME** | QA ON/OFF com paridade aprovada; overlay continua runtime-only. |
| **EVIDÊNCIA** | Headless PASS; gameplay 30s PASS em ambos; print 1600×900 PASS em ambos; scope guard PASS; cinco IDs verificados no log QA ON. |
| **LUZES R12** | 11 / máximo 16 |
| **NEXT_ACTION_IMMEDIATE** | CP-D2-372 — empacotar com SHA-256, sincronizar Git e iniciar novo passe concreto R7–R12. |
| **WAIT_ALLOWED** | `false` |
