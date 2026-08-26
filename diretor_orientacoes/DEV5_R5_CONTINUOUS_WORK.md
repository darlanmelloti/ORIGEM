# Dev5 — Contrato de Trabalho Contínuo do Acampamento Majestic

> **Regra operacional:** a aprovação R5 não encerra o Dev5. Cada entrega deve publicar, validar e substituir a tarefa ativa por outra, sem deixar a Região 5 sem sucessão rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV5-R5-CAMP-WIND-READING-003
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

## Tarefa ativa — DEV5-R5-CAMP-WIND-READING-003

Produzir uma auditoria visual 16:9 da leitura de vento em sessão R5 e confirmar que a largura navegável do conector Majestic não sofre qualquer redução enquanto o módulo está ativo. A intervenção, se necessária, fica limitada a amplitude ou fase já declaradas em `MajesticCampWindReading.gd`; não criar malhas, luzes, nós recorrentes, física de pano, câmara, UI ou alteração da rota.

| Critério | Obrigatório |
|---|---|
| Visual | Captura 16:9 no acampamento e confirmação de leitura discreta, sem oscilação uniforme |
| Navegação | O conector R4→R5 e a ligação Majestic→R6 devem manter a largura e colisão aprovadas |
| Custo | Sem nova geometria, luz, partículas, shader, física ou nós em runtime |
| Verificação | Parser, prova R5 de vento, porta R5, rotas `forest_to_majestic` e `majestic_to_lake` |

## Sucessão obrigatória

A esteira regional exige este contrato em `ACTIVE`, mantém uma única issue `[Dev5 Continuous]` e encerra automaticamente tarefas Dev5 obsoletas. O fecho de `DEV5-R5-CAMP-WIND-READING-003` exige commit publicado, validação R5 e um novo `task_id` em estado `ACTIVE`.
