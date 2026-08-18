# CP-D2-207 — Validação física QA R6→R7

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | R6 Ruínas Submersas → R7 Vila Elevada |
| **STATUS_CODE** | PASSED — spawn QA, handoff e percurso inicial comprovados no mundo integrado |
| **TAREFA_EM_EXECUCAO_AGORA** | Abrir o próximo segmento de continuidade R7→R8, consumindo a autoridade cartográfica existente |
| **ESCOPO** | Dev2: Regiões 7–12; alteração partilhada apenas em QA/main; Regiões 1–6 intactas |
| **NEXT_ACTION_IMMEDIATE** | Validar R7 Vila Elevada → R8 Observatório com entrada/saída, orientação de câmara e gameplay real de 30 segundos |

A rota QA `MAP_MIRROR_VALIDATION_R6_R7_BOUNDARY` inicializa Elias nas Ruínas Submersas, activa a mensagem de handoff R6→R7 e mantém a linha do corredor derivada de `CartographicAnchors.continuity_6_to_7()`. O print real confirma a leitura de `QA R06 → R07 | HANDOFF BOUNDARY` e `R07 Vila Elevada [PHYSICAL_VALIDATED]` sobre o percurso.

| Verificação | Resultado |
|---|---|
| Parser/runtime Godot 4.7.1 | PASS no mundo integrado |
| Gameplay real | 30 segundos presentes |
| Print | 1600×900 |
| MAP_MIRROR | 6 marcadores + fronteira R6→R7 |
| Inventário | 1699 meshes; 138 OmniLight3D; 140 StaticBody3D |
| Handoffs R9→R10→R11→R12 | 5 colliders CPD2007 detectados |
| Luzes Região 12 | 11, máximo 16 |
| Scope guard | PASS — Regiões 7–12 |
| Regiões 1–6 | Sem geometria alterada; apenas spawn QA partilhado |

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `8f7222a4f6bbcf8ba97f6f63eb2b1ee1684b598db98e36aa66f1e3507aa9a7f8` |
| `print-1600x900.jpg` | `c1c24123ac88b70fc275f5dd0ea8776ce61c6adc63ec89e84cf53cbbb147e3d1` |
| `gameplay.log` | `167c664aed77389f5a8e15d032de54e74007a01aef4a87372dbffb45e8755314` |

O estado `PASSED` fecha apenas o início da travessia R6→R7. O ciclo continua imediatamente com a validação R7→R8.
