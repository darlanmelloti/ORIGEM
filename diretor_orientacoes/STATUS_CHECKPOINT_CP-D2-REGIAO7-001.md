# STATUS_CHECKPOINT_CP-D2-REGIAO7-001

## Região auditada

**Região 7 — Vila Elevada**, iniciada no handoff `Region7TransitionGate` → `SpawnRegiao7_Dev2_HandoffPoint` em `Vector3(140, y, 352)`.

## Estado actual do ciclo

| Verificação | Estado | Evidência |
|---|---:|---|
| HighlandRegion.gd no escopo Dev2 | PASS | `levels/HighlandRegion.gd` |
| Regiões 1–6 alteradas | PASS | fronteira verificada antes do commit |
| Parser/editor headless Godot 4.7.1 | PASS | `cp-d2-region7-vila-elevada-grounded/headless.log` |
| Gameplay integrado ~30s | PASS técnico | `cp-d2-region7-vila-elevada-exposure-pass/gameplay-30s.mp4` |
| Print 1600×900 | PASS técnico | `cp-d2-region7-vila-elevada-exposure-pass/print-1600x900.jpg` |
| Vila visualmente distinguível no frame | REJECTED_VISUAL | estruturas CC0 ainda pequenas/escuras |
| Orçamento de luzes | PASS | luzes da Vila ≤1.10 energia, alcance ≤10m; luzes de casas 1.10/6m |
| Estela de chegada e Area3D 2.5m | PASS | `EstelaChegadaRegiao7`, `EstelaChegadaRegiao7_Area` |

## Estado único activo

**STATUS_CODE:** `REJECTED_VISUAL`  
**NEXT_ACTION_IMMEDIATE:** aproximar e recompor a câmara dedicada sobre os bounds dos três grupos de casas, mantendo a base CC0 aterrada por `_height_at()` e sem alterar Regiões 1–6.  
**TARGET_REGION:** Região 7  
**DEADLINE_NEXT_PUSH:** próximo ciclo de 30 minutos.

## Artefacto reproduzível

- Pacote: `validation/checkpoints/CP-D2-REGIAO7-001/CP-D2-REGIAO7-001_VilaElevada_Validated.zip`
- SHA-256 do pacote: `854a0163b70149096d3db0ef70d7e2ccc31b244197f434d05ef2deb72327c916`
- Commit: `8e065066b27ed308131e0ba75f01a189dbd5a0e5`

## Hashes da evidência actual

- Gameplay 30s: `555c3eea3f50775832f320b186cbcb64f2e8807fef8091a688f3ec4540811ac0`
- Print 1600×900: `65ee7e9e4cf5b1c3c46be5923a301462a60fb25324dce6edba0071e5cac2ba8d`

O checkpoint é um marco técnico auditável com rejeição visual explícita; não representa aprovação estética final.
