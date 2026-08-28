# ORIGEM — Intake da Baseline Ambiental 024 para Dev7

**Task ID:** `DEV7-ENVIRONMENT-BASELINE-INTAKE-024`

**Estado:** `ACTIVE — reconciliação documental somente de leitura`

**Produção:** `production_mutations=0`

## Referência canónica

A baseline ambiental foi definida por Dev1 no commit `00d8323f4411fd0797a47783bb12c95aeed86de3` e encontra-se integrada na referência canónica `d3bbf0daa960140dedff1a980c7f345c7561aacf`.

| Artefacto | Caminho integrado | Função no intake |
|---|---|---|
| Protocolo de vistas Dev1 | `qa/environment/ENVIRONMENT_PLAYER_VIEW_BASELINE_002.md` | Fonte canónica de objetivo, câmara, resolução, rotas e decisões permitidas. |
| Matriz das seis vistas | `reports/dev8/cartographic_fidelity_baseline_001/CAPTURE_MATRIX_001.md` | Índice de telemetria espacial e leitura cartográfica das seis rotas. |
| Folha de contacto | `reports/dev8/cartographic_fidelity_baseline_001/routes_1600x900/contact_sheet.png` | Referência visual consolidada já publicada; não recapturar. |
| Vista R6 de aproximação | `reports/dev8/cartographic_fidelity_baseline_001/routes_1600x900/forest_to_ruins.png` | Leitura entre trilho, água e ruínas, sem antecipar R7. |
| Vista R6 de chegada | `reports/dev8/cartographic_fidelity_baseline_001/routes_1600x900/ruins_arrival.png` | Leitura da bacia e dos vestígios na chegada R6. |

As seis rotas de referência são `road_to_arch`, `arch_to_forest`, `forest_to_majestic`, `majestic_to_lake`, `forest_to_ruins` e `ruins_arrival`.

## Escopo autorizado

Dev7 deve apenas relacionar as duas vistas R6 existentes com os invariantes já aprovados: rota física, água, handoff R6→R7, cinco vestígios de entrada, quatro luzes canónicas e ausência de antecipação de conteúdo R7. O resultado permitido é um registo documental de uma das classificações `PASS_LEITURA`, `OBSERVAR_SEM_PRODUCAO` ou `HIPOTESE_CAUSAL_REQUERIDA`.

## Limites invioláveis

Não criar captura, variante, override de material, produção, cena, mesh, nó, água, luz, partícula, colisor, área, rota, largura de trilho, âncora, Player ou câmara. Não editar `levels/ForestLakeRegion.gd`, `levels/regions/R6_SubmergedRuins.gd`, `CartographicAnchors.gd`, UI ou timeline. Não iniciar CI manual, bypass, force push ou reexecutar gates.

## Condição de avanço

Somente `HIPOTESE_CAUSAL_REQUERIDA` pode abrir uma nova proposta, e apenas depois de Dev6/R6 fornecer uma hipótese falsificável, NodePaths exatos, enquadramento e limites materiais. A ausência de hipótese não é paragem: a tarefa continua como `OBSERVAR_SEM_PRODUCAO` com handoff documental completo.
