# CP-D2-R1R6-004 — Travessia física QA R1 → R2 → R3

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R3 — Casa Voss → Estrada do Rio → Arco das Ruínas
- **RESPONSAVEL**: Dev2 — coordenação QA e handoffs
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Preparar captura dinâmica da câmara ao longo do corredor físico, porque o contrato headless passou mas a evidência visual actual é uma câmara QA estática
- **NEXT_ACTION_IMMEDIATE**: Criar `CartographicR1R3TraversalCaptureQA.gd` com câmara a interpolar R1→R2→R3 durante 30 segundos; preservar os marcadores grounded e o scope guard
- **TARGET_REGION**: R1–R3
- **DEADLINE_PROXIMO_PUSH**: 2026-08-20T02:32:30+01:00

## Resultado técnico comprovado

`validation/CartographicR1R3TraversalQA.gd` foi executado em Godot 4.7.1 com 31 amostras de percurso. Os handoffs medidos são R1→R2 `4.045` unidades e R2→R3 `36.300` unidades; a rota total é `40.345` unidades. A amostragem mantém o jogador no plano grounded e a desviação máxima do corredor é `0.000`, dentro do limite `4.000`. O `PHYSICAL_SCOPE_GUARD=PASS` confirma que nenhuma geometria proprietária do Dev1 foi modificada.

A cena visual dedicada do CP-D2-R1R6-003 continua a ser a referência gráfica do corredor e dos marcos. Contudo, este ciclo ainda não é aceite visualmente porque não houve movimento de câmara durante os 30 segundos. O estado `REJECTED_VISUAL` activa imediatamente a próxima implementação e não encerra a produção.

## Coordenação

Dev3 deve usar a interpolação R1→R2→R3 para a câmara de raccord. Dev4 deve auditar colisores reais quando o Dev1 disponibilizar o bloco de produção. Dev5 e Dev6 permanecem limitados aos contratos QA, grounding e ambiente, sem reescrever os módulos de Regiões 1–6.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: REJECTED_VISUAL
- **NEXT_ACTION_IMMEDIATE**: Implementar captura dinâmica de 30 segundos R1→R2→R3.
- **TARGET_REGION**: R1–R3
- **DEADLINE_NEXT_PUSH**: 2026-08-20T02:32:30+01:00
