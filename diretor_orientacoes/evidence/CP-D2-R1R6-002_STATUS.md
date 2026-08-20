# CP-D2-R1R6-002 — Grounding Casa Voss → Estrada do Rio → Arco

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R3 dentro do bloco R1–R6
- **RESPONSAVEL**: Dev2 — contrato QA e coordenação; Dev1 permanece em standby
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Corrigir a rota de captura para entrar no gameplay real e enquadrar os marcadores de grounding no percurso Casa Voss → Estrada do Rio → Arco
- **NEXT_ACTION_IMMEDIATE**: Criar uma cena QA reversível com câmara dedicada, marcadores temporários e visibilidade dos três marcos; executar print 1600×900 e gameplay de 30 segundos
- **TARGET_REGION**: Regiões 1–3, sem alterar geometria proprietária das Regiões 1–6
- **DEADLINE_PROXIMO_PUSH**: 2026-08-20T02:12:30+01:00

## Resultado técnico comprovado

`validation/CartographicR1R6GroundingQA.gd` foi executado em Godot 4.7.1. O contrato confirmou três marcadores derivados de `CartographicAnchors.gd`, com offsets verticais explícitos de `0.000`, `0.025` e `0.035`, ordem cartográfica preservada e corredor R1→R3 com comprimento `40.344` unidades.

A política `floating_markers=FORBIDDEN` foi emitida pelo teste. Os marcadores são QA-only e não autorizam a criação de uma segunda autoridade espacial, nem substituem o terreno ou os colliders do Dev1.

## Critério ainda não satisfeito

O QA headless está aprovado, mas o ciclo permanece `REJECTED_VISUAL` porque o print anterior ainda ficou no prólogo da Casa Voss. O próximo passo é uma cena de validação reversível com câmara própria, para separar a comprovação cartográfica da entrada sintética e evitar uma falsa aprovação do percurso.

## Coordenação

Dev5 deve usar os três pontos para grounding, silhuetas e objectos modulares. Dev6 deve manter água, céu, vegetação e materiais sem aumentar o orçamento de luzes. Dev3 deve definir sujeito, eixo e profundidade da câmara. Dev4 deve validar parser, colisores, LOD, inventário de luzes e pacote.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: REJECTED_VISUAL
- **NEXT_ACTION_IMMEDIATE**: Cena QA reversível com câmara dedicada e captura visual R1–R3.
- **TARGET_REGION**: R1–R3
- **DEADLINE_NEXT_PUSH**: 2026-08-20T02:12:30+01:00
