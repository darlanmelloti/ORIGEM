# ORIGEM — Isolamento de Material do Afluente Cartográfico R4 044

**Tarefa:** `DEV4-R4-CARTOGRAPHIC-INLET-MATERIAL-ISOLATION-044`
**Estado:** Diagnóstico concluído sem modificação de produção
**Região:** R4 — Floresta Densa
**Rota observada:** `arch_to_forest`

## Decisão técnica

A superfície opaca clara observada no primeiro plano de `arch_to_forest` é produzida pela **lâmina geométrica do afluente cartográfico** em interacção com o seu **material lacustre partilhado**, e não por lajes, trilho, âncoras, marcadores de QA, luzes ou física. A geometria é a malha `LaminaDoAfluenteCartografico`, filha de `AfluenteCartograficoRioParaBacia`; ela constitui quatro segmentos triangulados, com 24 vértices. A opacidade completa é determinada pelo `ShaderMaterial` criado por `_create_lake_material()`, que contém `depth_draw_opaque` e `ALPHA = 1.0`.

> A prova de isolamento duplicou exclusivamente a malha no espaço QA e atribuiu-lhe material transparente de controlo. A contagem de vértices e a caixa espacial permaneceram idênticas, enquanto a instância de produção conservou o mesmo material, pai e ausência de `material_override`.

| Elemento | Evidência isolada | Resultado |
|---|---|---|
| Geometria candidata | `LaminaDoAfluenteCartografico` | 24 vértices e 4 segmentos; corresponde ao traçado do afluente |
| Material aplicado | `_create_lake_material()` | `depth_draw_opaque` e `ALPHA = 1.0` confirmados |
| Controlo QA transparente | Duplicata não instalada na região | Preservou a geometria e isolou a contribuição visual do material |
| Produção | `ForestLakeRegion.gd` e malha original | Não modificados |
| Água R6 e material partilhado | Sem escrita | Preservados |

## Limite e proposta segura

A tarefa 044 **não** modificou `ForestLakeRegion.gd`, `TerrainPatch.gd`, água R6, âncoras, rota, câmara, luzes ou física. A evidência demonstra que uma eventual correcção não deve alterar `_create_lake_material()`, pois o recurso é partilhado com R6.

O único caminho que pode ser analisado na tarefa sucessora é um **material local exclusivo da lâmina do afluente**, criado e aplicado somente no ponto de montagem R4 dessa instância. Esse caminho deve conservar a mesma malha, coordenadas, corredor, ausência de colisão, orçamento de luz e comportamento R6; precisa ainda de prova cruzada R4/R6 antes de qualquer publicação de produção.

| Restrição preservada | Estado |
|---|---|
| Clareira Orion (`Z≈126–151`) | Intacta |
| Corredor físico | Sem alteração; garantia acumulada `≥8 m` preservada |
| Trilho, lajes, rota, câmara e âncoras | Sem alteração |
| Luzes, colisores, partículas, vento, animação, shaders globais e pós-processamento | Sem alteração |
| R5, R6 e material lacustre partilhado | Sem alteração |

## Validação executada

| Verificação | Resultado |
|---|---|
| Parser Godot headless | Aprovado |
| Prova isolada | `[ORIGEM_R4_INLET_ISOLATION_OK]` |
| Auditoria de orçamento | `[QA-BUDGET-01] result=PASS`; 1 luz simultânea na câmara, limite 16 |
| Porta canónica R4 | `[GATE:R4] PASS` |
| `arch_to_forest` | Aprovada |
| `forest_to_majestic` | Aprovada |
| `forest_to_ruins` | Aprovada |

Os avisos `Parameter "material" is null` que possam surgir ao encerrar harnesses headless são ruído conhecido do backend dummy após êxito das verificações; não houve erro de parser, script, shader ou falha fatal nesta passagem.

## Continuidade

A tarefa 044 está concluída como diagnóstico. A sucessão adequada é `DEV4-R4-CARTOGRAPHIC-INLET-LOCAL-MATERIAL-CORRECTION-045`, ainda limitada a uma proposta modular local e condicionada à prova conjunta de não regressão R4/R6 antes de qualquer mudança de produção.
