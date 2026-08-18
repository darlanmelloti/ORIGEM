# CP-D2-211 — Builder real do Observatório R8

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | R8 Observatório |
| **STATUS_CODE** | REJECTED_VISUAL — a massa vertical real foi integrada no `ObservatorioDaOrion` e aparece apoiada, mas ainda lê como afloramento isolado, não como Observatório cartográfico |
| **TAREFA_EM_EXECUCAO_AGORA** | Iniciar CP-D2-212 para reforçar a silhueta apoiada do Observatório com coroamento orgânico e contraste controlado |
| **ESCOPO** | Dev2: Regiões 7–12; sem alterações às Regiões 1–6 |
| **NEXT_ACTION_IMMEDIATE** | Ajustar apenas a escala/posição relativa da massa vertical, coroas e olho orgânico existentes no builder R8, preservando a âncora `(194, 404)`, o handoff e o orçamento de luzes |

A execução técnica passou no mundo integrado: `ORIGEM_REGION8_OBSERVATORY_READY (194.0, 31.29847, 404.0)`, parser/headless, gameplay de 30 segundos, print 1600×900, inventário e scope guard. A massa `MassaVerticalApoiadaObservatorioR8` deixou de ser apenas um beacon QA, mas a avaliação visual permanece rejeitada porque a composição ainda não comunica um marco arquitectónico observatório.

| Verificação | Resultado |
|---|---|
| Parser/runtime Godot 4.7.1 | PASS no mundo integrado |
| Gameplay | 30 segundos presentes |
| Print | 1600×900 presente; visualmente rejeitado |
| Inventário | 1705 meshes; 138 OmniLight3D; 140 StaticBody3D |
| Handoffs | 5 colliders CPD2007 |
| Luzes Região 12 | 11, máximo 16 |
| Scope guard | PASS — Regiões 7–12 |

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `668d127043658bb86aa5957ec5f4ee080745e0be6389b4b0a69983678ffbe3c6` |
| `print-1600x900.jpg` | `c02c7dca77ff00563ea9e52df37fb92036edf699b5dcb7c748d87fd20066802c` |
| `gameplay.log` | `a16afc2ad38b739e224a8ef81a19942bea4d55946051015d0fe3d95e4bd289f5` |

A rejeição activa imediatamente o CP-D2-212; não encerra a produção.
