# STATUS CHECKPOINT — R1–R6 FOUNDATION 001

**Branch de integração:** `integration/r1-r6-sprint1`  
**Base:** `feature/cine07-final` em `b149795`  
**Responsável de integração:** Dev1  
**Data:** 25 de agosto de 2026

## Objetivo concluído

Foi criada a fundação técnica para permitir que seis devs trabalhem em paralelo nas Regiões 1–6 sem editar diretamente os módulos geográficos existentes nem conflitar em `TempleLevel.gd`, `CartographicAnchors.gd`, Player ou UI.

## Ficheiros adicionados

| Ficheiro | Função |
|---|---|
| `levels/contracts/RegionContract.gd` | Estrutura comum com âncoras, limites, rotas QA, proprietário e orçamento de luzes |
| `levels/contracts/RegionRegistry.gd` | Catálogo e validação dos seis contratos R1–R6 |
| `levels/regions/R1_VossHouse.gd` | Fronteira R1 — Casa Voss / Dev1 |
| `levels/regions/R2_RiverRoad.gd` | Fronteira R2 — Estrada do Rio / Dev2 |
| `levels/regions/R3_ArchRuins.gd` | Fronteira R3 — Arco das Ruínas / Dev3 |
| `levels/regions/R4_DenseForest.gd` | Fronteira R4 — Floresta Densa / Dev4 |
| `levels/regions/R5_MajesticCamp.gd` | Fronteira R5 — Acampamento Majestic / Dev5 |
| `levels/regions/R6_SubmergedRuins.gd` | Fronteira R6 — Ruínas Submersas / Dev6 |
| `qa/regions/verify_region_contracts.gd` | Harness headless que valida os seis contratos |

## Integração protegida

`levels/TempleLevel.gd` agora carrega e valida os contratos no arranque. A integração é deliberadamente **não invasiva**: não cria, desloca ou remove nenhuma geometria existente. O propósito desta primeira entrega é fixar fronteiras de trabalho e contratos de QA antes de os seis devs iniciarem incrementos visuais e de gameplay.

## Evidência de validação

| Verificação | Resultado |
|---|---|
| `verify_region_contracts.gd` | PASS — seis contratos válidos, em ordem R1→R6 |
| Godot 4.7.1 — parser headless | PASS — sem erro de parser ou GDScript |
| QA `road_to_arch` | PASS técnico — contratos emitidos, mundo R1–R6 carregado, spawn Estrada–Arco confirmado, 38 s sem erro fatal |

## Próxima tarefa ativa

**Dev1 — R1 Casa Voss:** criar `levels/regions/r1/` com o primeiro incremento jogável de narrativa ambiental, começando por sinais de habitação e saída da porta E. A implementação não pode alterar a rota para a Estrada, o posicionamento da Casa, os sistemas de jogador ou a geografia de R2–R6.

Em paralelo, Dev2–Dev6 iniciam os seus módulos próprios em `levels/regions/r2` a `levels/regions/r6`, respeitando o contrato correspondente e anexando evidência de parser, rota QA e orçamento.
