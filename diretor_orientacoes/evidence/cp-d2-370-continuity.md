# CP-D2-370 — Asserção executável do contrato cartográfico

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Regiões 7–12 — validação do espelho cartográfico |
| **STATUS_CODE** | PASSED |
| **TAREFA_EXECUTADA** | O harness passou a exigir, em QA ON, a linha `MAP_MIRROR_ANCHOR_CONTRACT chain=R9->R10->R11->R12 count=3 state=RUNTIME_QA_ONLY`; QA OFF permanece independente do overlay. |
| **QA_RUNTIME** | ON/OFF com paridade aprovada; contrato runtime verificável e overlay não persistente. |
| **EVIDÊNCIA** | Headless PASS; gameplay 30s PASS em ambos; print 1600×900 PASS em ambos; scope guard PASS. |
| **LUZES R12** | 11 / máximo 16 |
| **NEXT_ACTION_IMMEDIATE** | CP-D2-371 — empacotar com SHA-256, sincronizar Git e iniciar novo passe concreto R7–R12. |
| **WAIT_ALLOWED** | `false` |
