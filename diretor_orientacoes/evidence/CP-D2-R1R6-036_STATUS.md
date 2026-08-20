# CP-D2-R1R6-036 — Continuidade de câmara R8 → R9

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R8→R9
- **RESPONSAVEL**: Dev2 — QA; Dev3 raccord; Dev4 validação; Dev5/Dev6 suporte de ambiente
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Separar os rótulos Observatório e Trilha da Montanha e reforçar a leitura do handoff R8→R9
- **NEXT_ACTION_IMMEDIATE**: Ajustar offsets tipográficos e recuar ligeiramente a câmara no capturador R8→R9; repetir print 1600×900 e gameplay 30s
- **TARGET_REGION**: R8→R9
- **DEADLINE_PROXIMO_PUSH**: 2026-08-20T12:22:30+01:00

O QA headless de Godot 4.7.1 passou sem erros, com dinâmica R8R9 aprovada. A captura mostra os dois marcos e o handoff, mas `R9 TRILHA DA MONTANHA` e `R8 OBSERVATÓRIO` ficaram próximos demais no enquadramento. O critério visual é, portanto, rejeitado apenas para correcção de composição; a continuidade técnica permanece válida.

O escopo continua protegido: R1–R6 permanecem read-only do Dev1 e R7–R12 permanecem sob Dev2. Não houve alteração de geometria de produção. O orçamento de luzes segue dentro do limite de 16.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: REJECTED_VISUAL
- **NEXT_ACTION_IMMEDIATE**: Criar CP-D2-R1R6-037 com offsets separados para R8/R9 e recapturar a travessia.
- **TARGET_REGION**: R8→R9
- **DEADLINE_NEXT_PUSH**: 2026-08-20T12:22:30+01:00
