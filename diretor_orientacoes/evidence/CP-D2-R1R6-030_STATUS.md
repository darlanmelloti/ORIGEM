# CP-D2-R1R6-030 — Captura grounding e wayfinding R1 → R6

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1→R6 grounding and wayfinding QA
- **RESPONSAVEL**: Dev2 — QA; Dev3 raccord; Dev4 validação; Dev5/Dev6 suporte de ambiente
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Refinar a legibilidade dos primeiros marcadores Casa Voss → Estrada do Rio
- **NEXT_ACTION_IMMEDIATE**: Aplicar composição de rótulos em painel próximo para R1/R2 e manter a rota completa R2→R6 num segundo enquadramento QA, sem editar o núcleo do Dev1
- **TARGET_REGION**: R1→R6
- **DEADLINE_PROXIMO_PUSH**: 2026-08-20T10:22:30+01:00

O QA headless passou em Godot 4.7.1. Foram confirmados seis marcadores grounded em `y=0.18`, cinco segmentos de handoff, rota total `374.677`, prioridade de destino de R1 a R6, política de marcadores flutuantes proibidos, guarda read-only do Dev1 e limite de 16 luzes.

A evidência de 1600×900 e o gameplay de 30 segundos mostram o percurso completo e todos os seis marcos, mas a composição panorâmica ainda deixa R1 Casa Voss e R2 Estrada do Rio próximos demais para uma leitura cinematográfica limpa. O critério visual permanece rejeitado; o próximo ciclo é uma correcção QA-only, não uma pausa.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: REJECTED_VISUAL
- **NEXT_ACTION_IMMEDIATE**: Criar close-up R1/R2 acoplado ao corredor R2→R6 e recapturar print 1600×900 + gameplay 30s.
- **TARGET_REGION**: R1→R6
- **DEADLINE_NEXT_PUSH**: 2026-08-20T10:22:30+01:00
