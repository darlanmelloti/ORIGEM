# CP-D2-373 — Flags de handoff físico R7–R12

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Regiões 7–12 — contratos físicos da cadeia cartográfica |
| **STATUS_CODE** | PASSED |
| **TAREFA_EXECUTADA** | Os cinco contratos `R07_R08`, `R08_R09`, `R09_R10`, `R10_R11` e `R11_R12` passaram a declarar `physical_handoff=true`, mantendo `mapaorigem.webp` como autoridade. |
| **QA_RUNTIME** | QA ON/OFF com paridade aprovada; overlay permanece runtime-only. |
| **EVIDÊNCIA** | Headless PASS; gameplay 30s PASS em ambos; print 1600×900 PASS em ambos; scope guard PASS; IDs físicos verificados. |
| **LUZES R12** | 11 / máximo 16 |
| **NEXT_ACTION_IMMEDIATE** | CP-D2-374 — empacotar com SHA-256, sincronizar Git e iniciar novo passe concreto R7–R12. |
| **WAIT_ALLOWED** | `false` |
