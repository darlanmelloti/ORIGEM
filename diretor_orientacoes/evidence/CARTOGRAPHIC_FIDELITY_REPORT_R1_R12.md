# ORIGEM — Cartographic Fidelity Report R1→R12

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1→R12 integrado
- **STATUS_CODE**: PASSED_WITH_BOUNDARY_PENDING
- **TAREFA_EM_EXECUCAO_AGORA**: Consolidar o espelho QA do mapa cartográfico e manter a validação dos handoffs jogáveis
- **NEXT_ACTION_IMMEDIATE**: Abrir o próximo ciclo de continuidade física sobre o boundary R6→R7 e repetir o panorama após integração de geometria jogável
- **TARGET_REGION**: R6→R7, seguido do percurso R7→R12
- **DEADLINE_PROXIMO_PUSH**: 2026-08-20T15:12:30+01:00

## 1. Resultado executivo

A auditoria integrada foi executada em Godot 4.7.1 no modo headless e confirmou **12 regiões cartográficas carregadas a partir de `CartographicAnchors.gd`**, 12 entradas no espelho de mapa QA-only, handoffs R1→R12 registados, orçamento máximo de 16 luzes dinâmicas e a fronteira operacional entre Dev1 e Dev2. O panorama corrigido foi capturado em 1600×900 e acompanhado por gameplay de 30 segundos.

O resultado visual é aceite como **evidência de estrutura cartográfica**, não como substituto da geometria final de produção. Os marcadores e linhas pertencem exclusivamente à camada de auditoria e não devem entrar no pacote final do jogo.

## 2. Autoridade espacial

| Região | Âncora | Posição mundial auditada | Posição no mapa | Proprietário operacional |
|---|---|---:|---:|---|
| R1 | Casa Voss | (-22.000, 8.000) | (80, 452) | Dev1 — standby/read-only |
| R2 | Estrada do Rio | (-21.400, 12.000) | (234, 462) | Dev1 — standby/read-only |
| R3 | Arco das Ruínas | (-16.741, 48.000) | (362, 463) | Dev1 — standby/read-only |
| R4 | Floresta Densa | (-9.000, 116.000) | (334, 244) | Dev1 — standby/read-only |
| R5 | Acampamento Majestic | (-88.000, 178.000) | (187, 258) | Dev1 — standby/read-only |
| R6 | Ruínas Submersas | (60.000, 252.000) | (408, 351) | Dev1 — standby/read-only |
| R7 | Vila Elevada | (140.000, 352.000) | (542, 235) | Dev2 |
| R8 | Observatório | (194.000, 404.000) | (560, 165) | Dev2 |
| R9 | Trilha da Montanha | (174.000, 414.000) | (440, 137) | Dev2 |
| R10 | Caverna do Orion | (-116.000, 548.000) | (466, 78) | Dev2 |
| R11 | Câmara do Orion Cube | (-116.000, 562.000) | (514, 33) | Dev2 |
| R12 | Hub Temporal | (164.000, 210.000) | (564, 497) | Dev2 |

## 3. Handoffs e percurso

O percurso auditado totaliza **1383.311 unidades**. As distâncias consecutivas registadas foram: R1→R2 4.045; R2→R3 36.300; R3→R4 68.439; R4→R5 100.424; R5→R6 165.469; R6→R7 128.062; R7→R8 74.967; R8→R9 22.361; R9→R10 319.462; R10→R11 14.000; R11→R12 449.782. Todos os handoffs foram marcados com `grounded_y=0.15`.

A auditoria deixou explicitamente R6→R7 como `QA_BOUNDARY_PENDING`. Isso não interrompe a produção: define o próximo alvo físico para o ciclo de integração, sem alterar a propriedade de R1–R6 nem duplicar coordenadas.

## 4. Evidência técnica e visual

| Evidência | Resultado |
|---|---|
| Godot 4.7.1 headless integrado | PASS |
| 12 regiões carregadas | PASS |
| 12 entradas de espelho cartográfico | PASS |
| Handoffs R1→R12 registados | PASS |
| Scope guard Dev1/Dev2 | PASS |
| Limite de luzes dinâmicas | PASS — máximo contratual 16 |
| Panorama QA integrado | Capturado em 1600×900 |
| Gameplay integrado | Capturado durante 30 segundos |
| R11→R12 temporal hub | PASS no CP-D2-R1R6-043, seis luzes dinâmicas |

A evidência de R11→R12 foi consolidada no `CP-D2-R1R6-043`, com núcleo temporal violeta vertical, rótulos legíveis, corredor de handoff e seis luzes dinâmicas. A captura integrada permanece QA-only.

## 5. Estado de máquina

- **STATUS_CODE**: PASSED_WITH_BOUNDARY_PENDING
- **NEXT_ACTION_IMMEDIATE**: Validar fisicamente R6→R7 no mundo integrado e repetir o panorama após o handoff atravessável
- **TARGET_REGION**: R6→R7
- **DEADLINE_NEXT_PUSH**: 2026-08-20T15:12:30+01:00

## 6. Evidências anexas

O pacote desta entrega inclui o auditor integrado, o capturador de panorama corrigido, o print 1600×900, o gameplay de 30 segundos, os logs headless, o inventário de hashes e os relatórios de estado CP-D2-R1R6-039 a CP-D2-R1R6-043.
