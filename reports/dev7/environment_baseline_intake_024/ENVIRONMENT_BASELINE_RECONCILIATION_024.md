# ORIGEM — Dev7: Reconciliação da Baseline Ambiental Integrada 024

## Decisão de QA

| Campo | Resultado |
|---|---|
| **Task ID** | `DEV7-ENVIRONMENT-BASELINE-INTAKE-024` |
| **Referência de integração consumida** | `d3bbf0daa960140dedff1a980c7f345c7561aacf` |
| **Estado de intake** | **`READY_FOR_DEV7_RECONCILIATION`** |
| **Estado de máquina Dev7 após o intake** | **`READY_FOR_HYPOTHESIS`** para qualquer ação R6 futura; o intake não promove produção. |
| **Capturas novas por Dev7** | Não. |
| **Alterações de produção R6** | Não; `production_mutations=0`. |
| **CI, gate ou runtime repetidos** | Não. Não existe delta de produção R6 e o marco é de consumo documental. |

A baseline integrada foi consumida de forma autossuficiente. O protocolo de vistas do Dev1 estabelece as seis rotas, a câmara em contexto de jogo e a resolução requerida. A matriz integrada apresenta as seis imagens 1600×900, posições/telemetrias e observações de leitura; os logs de rota preservam a telemetria regional de luzes. Dev7 normalizou apenas estes metadados no `INTEGRATED_BASELINE_READ_ONLY_MANIFEST.md` e executou o validador contra o diretório de imagens já publicado. Nenhuma imagem foi criada, substituída, movida ou alterada.

> **READY_FOR_DEV7_RECONCILIATION** confirma a completude estrutural do intake. Não é autorização para variantes, material, overrides, produção, nova captura, CI manual ou qualquer ação R6 que dependa de hipótese regional.

## Proveniência consumida

| Papel | Artefacto integrado | Uso Dev7 |
|---|---|---|
| Protocolo proprietário da baseline | `qa/environment/ENVIRONMENT_PLAYER_VIEW_BASELINE_002.md` | Exige seis rotas reais, resolução 1600×900, câmara do jogador e telemetria. |
| Matriz de imagens e posições | `reports/dev8/cartographic_fidelity_baseline_001/CAPTURE_MATRIX_001.md` | Fonte das seis imagens existentes, das posições observadas e das leituras originais. |
| Capturas existentes | `reports/dev8/cartographic_fidelity_baseline_001/routes_1600x900/` | Diretório consumido pelo validador; seis PNGs requeridos, todos 1600×900. |
| Telemetria R6 de aproximação | `reports/dev8/cartographic_fidelity_baseline_001/routes_1600x900/forest_to_ruins.log` | Confirma contrato R6 com quatro luzes, spawn Floresta–Ruínas e rota reconhecida. |
| Manifest Dev7 somente de leitura | `reports/dev7/environment_baseline_intake_024/INTEGRATED_BASELINE_READ_ONLY_MANIFEST.md` | Liga a proveniência acima ao vocabulário de decisões do intake, sem reauditar ou recapturar. |
| Resultado do intake | `reports/dev7/environment_baseline_intake_024/intake_result.json` | Evidência estrutural final: `READY_FOR_DEV7_RECONCILIATION`, seis rotas e `production_mutations=0`. |
| Resultado bruto de adaptação | `reports/dev7/environment_baseline_intake_024/raw_upstream_intake_result.json` | Preserva o primeiro resultado `INVALID_INPUT` causado pela ausência de vocabulário de decisão/telemetria no formato esperado pelo verificador, não por imagens ausentes ou resolução inválida. |

## Matriz de conclusão por rota

| Rota | PNG 1600×900 | Telemetria/contrato consumido | Decisão Dev7 | Leitura e limite |
|---|---|---|---|---|
| `road_to_arch` | Confirmado | Spawn Estrada–Arco; a matriz declara que o harness não simula descoberta completa. | `OBSERVAR_SEM_PRODUCAO` | UI legível, com lacuna narrativa encaminhada ao proprietário Dev1/timeline; sem correção Dev7. |
| `arch_to_forest` | Confirmado | Posição `(-9.00, 107.00)`; marco 4 a 9.00 m. | `PASS_LEITURA` | O corredor da Floresta é legível. |
| `forest_to_majestic` | Confirmado | Posição `(-2.50, 178.00)`; primeira perna ocidental. | `PASS_LEITURA` | O desvio cartográfico para oeste é legível. |
| `majestic_to_lake` | Confirmado | Posição `(-77.40, 178.00)`; marco 5 a 10.60 m. | `PASS_LEITURA` | A reconvergência para a bacia é legível. |
| `forest_to_ruins` | Confirmado | Spawn `(9.77, 194.00)`; R6 com quatro luzes, água e rota protegidas. | `OBSERVAR_SEM_PRODUCAO` | O destino cartográfico publicado permanece Majestic; a fonte declara observação, não defeito confirmado. Não há hipótese causal R6. |
| `ruins_arrival` | Confirmado | Posição `(13.68, 222.00)`; chegada R6 e quatro luzes regionais. | `PASS_LEITURA` | Handoff de chegada às Ruínas é coerente e não antecipa R7. |

## Correção do verificador de intake

O primeiro ensaio contra a matriz bruta preservou `INVALID_INPUT`: os seis PNGs estavam presentes e na resolução correta, mas o relatório de origem não usa os três rótulos controlados por rota que o intake Dev7 exige. O diagnóstico mostrou que a procura anterior do verificador podia ligar uma rota a decisões de parágrafos posteriores numa janela de 500 caracteres, produzindo falsos múltiplos em manifestos completos.

A correção em `qa/dev7/check_environment_baseline_intake.py` restringe a associação à **linha que identifica a rota**. Ela não muda imagens, relatórios de origem, produção, cena, runtime, luzes, material, rota ou os critérios de completude. Contra o manifest de proveniência Dev7, a execução passou com uma única decisão para cada rota e `production_mutations=0`.

## Invariantes R6 preservadas

| Invariante | Resultado da reconciliação |
|---|---|
| Rota `forest_to_ruins` | Consumida por evidência existente; não reencenada. |
| Quatro luzes R6 | Referenciadas na telemetria de runtime; nenhuma luz criada, removida ou ajustada. |
| Água e `LagoDasRuinasSubmersas` | Sem alteração. |
| Cinco vestígios e captura arqueológica 003 rejeitada | Sem reabertura; nenhuma variante de material ou override criado. |
| Player, câmara, física, colisores, áreas e ancoragens | Sem alteração. |
| Handoff R6→R7 | Protegido; nenhuma antecipação de conteúdo R7. |
| Integração e CI | Sem bypass, force-push, CI manual, cancelamento ou reexecução agressiva. |

## Limite e próximo estado

Este intake encerra somente a atividade documental de consumo da baseline 024. A frente Dev7 continua aberta. Uma observação em `forest_to_ruins` não se converte em intervenção: qualquer passo R6 futuro exige que Dev6/R6 publique uma **hipótese visual falsificável**, o **conjunto de alvos por identidade/`NodePath`** e o **enquadramento de prova**. Até esse marco, Dev7 permanece em QA somente de leitura e não duplica as capturas Dev1/Dev8.
