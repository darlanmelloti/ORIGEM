# CP-D5-095 — Plano de Integração do Mapa Vivo R1–R6

## Finalidade

Os candidatos Dev5 validados dão vida tridimensional aos seis marcos cartográficos sem modificar os módulos de produção. Este documento define a ordem segura para o Dev1 integrar o conteúdo no mundo real, mantendo o mapa como autoridade espacial, a rota de Elias jogável e o orçamento da GTX 1050 Ti.

> A integração é deliberada e reversível. Um candidato QA não é promoção automática: o Dev1 deve aplicar um marco por commit, validar visualmente e reverter imediatamente se a rota, a leitura cartográfica ou a composição piorarem.

## Ordem de integração recomendada

| Ordem | Marco e módulo Dev1 | Candidato Dev5 | Limites de produção | Prova obrigatória |
|---|---|---|---|---|
| 1 | R2 Estrada do Rio — `RiverRoadJourney.gd` | Ponte modular, fauna de margem, 2 árvores, 2 fetos e vestígios de abrigo | A fauna fica a pelo menos 5 m da rota; não usar ponte GLB; preservar água e travessia | `road_to_arch`, 36 s e chegada à ponte |
| 2 | R4 Floresta — `ForestLakeRegion.gd` | 2 cervos, 1 pinheiro focal, 3 árvores detalhadas, 2 leves, 2 fetos e abrigo lateral | Corredor mínimo de 5 m; zero portal estrutural; não formar parede vegetal | `arch_to_forest`, 36 s e leitura de Elias |
| 3 | R5 Majestic — `ForestLakeRegion.gd` | Pavilhão, 2 cervos, clareira e abrigo colapsado | Respeitar o desvio lateral Majestic; no máximo 1 luz adicional; rota R5→R6 livre | `majestic_lake`, 36 s e captura interna |
| 4 | R6 Ruínas — `ForestLakeRegion.gd` | Baliza monolítica, cervos, margem orgânica e ruína de abrigo | Não restaurar cais de lajes rejeitado; manter folga lateral de 4 m | `ruins_arrival`, 36 s e chegada às ruínas |
| 5 | R3 Arco — `RiverRoadJourney.gd` | Flora de margem, 2 cervos e ruínas laterais | Não construir arco estrutural; manter alvo físico z≈92 e silhueta distante | `road_to_arch`, 36 s e leitura R3→R4 |
| 6 | R1 Casa Voss — `VossHouse.gd` | Anexo exterior, horta e fauna | Não tocar na porta, soleira, prólogo ou `Player.gd`; preservar saída por E | `road_return_voss`, 36 s e saída exterior |

## Contratos globais

| Área | Regra de integração |
|---|---|
| Grounding | Todos os novos nós são colocados por raycast; X/Z da âncora é imutável e apenas Y pode variar. |
| LOD vegetal | Máximo: 1 pinheiro PBR focal, 3 árvores detalhadas em plano médio, 6 árvores leves em plano distante e 1 feto por lado do trilho. |
| Fauna | Usar `deer_quaternius_cc0.glb`; manter distância física mínima de 5 m da rota e movimento ambiental de baixa frequência. |
| Luzes | No máximo 16 luzes dinâmicas simultâneas no mundo; cada composição Dev5 usa apenas 1. |
| Escopo | Não editar Regiões 7–12, módulos Dev2, porta da Casa Voss ou `Player.gd` sem revisão explícita. |
| Reversão | Cada marco é um commit isolado; se a captura de 36 s não superar 85% da leitura desejada, reverter esse commit e preservar apenas a evidência QA. |

## Evidências de origem

| Marco | Preview QA | Captura |
|---|---|---|
| R1 | `R1LivingVossExteriorPreview.tscn` | `qa_evidence_dev5_r1_living/r1_living.png` |
| R2 | `R2LivingRiverRoadPreview.tscn` | `qa_evidence_dev5_r2_living_fixed/r2_living_fixed.png` |
| R3 | `R3LivingArchCorridorPreview.tscn` | `qa_evidence_dev5_r3_living/r3_living.png` |
| R4 | `R4LivingForestPreview.tscn` | `qa_evidence_dev5_r4_living/r4_living.png` |
| R5 | `R5LivingMajesticPreview.tscn` | `qa_evidence_dev5_r5_living/r5_living.png` |
| R6 | `R6LivingShorePreview.tscn` | `qa_evidence_dev5_r6_living_smooth/r6_living_smooth.png` |

## Próxima tarefa contínua

**CP-D5-096 — Pacote de suporte de integração R2.** Preparar a ficha exacta de implantação de R2 para o Dev1: coordenadas cartográficas, grupos, tipos de colisor, limites de fauna e passos de reversão.
