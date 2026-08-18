# CP-D2-203 — Região 12 — Contraste da Massa Vertical

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Região 12 — Hub Temporal / Cúpula Final |
| **STATUS_CODE** | PASSED — técnico e visual dentro do critério deste passe |
| **TAREFA_EM_EXECUCAO_AGORA** | Preparar publicação do CP-D2-203 e iniciar a auditoria de continuidade do handoff R11→R12 |
| **ESCOPO** | Apenas Regiões 7–12; Regiões 1–6 intactas |
| **NEXT_ACTION_IMMEDIATE** | Auditar o enquadramento do handoff R11→R12 e preservar a massa vertical apoiada enquanto se melhora a leitura do percurso |

O CP-D2-203 escureceu a massa vertical orgânica apoiada e reforçou a emissão violeta do núcleo temporal encastrado, sem adicionar geometria lateral. O resultado mantém uma única massa vertical, base pétrea e núcleo contrastado.

| Verificação | Resultado |
|---|---|
| Parser/runtime Godot 4.7.1 | PASS |
| Gameplay | 30 segundos presentes |
| Print | 1600×900 |
| OmniLight3D | `11`, máximo `16` |
| `ColisaoHandoffCubeR11` | presente |
| `ColisaoHandoffSoleiraR12` | presente |
| `ColisaoHandoffHubR12` | presente |
| Scope guard | PASS — Regiões 7–12 |

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `87b85c221c750b50f0202dbe46cfbad8aaaa0281d0ccd9bcc1078bbe7c01bd22` |
| `print-1600x900.jpg` | `5eafdb2d8c34674596cd8a95174b46a0296733b1c13e4ae9919e2e4f00dbd4c8` |
| `CP-D2-203-R7-R12-executable.zip` | `2abe250cc97192525509329c2608c34b6dc0aafeb52ff88023e3f8e6671888df` |
| Branch pública Dev2 | `feature/dev2-mountain-canyon`, HEAD `bf8d10ab1a306b03acdc4bf6aadcc64440d3510d` |

A fila não é encerrada pelo estado `PASSED`; o próximo passe começa pela auditoria do enquadramento de continuidade R11→R12, mantendo o limite de luzes e a fronteira regional.
