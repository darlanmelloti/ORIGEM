# CP-D5-448 — Passe de Fidelidade Cartográfica R1–R6

## Estado operacional

| Campo | Resultado |
|---|---|
| REGIAO_ACTUAL | R1–R6 / interface R6→R7 em validação de continuidade |
| RESPONSAVEL | Dev5 — Mundo Cartesiano & 3D |
| STATUS_CODE | PASSED |
| TAREFA_EM_EXECUCAO_AGORA | Auditoria integrada dos seis candidatos cartográficos com grounding, colisores, LOD, luzes e composição vegetal |
| DEPENDENCIAS_RECEBIDAS | Directiva Operacional Dev2–Dev6; autoridade espacial `mapaorigem.webp`; cena `CartographicRegressionAuditPreview.tscn` |
| EVIDENCIA | Parser `PARSER_EXIT=0`; QA headless de 36 segundos em 1600×900 (`QA_EXIT=124`, timeout controlado); `CP-D5-448_RUNTIME.log` |
| NEXT_ACTION_IMMEDIATE | Publicar o relatório e iniciar a regressão de Elias no CP-D5-449 |
| WAIT_ALLOWED | false |

## Resultado técnico

A cena `CartographicRegressionAuditPreview.tscn` confirmou seis candidatos, grounding e rotas aprovados, clearance `0.21`, passagem florestal de `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e composição vegetal R4/R5 em `1/3/4`, sem parede de árvores. Os marcos Casa Voss, Ponte Marco 2, Floresta Densa, Acampamento Majestic, Ruínas Submersas e Vegetação Média mantiveram âncoras X/Z, colisores e offsets cartográficos compatíveis.

Não foram observados `SCRIPT ERROR` ou `Parse Error`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility em ambiente headless e não constituem falha do passe.

## Handoff Dev5→Dev6

Dev6 recebe as âncoras e bounding boxes dos seis candidatos, os requisitos de grounding, os materiais esperados, a composição vegetal `1/3/4`, a passagem florestal de `2.4 m` e a restrição de custo sem novas luzes dinâmicas. A interface R6→R7 fica limitada ao contrato de escala, direção e navegação, sem duplicação de geometria regional. Dev6 deve manter água, céu, vegetação, materiais e atmosfera reversíveis e compatíveis com GL Compatibility/Forward+, sem ultrapassar o orçamento de 16 luzes dinâmicas.

## Evidência e integridade

Relatório de execução: `diretor_orientacoes/CP-D5-448_RUNTIME.log`.

O SHA-256 do relatório e do presente documento deve ser calculado no momento da publicação e registado no marcador Dev5. A próxima tarefa inicia-se na mesma sessão operacional, sem espera intermédia.
