# Dev5 — Contrato de Trabalho Contínuo do Acampamento Majestic

> **Regra operacional:** a aprovação R5 não encerra o Dev5. Cada entrega deve publicar, validar e substituir a tarefa ativa por outra, sem deixar a Região 5 sem sucessão rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV5-R5-CAMP-WIND-READING-002
owner: Dev5
branch: dev5/r5-majestic-camp
```

## Base oficial e fronteira

A fonte de trabalho é a branch canónica `dev5/r5-majestic-camp`, sempre reconciliada com `integration/r1-r6-sprint1` sem sobrescrever trabalho exclusivo. A R5 é ancorada em `(-88, 178)` e preserva as transições físicas `forest_to_majestic` e `majestic_to_lake`.

`levels/ForestLakeRegion.gd` mantém a geometria partilhada R4–R6. O conteúdo Dev5 novo deve preferir `levels/regions/r5/` e só pode tocar no construtor partilhado para montagem mínima comprovada. Não alterar `TempleLevel.gd`, âncoras, jogador, mapa UI ou módulos de outras regiões.

## Entrega recuperada e aprovada — DEV5-R5-ARTEFACT-TRAIL-001

A recuperação local foi validada pela porta R5. Ela adiciona o módulo `MajesticArtifactTrail.gd`, o artefacto azul físico interagível, uma pista de mapa de expedição e uma pista de ferramentas/cordas; o registo da estela completa as três pistas narrativas. A ativação do artefacto dispara `majestic_orion_trace_discovered` na Timeline persistente sem cutscene ou remoção de controlo.

A correção de orçamento remove as três luzes dinâmicas das tochas e o brilho dinâmico da estela. O acampamento fica com quatro luzes locais: fogueira, brasa, preenchimento e luar. A prova `ORIGEM_R5_ARTEFACT_OK` e as rotas R4→R5→R6 passaram.

## Tarefa ativa — DEV5-R5-CAMP-WIND-READING-002

Criar leitura subtil de abandono recente no Acampamento Majestic através de movimento económico de lonas e cordas existentes, com variação de fase e sem física complexa, partículas densas, `Light3D` nova, paredes vegetais ou alteração da rota. A resposta deve ser visível apenas nas lonas de chegada e nas cordas do suporte de expedição, mantendo a fogueira, tendas e ligação à margem como conteúdo físico já aprovado.

| Critério | Obrigatório |
|---|---|
| Escopo | R5, módulo `levels/regions/r5/`, QA R5 e integração mínima |
| Cartografia | Entrada R4, desvio oeste e ligação Majestic→R6 preservados |
| Visual | Movimento discreto, assimétrico e material; sem greybox, painel ou vento uniforme em toda a região |
| Luz | Máximo de quatro `Light3D` locais; nenhuma luz nova |
| Custo | Sem simulação de pano, partículas densas ou criação contínua de nós |
| QA | Parser, porta R5, prova de artefacto/pistas/orçamento e rotas contratadas antes do PR |

## Sucessão obrigatória

A esteira regional exige este contrato em `ACTIVE`, mantém uma única issue `[Dev5 Continuous]` e encerra automaticamente tarefas Dev5 obsoletas. O fecho de `DEV5-R5-CAMP-WIND-READING-002` exige um novo `task_id` ativo, commit publicado e porta R5 aprovada.
