# CP-D5-450 — Auditoria integrada contínua R1–R6

## Estado operacional

| Campo | Resultado |
|---|---|
| REGIAO_ACTUAL | R1–R6 / interface R6→R7 |
| RESPONSAVEL | Dev5 — Mundo Cartesiano & 3D |
| STATUS_CODE | PASSED |
| TAREFA_EM_EXECUCAO_AGORA | Auditoria integrada dos seis candidatos no harness cartográfico |
| DEPENDENCIAS_RECEBIDAS | Directiva Dev2–Dev6; handoff Dev5→Dev6; autoridade `mapaorigem.webp` |
| EVIDENCIA | Parser `PARSER_EXIT=0`; QA headless 36 segundos em 1600×900 (`QA_EXIT=124`, timeout controlado); runtime auditável |
| NEXT_ACTION_IMMEDIATE | Publicar e iniciar a próxima regressão de Elias no CP-D5-451 |
| WAIT_ALLOWED | false |

A cena `CartographicRegressionAuditPreview.tscn` confirmou seis candidatos, grounding e rotas aprovados, clearance `0.21`, passagem florestal de `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e composição vegetal R4/R5 em `1/3/4`, sem parede de árvores. As âncoras X/Z, colisores e offsets permaneceram preservados para Casa Voss, Ponte Marco 2, Floresta Densa, Acampamento Majestic, Ruínas Submersas e Vegetação Média.

Não foram observados `SCRIPT ERROR` ou `Parse Error`. Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless. Evidência completa: `diretor_orientacoes/CP-D5-450_RUNTIME.log`.

O passe está aprovado e não encerra a produção: o próximo incremento deve começar na mesma sessão operacional, sem espera intermédia.
