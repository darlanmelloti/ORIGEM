# CP-D2-208 — Continuidade física R7→R8

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | R7 Vila Elevada → R8 Observatório |
| **STATUS_CODE** | REJECTED_VISUAL — a execução técnica passou, mas o print continua a mostrar sobretudo terreno/horizonte; o sujeito visual e o handoff não estão suficientemente legíveis |
| **TAREFA_EM_EXECUCAO_AGORA** | Corrigir a apresentação QA do segmento R7→R8 sem substituir a geometria real nem criar coordenadas concorrentes |
| **ESCOPO** | Dev2: Regiões 7–12; apenas camada QA, autoridade cartográfica e spawn de validação partilhado |
| **NEXT_ACTION_IMMEDIATE** | Criar um enquadramento QA de aproximação que mostre simultaneamente o caminho R7, o Observatório R8 e a etiqueta de handoff, mantendo uma captura de gameplay real separada para a travessia |

O contrato `CartographicAnchors.continuity_7_to_8()` foi criado a partir das âncoras existentes. A linha QA R7→R8, as duas fronteiras R6→R7/R7→R8, o spawn real em `(128.0, 10.66528, 332.0)` e a instrumentação de runtime estão activos. O parser/runtime, gameplay de 30 segundos, print 1600×900, inventário e scope guard passaram tecnicamente.

A avaliação visual não é aceite: o print não torna o Observatório e os labels suficientemente legíveis. Não se declara `PASSED` com base apenas no log. As Regiões 1–6 permanecem sem alterações de geometria.

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay | 30 segundos presentes |
| Print | 1600×900 presente, visualmente rejeitado |
| MAP_MIRROR | 6 marcadores; fronteiras R6→R7 e R7→R8 activas |
| Inventário | 1701 meshes; 138 OmniLight3D; 140 StaticBody3D |
| Handoffs R9→R10→R11→R12 | 5 colliders CPD2007 |
| Luzes Região 12 | 11, máximo 16 |
| Scope guard | PASS — Regiões 7–12 |

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `eb6ef3a21eaeb6efe5fc8a626a5b6abb547ea9a04e736ebda875f48c8e64b798` |
| `print-1600x900.jpg` | `5a1c0e3636a78a3a0dd5743f85c0f2658e70538ca0dc5626d44ed6de96c9dacf` |
| `gameplay.log` | `792ab003dfb539a20b8c27abb6a4fbea704eeb1c687271003623197ccc108a56` |

A rejeição dispara imediatamente o próximo passe de composição QA; não encerra a produção.
