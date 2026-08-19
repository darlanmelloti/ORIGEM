# CP-D2-367 — Handoff físico da soleira R12

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Região 12 — Cúpula Final / soleira de saída |
| **STATUS_CODE** | PASSED |
| **TAREFA_EXECUTADA** | O marcador `WayfindingOrganicoSoleiraR12` passou a declarar `handoff_out=ColisaoHandoffSoleiraR12`, vector de aproximação e estado de validação runtime-only, mantendo posição/altura derivados da rota cartográfica. |
| **MAP_AUTHORITY** | `mapaorigem.webp`; scope `REGIONS_7_12_ONLY`. |
| **QA_RUNTIME** | QA ON/OFF com paridade aprovada; 5 colliders de handoff mantidos. |
| **EVIDÊNCIA** | Headless PASS; gameplay 30s PASS em ambos; print 1600×900 PASS em ambos; scope guard PASS. |
| **LUZES R12** | 11 / máximo 16 |
| **NEXT_ACTION_IMMEDIATE** | CP-D2-368 — empacotar com SHA-256, sincronizar Git e iniciar novo passe de continuidade R7–R12. |
| **WAIT_ALLOWED** | `false` |
