# ORIGEM — Dev7: Manifest de Intake Somente de Leitura da Baseline Ambiental Integrada 024

| Campo | Registo |
|---|---|
| **Task ID** | `DEV7-ENVIRONMENT-BASELINE-INTAKE-024` |
| **Referência canónica de consumo** | `d3bbf0daa960140dedff1a980c7f345c7561aacf` |
| **Protocolo proprietário** | Dev1, commit `00d8323f4411fd0797a47783bb12c95aeed86de3` — `qa/environment/ENVIRONMENT_PLAYER_VIEW_BASELINE_002.md` |
| **Matriz visual integrada** | `reports/dev8/cartographic_fidelity_baseline_001/CAPTURE_MATRIX_001.md` |
| **Diretório de capturas já publicadas** | `reports/dev8/cartographic_fidelity_baseline_001/routes_1600x900/` |
| **Resolução confirmada** | 1600×900 em todas as seis rotas |
| **Natureza desta entrega** | Manifest de proveniência e decisão Dev7, exclusivamente documental; não cria captura, cena, recurso ou alteração de produção. |
| **Produção** | `production_mutations=0` |

## Proveniência e método

Este manifest não substitui a baseline do Dev1 nem reencena a matriz cartográfica do Dev8. Ele associa, de forma verificável, o protocolo Dev1 às seis imagens e telemetrias já integradas na referência canónica, para que o verificador Dev7 receba uma entrada com o seu vocabulário de decisão obrigatório. O resultado é uma normalização de metadados já publicados, não uma nova auditoria visual.

A telemetria foi consumida da matriz de capturas e dos logs de rota publicados. Cada rota conserva o spawn/posição observada; a câmara pertence ao contexto publicado de cena de jogo em Xvfb/OpenGL; e o orçamento de luz regional permanece identificado nos logs de runtime. Em particular, R6 conserva quatro luzes nas rotas `majestic_to_lake`, `forest_to_ruins` e `ruins_arrival`.

## Matriz integrada e decisão Dev7

| Rota | PNG publicado 1600×900 | Telemetria publicada | Luzes / invariante relevante | Decisão de leitura Dev7 | Justificação somente de leitura |
|---|---|---|---|---|---|
| `road_to_arch` | `routes_1600x900/road_to_arch.png` | Spawn Estrada–Arco `(-20.05, 0.606, 22.0)`; o estado narrativo mantém Casa Voss. | Contrato regional R2: duas luzes; a matriz não cria luzes. | `OBSERVAR_SEM_PRODUCAO` | A UI é legível, mas o harness não simula a descoberta completa; a lacuna pertence a Dev1/timeline como observação, sem correção Dev7. |
| `arch_to_forest` | `routes_1600x900/arch_to_forest.png` | Posição `(-9.00, 107.00)`; marco 4 a 9.00 m. | Contrato regional R3: duas luzes. | `PASS_LEITURA` | O marcador Elias corresponde ao corredor da Floresta. |
| `forest_to_majestic` | `routes_1600x900/forest_to_majestic.png` | Posição `(-2.50, 178.00)`; primeira perna ocidental. | Contrato regional R4: uma luz. | `PASS_LEITURA` | O desvio cartográfico para oeste permanece legível. |
| `majestic_to_lake` | `routes_1600x900/majestic_to_lake.png` | Posição `(-77.40, 178.00)`; marco 5 a 10.60 m. | Contrato regional R5: quatro luzes; entrada de rota R6 preserva quatro luzes. | `PASS_LEITURA` | A reconvergência para a bacia é legível, sem nova composição Dev7. |
| `forest_to_ruins` | `routes_1600x900/forest_to_ruins.png` | Spawn Floresta–Ruínas `(9.77, 194.00)`; trecho leste da faixa 150–202. | R6: quatro luzes; rota, água, cinco vestígios e handoff R6→R7 protegidos. | `OBSERVAR_SEM_PRODUCAO` | A regra espacial publicada mantém o destino cartográfico em Majestic; a própria matriz classifica o facto como observação, não defeito confirmado. Não existe hipótese causal R6 aprovada. |
| `ruins_arrival` | `routes_1600x900/ruins_arrival.png` | Spawn/posição `(13.68, 222.00)`; marco 6 a 55.19 m. | R6: quatro luzes e handoff de chegada preservados. | `PASS_LEITURA` | O handoff R6 e a leitura de chegada às ruínas permanecem coerentes. |

## Invariantes R6 reconfirmadas por consumo

| Invariante | Estado no intake |
|---|---|
| Rota canónica `forest_to_ruins` | Consumida como evidência publicada; não reencenada. |
| Água e `LagoDasRuinasSubmersas` | Não modificados. |
| Quatro luzes canónicas R6 | Referenciadas pela telemetria de runtime; não criadas, movidas ou ajustadas. |
| Cinco vestígios de entrada e taxonomia histórica | Não reabertos; a captura 003 continua rejeitada para produção. |
| Câmara, Player, física, colisores e ancoragens | Não modificados. |
| Handoff R6→R7 | Protegido; não há antecipação de conteúdo R7. |

## Limite de decisão

`HIPOTESE_CAUSAL_REQUERIDA` não é declarada por este intake. Caso seja necessária no futuro, ela continua dependente de autorização explícita Dev6/R6 que contenha **hipótese visual falsificável**, **conjunto de alvos R6 por identidade/`NodePath`** e **enquadramento de prova**. O resultado de completude do intake não promove produção, material, override, captura comparativa, CI ou gate adicional.

> Este é um artefacto de consumo Dev7. As imagens, telemetrias e rotas continuam com a proveniência dos responsáveis que as publicaram; Dev7 apenas registra a decisão QA documental permitida e conserva `production_mutations=0`.
