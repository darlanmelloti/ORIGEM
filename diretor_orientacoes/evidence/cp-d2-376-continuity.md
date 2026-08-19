# CP-D2-376 — Contrato de collider por handoff R7–R12

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Regiões 7–12 — ponte mapa → collider existente |
| **STATUS_CODE** | PASSED |
| **TAREFA_EXECUTADA** | Cada contrato cartográfico passou a transportar o nome exacto do collider existente; o harness valida os cinco pares com regex compatível com o log runtime, sem criar geometrias ou colliders novos. |
| **QA_RUNTIME** | QA ON/OFF com paridade aprovada; a falha inicial de correspondência de formato foi corrigida e o ciclo foi repetido com sucesso. |
| **EVIDÊNCIA** | Headless PASS; gameplay 30s PASS em ambos; print 1600×900 PASS em ambos; scope guard PASS; cinco colliders verificados. |
| **LUZES R12** | 11 / máximo 16 |
| **NEXT_ACTION_IMMEDIATE** | CP-D2-377 — empacotar com SHA-256, sincronizar Git e iniciar novo passe concreto R7–R12. |
| **WAIT_ALLOWED** | `false` |
