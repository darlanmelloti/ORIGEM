# CP-D2-372 — Asserções individuais dos handoffs R7–R12

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Regiões 7–12 — contrato físico/cartográfico completo |
| **STATUS_CODE** | PASSED |
| **TAREFA_EXECUTADA** | O harness passou a validar individualmente `R07_R08`, `R08_R09`, `R09_R10`, `R10_R11` e `R11_R12`, sempre com `mapaorigem.webp` como autoridade. |
| **QA_RUNTIME** | QA ON/OFF com paridade aprovada; asserções só exigem metadados quando o espelho runtime está activo. |
| **EVIDÊNCIA** | Headless PASS; gameplay 30s PASS em ambos; print 1600×900 PASS em ambos; scope guard PASS; cinco handoffs verificados. |
| **LUZES R12** | 11 / máximo 16 |
| **NEXT_ACTION_IMMEDIATE** | CP-D2-373 — empacotar com SHA-256, sincronizar Git e iniciar novo passe concreto R7–R12. |
| **WAIT_ALLOWED** | `false` |
