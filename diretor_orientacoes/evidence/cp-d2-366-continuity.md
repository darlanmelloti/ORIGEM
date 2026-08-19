# CP-D2-366 — Contrato cartográfico R10–R12

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Regiões 10–12 — Caverna do Orion, Câmara do Cubo e Cúpula Final |
| **STATUS_CODE** | PASSED |
| **TAREFA_EXECUTADA** | A autoridade cartográfica passou a transportar, por marco, `map_approach`, `handoff_in`, `handoff_out`, `visual_subject` e `validation_state=RUNTIME_QA_ONLY`, sem criar coordenadas concorrentes. |
| **MAP_AUTHORITY** | `mapaorigem.webp`; escopo declarado `REGIONS_7_12_ONLY`. |
| **QA_RUNTIME** | QA ON/OFF com paridade aprovada; overlay continua dinâmico e ausente do pacote de produção. |
| **EVIDÊNCIA** | Headless PASS; gameplay 30s PASS em ambos; print 1600×900 PASS em ambos; scope guard PASS. |
| **LUZES R12** | 11 / máximo 16 |
| **NEXT_ACTION_IMMEDIATE** | CP-D2-367 — empacotar com SHA-256, sincronizar Git e iniciar novo passe físico/cartográfico R7–R12. |
| **WAIT_ALLOWED** | `false` |
