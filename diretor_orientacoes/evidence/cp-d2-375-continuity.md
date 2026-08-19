# CP-D2-375 — Asserção física obrigatória no harness R7–R12

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Regiões 7–12 — QA do contrato cartográfico físico |
| **STATUS_CODE** | PASSED |
| **TAREFA_EXECUTADA** | O harness passou a exigir `physical=true` nos cinco handoffs R07_R08, R08_R09, R09_R10, R10_R11 e R11_R12 quando o espelho runtime está activo. |
| **QA_RUNTIME** | QA ON/OFF com paridade aprovada; QA OFF não depende do overlay. |
| **EVIDÊNCIA** | Headless PASS; gameplay 30s PASS em ambos; print 1600×900 PASS em ambos; scope guard PASS; cinco asserções físicas aprovadas. |
| **LUZES R12** | 11 / máximo 16 |
| **NEXT_ACTION_IMMEDIATE** | CP-D2-376 — empacotar com SHA-256, sincronizar Git e iniciar novo passe concreto R7–R12. |
| **WAIT_ALLOWED** | `false` |
