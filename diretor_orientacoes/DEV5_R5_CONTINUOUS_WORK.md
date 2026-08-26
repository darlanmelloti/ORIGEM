# Dev5 — Contrato de Trabalho Contínuo do Acampamento Majestic

> **Regra operacional:** a aprovação R5 não encerra o Dev5. Cada entrega deve publicar, validar e substituir a tarefa ativa por outra, sem deixar a Região 5 sem sucessão rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV5-R5-CAMP-FINALIZATION-018
owner: Dev5
branch: dev5/r5-majestic-camp
```

## Base oficial e fronteira

A fonte de trabalho é a branch canónica `dev5/r5-majestic-camp`, reconciliada com `integration/r1-r6-sprint1` sem sobrescrever trabalho exclusivo. A R5 é ancorada em `(-88, 178)` e preserva as transições físicas `forest_to_majestic` e `majestic_to_lake`.

`levels/ForestLakeRegion.gd` mantém a geometria partilhada R4–R6. O conteúdo Dev5 novo deve preferir `levels/regions/r5/` e só pode tocar no construtor partilhado para montagem mínima comprovada. Não alterar `TempleLevel.gd`, âncoras, jogador, mapa UI ou módulos de outras regiões.

## Entrega aprovada — DEV5-R5-ARTEFACT-TRAIL-001

`MajesticArtifactTrail.gd` contém o artefacto azul físico, uma pista de mapa de expedição e uma pista de ferramentas/cordas; a estela completa as três pistas narrativas. A ativação do artefacto dispara `majestic_orion_trace_discovered` na Timeline persistente, sem cutscene ou remoção de controlo. O orçamento local mantém quatro luzes: fogueira, brasa, preenchimento e luar.

## Entrega aprovada — DEV5-R5-CAMP-WIND-READING-002

`MajesticCampWindReading.gd` aplica movimento determinístico e local a duas lonas de chegada e a duas cordas enroladas já existentes no suporte de expedição. O módulo guarda transformações-base e fases distintas, aplicando apenas oscilações de baixa amplitude em `_process`; por isso, não há deriva acumulada, criação contínua de nós, simulação de pano, partículas densas, `Light3D` nova ou alteração de colisão e navegação.

| Critério | Resultado |
|---|---|
| Lonas | 2 lonas de chegada, com fases assimétricas e deslocação reduzida |
| Cordas | 2 cordas existentes, com rotação e elevação local mínima |
| Luz | 0 luz criada pelo módulo; orçamento R5 de 4 focos preservado |
| Estabilidade | Transformações-base conservadas; nenhum nó alvo criado ou removido durante a prova |
| QA | `[ORIGEM_R5_WIND_OK]`, porta R5 e rotas R4→R5→R6 aprovadas |

## Entrega aprovada — DEV5-R5-CAMP-ARRIVAL-READING-004

O módulo `levels/regions/r5/MajesticCampArrivalReading.gd` ajustou estaticamente as duas bases de mastro existentes dentro de `SilhuetasDeChegadaMajestic`, sem deslocar as suas posições-base. Não foram criados nós, geometria, luzes, colisores, partículas, shaders, interface, câmara, eventos narrativos ou rotas artificiais. A prova `[ORIGEM_R5_ARRIVAL_READING_OK]`, o artefacto, a leitura de vento, o orçamento de quatro luzes, o parser, a porta R5 e as duas rotas foram aprovados.

## Entrega aprovada — DEV5-R5-CAMP-EDGE-READING-005

O módulo `MajesticCampEdgeReading.gd` ajustou estaticamente três rolos de campo R5 já existentes, sem criar geometria, luz, colisores, efeitos, interface ou alterações de rota. A prova `[ORIGEM_R5_EDGE_OK]`, a porta R5 cumulativa e as rotas `forest_to_majestic` e `majestic_to_lake` foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-VISTA-READING-006

O módulo `MajesticCampVistaReading.gd` ajustou estaticamente duas costuras de tenda R5 já existentes, sem alterar posições, geometria, luzes, colisores, efeitos, interface, câmara ou rotas. A prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-FOCAL-READING-007

O módulo `MajesticCampFocalReading.gd` ajustou estaticamente duas caixas de campo visuais já existentes. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-RHYTHM-FINAL-008

O módulo `MajesticCampRhythmFinal.gd` ajustou estaticamente duas caixas visuais já aprovadas pela leitura focal. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-CLOSURE-009

O módulo `MajesticCampClosure.gd` ajustou estaticamente duas caixas visuais já aprovadas pela cadência final. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-READABILITY-FINAL-010

O módulo `MajesticCampReadabilityFinal.gd` ajustou estaticamente duas caixas visuais já aprovadas pelo fecho. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-OBSERVATION-011

O módulo `MajesticCampObservation.gd` ajustou estaticamente duas caixas visuais já aprovadas pela legibilidade final. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-REVIEW-012

O módulo `MajesticCampReview.gd` ajustou estaticamente duas caixas visuais já aprovadas pela observação. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-CONSOLIDATION-013

O módulo `MajesticCampConsolidation.gd` ajustou estaticamente duas caixas visuais já aprovadas pela revisão. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-STABILIZATION-014

O módulo `MajesticCampStabilization.gd` ajustou estaticamente duas caixas visuais já aprovadas pela consolidação. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-RECONCILIATION-015

O módulo `MajesticCampReconciliation.gd` ajustou estaticamente duas caixas visuais já aprovadas pela estabilização. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-CONSISTENCY-016

O módulo `MajesticCampConsistency.gd` ajustou estaticamente duas caixas visuais já aprovadas pela reconciliação. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Entrega aprovada — DEV5-R5-CAMP-CHECK-017

O módulo `MajesticCampCheck.gd` ajustou estaticamente duas caixas visuais já aprovadas pela consistência. Os colisores correspondentes foram preservados e verificados; a prova própria, a porta R5 e as rotas foram aprovadas.

## Tarefa ativa — DEV5-R5-CAMP-FINALIZATION-018

Auditar exclusivamente a finalização estática do Acampamento Majestic com elementos R5 existentes, sem criar geometria, luz, física, partículas, shader, interface, câmara ou alteração de rota. A tarefa preserva os conectores R4→R5 e R5→R6 livres e não altera módulos de outras regiões.

| Critério | Obrigatório |
|---|---|
| Escopo | Novo módulo em `levels/regions/r5/`, ou extensão mínima de módulo R5 já existente, sem alterar a geometria partilhada salvo montagem comprovada |
| Leitura | Detalhes estáticos da chegada, sem texto, UI ou evento narrativo precoce |
| Navegação | Corredor R4→R5 e ligação Majestic→R6 mantêm largura, colisão e lajes aprovadas |
| Custo | Sem nova geometria, luz, partículas, shader, física, nós recorrentes ou animação adicional |
| Verificação | Parser, prova R5 própria, porta R5 e rotas `forest_to_majestic` e `majestic_to_lake` |

## Sucessão obrigatória

A esteira regional exige este contrato em `ACTIVE`, mantém uma única issue `[Dev5 Continuous]` e encerra automaticamente tarefas Dev5 obsoletas. O fecho de `DEV5-R5-CAMP-CHECK-017` exige commit publicado, validação R5 e o novo `task_id` em estado `ACTIVE` `DEV5-R5-CAMP-FINALIZATION-018`.
