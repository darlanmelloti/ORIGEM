# CP-D2-202 — Região 12 — Orçamento e Massa Vertical

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Região 12 — Hub Temporal / Cúpula Final |
| **STATUS_CODE** | PASSED — critérios técnicos e materiais obrigatórios satisfeitos |
| **TAREFA_EM_EXECUCAO_AGORA** | Preparar sincronização do checkout completo R7–R12 e auditoria do pacote público |
| **ESCOPO_BLOQUEADO** | Regiões 1–6 permanecem intocadas |
| **DEADLINE_PROXIMO_PUSH** | 2026-08-18 23:45 GMT+1 |

A correcção CP-D2-202 foi executada no projecto Godot local completo das Regiões 7–12 e não apenas no script de evidência. A Região 12 passou de 35 para **11 OmniLight3D activos**, abaixo do limite obrigatório de 16. A composição capturada foi substituída por uma **única massa vertical orgânica**, com coroamento compacto, apoiada na plataforma R12; as alas laterais foram removidas do harness visual. Os handoffs físicos de R11/R12 continuam presentes e o scope guard mantém as Regiões 1–6 fora da alteração.

| Verificação | Resultado |
|---|---|
| Parser/runtime Godot 4.7.1 | PASS |
| Gameplay | 30 segundos presentes |
| Print | 1600×900 |
| OmniLight3D | `11`, máximo `16` |
| Static bodies | `14` |
| `ColisaoHandoffCubeR11` | presente |
| `ColisaoHandoffSoleiraR12` | presente |
| `ColisaoHandoffHubR12` | presente |
| Scope guard | PASS — Regiões 7–12 |

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `9e8e8f15582d2181cd9ec15b56764aaf1df980e1b94e5132af712ec1c7c72bd9` |
| `print-1600x900.jpg` | `5af2065498fb2fcc6dd188038f879b9bdce49c2a51c3995d2dda91c64c2cfadb` |
| `CP-D2-202-R7-R12-complete.zip` | `da9f5ec13e004d09bc3bbc8da9da978f0fe8aa77ff727e51223d8b0bf2222d12` |
| Branch pública Dev2 | `feature/dev2-mountain-canyon`, HEAD `6d7afde8b0bf94266b7563b9dee9ca2ee72e52ba` |

## NEXT_ACTION_IMMEDIATE

Publicar o checkout completo R7–R12 numa branch Dev2 verificável, incluindo `project.godot`, níveis, cenas, assets necessários, scripts de QA e a evidência CP-D2-202; excluir apenas `.git`, `.godot`, caches e checkpoints históricos volumosos. Depois, executar a auditoria final do conteúdo do ZIP e calcular o SHA-256 antes da entrega.
