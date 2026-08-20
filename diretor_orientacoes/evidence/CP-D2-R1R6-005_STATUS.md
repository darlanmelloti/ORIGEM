# CP-D2-R1R6-005 — Captura dinâmica R1 → R2 → R3

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R3 — corredor Casa Voss → Estrada do Rio → Arco das Ruínas
- **RESPONSAVEL**: Dev2 — coordenação de continuidade; Dev3 acompanha raccord; Dev4 audita captura
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Corrigir o enquadramento dinâmico para manter os rótulos e os três marcos dentro do frame durante o movimento
- **NEXT_ACTION_IMMEDIATE**: Reduzir escala dos rótulos, aumentar o recuo da câmara e utilizar um alvo estabilizado no centro do corredor, repetindo gameplay de 30 segundos e print 1600×900
- **TARGET_REGION**: R1–R3
- **DEADLINE_PROXIMO_PUSH**: 2026-08-20T02:42:30+01:00

## Resultado técnico comprovado

`validation/CartographicR1R3TraversalCaptureQA.gd` foi executado em Godot 4.7.1 e produziu movimento de câmara sobre o corredor real entre as âncoras. O log confirma progresso de `R1` até `R2→R3`, com `CP-D2-R1R6-005_DYNAMIC_CAPTURE=PASS`. O gameplay de aproximadamente 30 segundos e o print 1600×900 foram gerados com hashes.

A evidência visual prova movimento, mas permanece `REJECTED_VISUAL` porque o frame final corta o rótulo de R2 e mostra R3 de forma demasiado dominante. A rejeição é um gatilho para refinar a câmara, não um encerramento do desenvolvimento.

## Segurança de fronteira

A cena é QA-only e herda a autoridade de `CartographicAnchors.gd`. Nenhum módulo de geometria proprietário das Regiões 1–6 foi alterado. Dev1 continua em standby; Dev7 e Dev8 permanecem indisponíveis.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: REJECTED_VISUAL
- **NEXT_ACTION_IMMEDIATE**: Recuar a câmara dinâmica, reduzir rótulos e repetir a captura R1–R3 sem cortes.
- **TARGET_REGION**: R1–R3
- **DEADLINE_NEXT_PUSH**: 2026-08-20T02:42:30+01:00
