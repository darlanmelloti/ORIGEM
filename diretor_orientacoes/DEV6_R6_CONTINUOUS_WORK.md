# Dev6 — Contrato de Trabalho Contínuo das Ruínas Submersas

> **Regra operacional:** uma porta R6 aprovada nunca encerra o Dev6. Cada entrega validada deve publicar e substituir a tarefa atual por uma nova tarefa em estado `ACTIVE`.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV6-R6-BASIN-ARRIVAL-READING-004
owner: Dev6
branch: dev6/r6-submerged-ruins
```

## Limites regionais permanentes

A R6 mantém a âncora cartográfica `(60, 252)`, a ligação Majestic→margem, a bacia navegável, ruínas, filetes de cascata em geometria 3D e a leitura física para a futura Vila Elevada. A R7 não pode ser construída antecipadamente. Não criar portão, corredor artificial, painel, parede, `Light3D` adicional, emissão de água como substituto de geometria ou mudança em `CartographicAnchors.gd`.

O orçamento R6 é exactamente quatro luzes: duas luzes mundiais da bacia, preenchimento de margem e preenchimento submerso central. A sonda `inspect_r6_light_budget.gd` é obrigatória em cada entrega.

## Entrega aprovada — DEV6-R6-SHORE-HANDOFF-002

O módulo `levels/regions/r6/R6ShoreHandoff.gd` adiciona quatro lajes físicas e dois marcos arqueológicos assimétricos entre a margem R6 e a futura direção da Vila Elevada. Cada laje possui colisor e os marcos ficam dentro da fronteira R6, sem luzes novas. A montagem mínima em `ForestLakeRegion.gd` preserva R5 e todo o cenário de bacia já validado.

| Critério | Resultado |
|---|---|
| Lajes e colisores | 4 lajes físicas e 4 colisores validados |
| Marcos | Ocidental e oriental presentes dentro de R6 |
| Iluminação | Handoff sem `Light3D`; orçamento R6 continua em quatro |
| Rotas | `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` aprovadas |
| QA | Parser, sonda de luz, prova de handoff e porta R6 aprovados |

## Tarefa ativa — DEV6-R6-BASIN-ARRIVAL-READING-004

Reforçar a leitura estática da chegada à bacia das Ruínas Submersas com elementos R6 já existentes, sem luz, partículas, shader, emissão de água, painel, interface, câmara, rota artificial, colisão adicional ou construção antecipada da R7. A intervenção deve preservar o limiar real das ruínas, a margem navegável, a cascata, as lajes R6→R7 e as três rotas R6.

| Critério | Obrigatório |
|---|---|
| Escopo | Novo módulo em `levels/regions/r6/`, QA R6 e montagem mínima em R6 |
| Cartografia | Âncora R6 e handoff físico para R7 inalterados |
| Água | Sem painel, emissão excessiva, nova luz ou shader adicional |
| Física | Sem novos colisores ou bloqueios no leito, trilho, cascata, estela ou lajes |
| Luz | `r6_total=4` continua obrigatório |
| QA | Parser, orçamento R6, provas de linha de água e handoff, e todas as rotas R6 antes do PR |

## Sucessão obrigatória

A esteira mantém uma única issue `[Dev6 Continuous]` e encerra automaticamente qualquer item Dev6 anterior quando o `task_id` avançar. O fecho de `DEV6-R6-BASIN-ARRIVAL-READING-004` exige commit publicado, porta R6 aprovada e nova tarefa `ACTIVE`.
