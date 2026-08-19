# CP-D2-368 — Contrato de cadeia cartográfica R9–R12

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Regiões 10–12 — cadeia cartográfica integrada com handoffs R9→R10→R11→R12 |
| **STATUS_CODE** | PASSED |
| **TAREFA_EXECUTADA** | O nó `CartographicAnchors_Regioes10a12` passou a declarar a cadeia de handoff, contagem de 3 âncoras e estado runtime-only, mantendo `mapaorigem.webp` como autoridade espacial. |
| **QA_RUNTIME** | QA ON/OFF com paridade aprovada; overlay dinâmico, sem referência persistente na cena de produção. |
| **EVIDÊNCIA** | Headless PASS; gameplay 30s PASS em ambos; print 1600×900 PASS em ambos; scope guard PASS. |
| **LUZES R12** | 11 / máximo 16 |
| **NEXT_ACTION_IMMEDIATE** | CP-D2-369 — empacotar com SHA-256, sincronizar Git e iniciar novo passe físico/cartográfico R7–R12. |
| **WAIT_ALLOWED** | `false` |
