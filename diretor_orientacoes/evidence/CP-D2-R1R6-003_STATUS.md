# CP-D2-R1R6-003 — Câmara QA e leitura visual R1–R3

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R3 — Casa Voss, Estrada do Rio e Arco das Ruínas
- **RESPONSAVEL**: Dev2 — coordenação; Dev3 fornece o eixo cinematográfico e Dev4 audita o pacote
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Integrar o contrato QA de grounding na próxima validação jogável, mantendo os marcadores fora do pacote de produção
- **NEXT_ACTION_IMMEDIATE**: Iniciar CP-D2-R1R6-004, com a câmara QA a acompanhar uma travessia física curta ao longo do corredor Casa Voss → Estrada do Rio → Arco e com scope guard contra alterações da geometria do Dev1
- **TARGET_REGION**: R1–R3
- **DEADLINE_PROXIMO_PUSH**: 2026-08-20T02:22:30+01:00

## Evidência aprovada

A cena QA reversível `validation/CartographicR1R3CaptureQA.gd` foi executada em Godot 4.7.1 sem erros de parser ou runtime. A captura 1600×900 mostra os três marcos derivados de `CartographicAnchors.gd`, os rótulos `R1 CASA VOSS`, `R2 ESTRADA DO RIO` e `R3 ARCO DAS RUÍNAS`, e o corredor visual QA-only entre R1 e R3. O gameplay de 30 segundos foi produzido no mesmo processo e os hashes ficam no ficheiro `SHA256SUMS.txt`.

Este `PASSED` aplica-se apenas à leitura visual da cena QA dedicada. Não autoriza substituir a geometria real, não encerra a validação jogável das Regiões 1–6 e não altera a standby do Dev1.

## Contrato de continuidade

Dev5 pode agora preparar candidatos grounded de arquitectura e objectos para R1–R3. Dev6 deve aplicar materiais, céu, vegetação e ambiente sem criar uma segunda coordenada. Dev3 deve converter este enquadramento em uma câmara de travessia. Dev4 deve confirmar colisores, LOD, inventário de luzes, parser e pacote. Dev2 inicia o próximo ciclo imediatamente após este commit.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: PASSED
- **NEXT_ACTION_IMMEDIATE**: Começar CP-D2-R1R6-004 — travessia física curta R1→R2→R3 com scope guard.
- **TARGET_REGION**: R1–R3
- **DEADLINE_NEXT_PUSH**: 2026-08-20T02:22:30+01:00
