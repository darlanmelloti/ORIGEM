# CP-D2-R1R6-001 — Contrato Cartográfico R1–R6

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 1–6 — Casa Voss → Estrada do Rio → Arco das Ruínas → Floresta Densa → Acampamento Majestic → Ruínas Submersas
- **RESPONSAVEL**: Dev2 — coordenação QA e contrato cartográfico; Dev1 permanece em standby
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Captura visual jogável da cadeia R1–R6 a partir do mundo integrado, com a sobreposição MAP_MIRROR_VALIDATION apenas em modo QA
- **NEXT_ACTION_IMMEDIATE**: Executar o mundo Godot 4.7.1 com janela capturável, gerar print 1600×900 e gameplay de aproximadamente 30 segundos; depois comparar escala, grounding, leitura de percurso e continuidade da água
- **TARGET_REGION**: R1–R6, com fronteira R6→R7 marcada como QA_BOUNDARY_PENDING
- **DEADLINE_PROXIMO_PUSH**: 2026-08-20T02:02:30+01:00

## Resultado técnico comprovado

O novo `validation/CartographicR1R6FidelityQA.gd` consome directamente `levels/CartographicAnchors.gd`, sem coordenadas concorrentes. O teste executado em Godot 4.7.1 confirmou a ordem crescente dos marcos, a presença das posições no mapa, a cadeia `R1→R2→R3→R4→R5→R6`, a fronteira `R6→R7`, a distância cartográfica total de `374.677` unidades e a política de não adicionar luzes dinâmicas.

O harness `validation/test_checkpoint_cp_d2_r1r6_cartographic_fidelity.sh` também foi executado com sucesso e produziu `headless.log`, `QA_SUMMARY.txt` e `SHA256SUMS.txt` em `diretor_orientacoes/evidence/cp-d2-r1r6-001/`. A captura virtual gerou `print-1600x900.png` e `gameplay-30s.mp4` com SHA-256 registado, mas a entrada sintética não ultrapassou o prólogo: a imagem mostra a Casa Voss, porém mantém o aviso `Mantenha [E] para saltar o prólogo`.

## Critério ainda não satisfeito

O incremento permanece `REJECTED_VISUAL`: a resolução e a duração foram produzidas, mas a evidência ainda não comprova a travessia jogável R1–R6. Esta rejeição visual não encerra o trabalho; activa imediatamente a correcção do capturador/rota de validação para entrar no percurso real e repetir a comparação.

## Fronteira e segurança

Nenhum módulo de geometria proprietário das Regiões 1–6 foi reescrito. O incremento adiciona apenas um consumidor QA da autoridade cartográfica e um harness reproduzível. Dev3 deverá fornecer a leitura de câmara; Dev4 deverá auditar parser, colisores, LOD, orçamento de luzes e pacote; Dev5 e Dev6 deverão usar este contrato como base para grounding, objectos e ambiente.

## Próximo ciclo obrigatório

Após a captura visual, iniciar `CP-D2-R1R6-002`: grounding de Casa Voss, Estrada do Rio e Arco das Ruínas com marcadores QA temporários, sem alterar a autoridade de coordenadas e sem introduzir uma segunda cadeia espacial.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: REJECTED_VISUAL
- **NEXT_ACTION_IMMEDIATE**: Capturar e comparar a travessia jogável R1–R6 em 1600×900 e 30 segundos.
- **TARGET_REGION**: R1–R6
- **DEADLINE_NEXT_PUSH**: 2026-08-20T02:02:30+01:00
