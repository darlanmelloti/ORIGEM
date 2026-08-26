# ORIGEM — Resumo de Validação Dev7

| Verificação | Resultado | Evidência |
|---|---|---|
| Parser Godot 4.7.1 | **Aprovado** | Incluído nos gates R2–R6 e nas capturas regionais. |
| `git diff --check` | **Aprovado** | Executado após a limpeza de whitespace no relatório. |
| Matriz de seis capturas 1600×900 | **Aprovada** | Seis ficheiros `*_postload.png` em `reports/dev7/visual_playable_physics_baseline_001/`. |
| Sem ecrã de arranque na matriz aceite | **Aprovado** | Estabilização runtime de 60 s após spawn; a primeira tentativa de 12 s foi descartada e documentada. |
| Gate R2 | **Aprovado** | `gates/R2.log` contém `[GATE:R2] PASS`. |
| Gate R3 | **Aprovado** | `gates/R3.log` contém `[GATE:R3] PASS`. |
| Gate R4 | **Aprovado** | `gates/R4.log` contém `[GATE:R4] PASS`. |
| Gate R5 | **Aprovado** | `gates/R5.log` contém `[GATE:R5] PASS`. |
| Gate R6 | **Aprovado** | `gates/R6.log` contém `[GATE:R6] PASS`. |
| Auditoria global de luz | **Aprovada** | `global_visible_lights=59`, `simultaneous_camera_lights=1`, limite 16; sem exceder o orçamento. |
| Orçamento R6 protegido | **Aprovado** | Gate R6 confirmou exatamente quatro luzes R6. |
| Grounding R1/R2, R4/R5, R4/R6, R5/R6 e chegada R6 | **Aprovado** | Cinco resultados `QA-GROUND-01` com 180 frames em chão. |
| Grounding `arch_to_forest` | **Falhou — risco localizado** | `QA-GROUND-01`: 0 frames em chão. `CP_CARTO80_FLOOR`: `no_chao=false` até 6,0 s. |
| Transição de estado | **Aprovada** | `QA-STATE-01` concluiu entrada Orion em 33 s, preservando saúde e stamina. |
| Alteração de produção | **Nenhuma** | Apenas `reports/dev7/` e `qa/dev7/` são preparados para commit. |

> Os gates contratuais aprovados não substituem a prova física runtime falhada em `arch_to_forest`. A baseline é válida como diagnóstico e conjunto de evidências, mas **não autoriza** a implementação visual de R4 enquanto `DEV4-R4-ARCH-FOREST-GROUNDING-RECOVERY` não passar ambas as sondas físicas.
