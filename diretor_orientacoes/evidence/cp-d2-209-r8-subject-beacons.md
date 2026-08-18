# CP-D2-209 — Subject beacons R7/R8

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | R7 Vila Elevada → R8 Observatório |
| **STATUS_CODE** | REJECTED_VISUAL — beacon R8 visível, mas o quadro ainda é dominado por terreno/horizonte e não prova a leitura cinematográfica do Observatório |
| **TAREFA_EM_EXECUCAO_AGORA** | Iniciar CP-D2-210 para criar um enquadramento QA de aproximação com o sujeito R8 e o handoff R7→R8 no mesmo quadro |
| **ESCOPO** | Dev2: Regiões 7–12; beacons e enquadramento apenas no modo QA; Regiões 1–6 intactas |
| **NEXT_ACTION_IMMEDIATE** | Implementar uma câmara QA de aproximação no ponto R7, dirigida ao volume real `ObservatorioDaOrion` e ao corredor R7→R8, sem alterar a câmara normal do jogo |

O CP-D2-209 adicionou apenas marcadores temporários QA apoiados nas âncoras cartográficas R7/R8. O runtime confirmou spawn em `(128.0, 9.9575, 332.0)`, as duas fronteiras cartográficas, seis marcadores, cinco colliders CPD2007 e orçamento R12 de 11 luzes. O beacon ciano de R8 aparece na captura, mas não é suficiente para aceitar visualmente o segmento.

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay | 30 segundos presentes |
| Print | 1600×900 presente; visualmente rejeitado |
| Inventário | 1703 meshes; 138 OmniLight3D; 140 StaticBody3D |
| Scope guard | PASS — Regiões 7–12 |
| Região 12 | 11 luzes activas, máximo 16 |

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `39463cfaad1cfc4329d3f3fc1c3c7ace8e93a62643234d376453a49408e7e98b` |
| `print-1600x900.jpg` | `c683bc78ec0a586875e80647e1b508eb889916c75608e32b41463c8082b2a78e` |
| `gameplay.log` | `fd95e97c66e597b99b0ca2ac974b403861f5fa2bcd6c002096984fba243a5c58` |

A rejeição visual activa imediatamente o CP-D2-210; não é um encerramento da produção.
