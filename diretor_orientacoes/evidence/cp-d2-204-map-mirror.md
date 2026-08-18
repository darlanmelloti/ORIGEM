# CP-D2-204 — Contrato Cartográfico e MAP_MIRROR_VALIDATION

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Contrato Dev2 — Regiões 7–12 no mundo integrado `main.tscn` |
| **STATUS_CODE** | REJECTED_VISUAL — contrato e física aprovados; legibilidade visual dos marcadores ainda insuficiente |
| **TAREFA_EM_EXECUCAO_AGORA** | Reenquadrar a câmara QA e aumentar a separação/legibilidade dos marcadores sem alterar as coordenadas cartográficas |
| **ESCOPO** | Dev2: Regiões 7–12; Regiões 1–6 intactas |
| **NEXT_ACTION_IMMEDIATE** | Ajustar apenas o modo QA para que as seis âncoras, linhas de handoff e labels sejam legíveis numa captura 1600×900; depois abrir a validação de continuidade 6→7 |

O contrato cartográfico foi expandido directamente em `CartographicAnchors.gd`, sem criar um segundo conjunto de coordenadas. Cada região 7–12 agora expõe posição mundial derivada das constantes existentes, altitude fornecida pelo terreno, direcção de aproximação, handoff de entrada/saída, sujeito visual, posição no mapa e estado de validação.

`CartographicMirrorQA.gd` foi ligado a `scenes/main.tscn` como camada condicional. Só constrói marcadores, labels e segmentos quando `MAP_MIRROR_VALIDATION=1`; fora desse modo remove-se do mundo, não substitui geometria e não entra na apresentação final.

| Verificação | Resultado |
|---|---|
| Parser/runtime Godot 4.7.1 | PASS |
| MAP_MIRROR no `main.tscn` | PASS — 6 marcadores consumidos de `CartographicAnchors.gd` |
| Gameplay real | 30 segundos presentes |
| Print | 1600×900 |
| Inventário integrado | 1697 meshes; 138 OmniLight3D; 140 StaticBody3D |
| Handoffs físicos detectados | 5 colliders CPD2007 |
| Scope guard | PASS — Regiões 7–12 |
| Luzes Região 12 | 11, máximo 16 |

A captura confirma o mundo principal, o percurso físico e o espelho activo, mas os marcadores/labels não estão suficientemente legíveis à distância para aceitar o critério visual final. Por isso, o estado permanece `REJECTED_VISUAL` e o próximo passe começa imediatamente no modo QA, não na geometria regional.

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `63765cbdebd26a1fc9cbf475b5549b009dc706bcee467adbfd113bcc9ea680eb` |
| `print-1600x900.jpg` | `45fa9b0f29429a43931e14037c62b1d8e05fcc237f020337ed814ee3af6b7d0f` |
| `gameplay.log` | `6f5cab814997d8b5ad68d7eabb8e324eea122f3115a230e1d5dd29fa1e69b0ae` |

## Estado de continuidade

A validação 6→7 fica aberta como próxima fila operacional, mas só deve ser classificada como aceite depois do reenquadramento QA comprovar visualmente as seis âncoras e os seus corredores no mundo integrado.
