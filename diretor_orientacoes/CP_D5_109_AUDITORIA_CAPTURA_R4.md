# CP-D5-109 — Auditoria de prontidão de captura R4

## Resultado

Foi solicitada captura interna de `R4LivingForestPreview.tscn` durante uma sessão QA de 36 segundos. A telemetria técnica passou: 3 ciclos livres, 12 eventos de grounding, 2 cervos e ausência de portal ou parede vegetal. O renderer headless não disponibilizou uma imagem válida.

| Verificação | Resultado |
|---|---|
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| Snapshot solicitado | `qa_evidence_dev5_r4_cp109/r4_cp109.png` |
| Snapshot | Indisponível (`snapshot_unavailable=headless_image`) |
| Grounding | 12 instâncias |
| Rota | 3 ciclos `clear=true` |
| Distância fauna mínima | 20,42 m |
| Portal/parede vegetal | Ausentes |
| Erros de script/parse | 0 |

A captura visual oficial de R4 permanece pendente. A execução não promove nem rejeita artisticamente o candidato; apenas confirma que o fallback headless é seguro e que os contratos técnicos continuam válidos. O log está em `CP-D5-109_R4_CAPTURE_AUDIT_RUNTIME.log`.
