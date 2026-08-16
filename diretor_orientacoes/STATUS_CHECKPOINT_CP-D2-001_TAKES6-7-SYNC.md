# STATUS_CHECKPOINT_CP-D2-001 — Sincronização dos Takes 6–7

## Delegação actual

A delegação publicada em `EQUIPA_FUNCOES_E_DELEGACAO.md` atribui ao Dev2 as Regiões 7–12 e define como tarefa imediata a sincronização do código existente dos Takes 6 e 7 na branch `feature/dev2-mountain-canyon`.

## Estado do ciclo

| Critério | Estado | Evidência |
|---|---:|---|
| Código dos Takes 6–7 presente na branch Dev2 | PASS | `Takes5to7Director.gd`, `HighlandRegion.gd`, `TempleLevel.gd`, `OrionDestinationRegion.gd` |
| QA headless Godot 4.7.1 | PASS | logs dedicados Take 6 e Take 7 |
| Gameplay Take 6 ~30s | PASS técnico | `cp-d2-001-take6-variation-pass/gameplay-30s.mp4` |
| Gameplay Take 7 ~30s | PASS técnico | `cp-d2-001-take7-variation-pass/gameplay-30s.mp4` |
| Print Take 6 1600×900 | PASS técnico | `cp-d2-001-take6-variation-pass/print-1600x900.jpg` |
| Print Take 7 1600×900 | PASS técnico | `cp-d2-001-take7-variation-pass/print-1600x900.jpg` |
| BoxMesh azul do núcleo | CORRIGIDO | substituído por assembleia orgânica emissiva CC0 |
| Fronteira Regiões 1–6 | PASS | nenhum ficheiro proibido alterado neste incremento |
| Avaliação visual | REJECTED_VISUAL | silhuetas ainda low-poly e requerem passe futuro de assets/materiais |

## Artefacto

- ZIP: `validation/checkpoints/CP-D2-001_Takes6-7-Sync/CP-D2-001_Takes6-7-Sync.zip`
- SHA-256: `f2afc9b4773892f6a5003aa2238fc790dd844a8d517b2309099256b26e28fda8`
- Commit: `c50b0df6847154414bd3fe7c211321e3f7c2e292`

## Hashes da evidência

| Evidência | SHA-256 |
|---|---|
| Take 6 gameplay | `d854786b7edd9c2fbb9bd37b862c0ddfaf2a59ea2473f1783785cfc6ca56a4d4` |
| Take 6 print | `92d98f3ffcc26ccdd3adce330d2b90b687c30ebaf15fe9e69e2c4e74f28218c9` |
| Take 7 gameplay | `ad8b8949f075dea1729701a97c07a123ba6e3388195c5eadefac02a8a568520f` |
| Take 7 print | `637efcf69ed2e379c57f4c64033dbb11fa20dbca2b416ad04ceb069a11adb46e` |

## Máquina de estado

**STATUS_CODE:** `REJECTED_VISUAL`  
**NEXT_ACTION_IMMEDIATE:** manter a sincronização publicada e iniciar o próximo passe Dev2 de variação de assets/materiais nas colunas dos Takes 6–7, sem tocar Regiões 1–6.  
**TARGET_REGION:** Regiões 10–11 / Takes 6–7  
**DEADLINE_NEXT_PUSH:** próximo ciclo de 30 minutos.
