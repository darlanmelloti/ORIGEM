# CP-D2-210 — Enquadramento QA de aproximação R8

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | R8 Observatório, handoff R7→R8 |
| **STATUS_CODE** | REJECTED_VISUAL — a câmara QA foi aproximada e o beacon R8 permanece visível, mas a captura continua dominada por terreno e horizonte; não há massa arquitectónica suficiente para representar o Observatório |
| **TAREFA_EM_EXECUCAO_AGORA** | Iniciar CP-D2-211 para auditar o builder real `ObservatorioDaOrion` e alinhar a massa visual apoiada à âncora R8 |
| **ESCOPO** | Dev2: Regiões 7–12; sem alterações às Regiões 1–6 |
| **NEXT_ACTION_IMMEDIATE** | Inspeccionar e reforçar o builder existente do Observatório R8 na posição da âncora, usando malhas orgânicas apoiadas e mantendo o orçamento de luzes; não adicionar apenas proxies QA |

A execução técnica passou: spawn QA `(170.0, 11.79867, 382.0)`, parser de cena integrado, gameplay de 30 segundos, print 1600×900, MAP_MIRROR, handoffs CPD2007 e scope guard. O relatório não declara aceitação visual. O beacon QA é diagnóstico, não substituto da geometria real.

| Verificação | Resultado |
|---|---|
| Parser/runtime Godot 4.7.1 | PASS no mundo integrado |
| Gameplay | 30 segundos presentes |
| Print | 1600×900 presente; visualmente rejeitado |
| MAP_MIRROR | 6 marcadores; R6→R7 e R7→R8 activos |
| Inventário | 1703 meshes; 138 OmniLight3D; 140 StaticBody3D |
| Handoffs | 5 colliders CPD2007 |
| Luzes Região 12 | 11, máximo 16 |
| Scope guard | PASS — Regiões 7–12 |

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `b001393ff7d918ad0c38c393cbe55a2460d32b9b0fb376c44761fdd5e6a70b0c` |
| `print-1600x900.jpg` | `a25c19e60918c283cd334c2b7e4b6b7aad8e5844668be952c815811258101de6` |
| `gameplay.log` | `1793a2a6749c06d23597a29ebc93830fced37c69ce4d435607db9ae88caa4227` |

A rejeição activa imediatamente o CP-D2-211; não encerra a produção.
