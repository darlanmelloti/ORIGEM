# Dev6 — Contrato de Trabalho Contínuo das Ruínas Submersas

> **Regra operacional:** uma porta R6 aprovada nunca encerra o Dev6. Cada entrega validada deve publicar e substituir a tarefa atual por uma nova tarefa em estado `ACTIVE`.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV6-R6-SHORELINE-LEGIBILITY-005
owner: Dev6
branch: dev6/r6-submerged-ruins
```

## Limites regionais permanentes

A R6 mantém a âncora cartográfica `(60, 252)`, a ligação Majestic→margem, a bacia navegável, ruínas, filetes de cascata em geometria 3D e a leitura física para a futura Vila Elevada. A R7 não pode ser construída antecipadamente. Não criar portão, corredor artificial, painel, parede, `Light3D` adicional, emissão de água como substituto de geometria ou mudança em `CartographicAnchors.gd`.

O orçamento R6 é exactamente quatro luzes: duas luzes mundiais da bacia, preenchimento de margem e preenchimento submerso central. A sonda `inspect_r6_light_budget.gd` é obrigatória em cada entrega.

## Entrega aprovada — DEV6-R6-WATERLINE-READING-003

A composição `R6_DetritosLinhaDeAgua` acrescenta nove detritos arqueológicos assimétricos de margem no `ForestLakeRegion.gd`. Os elementos são exclusivamente visuais, ficam fora da elipse de água e do corredor Majestic→R6, e não introduzem luzes, shader, emissão, painel ou colisores.

| Critério | Resultado |
|---|---|
| Linha de água | 9 detritos; nenhum dentro da elipse lacustre |
| Rota | 0 detritos no corredor de chegada e nenhuma alteração nas lajes |
| Handoff | R6→R7 preservado sem geometria antecipada de R7 |
| Iluminação | Nenhuma luz nova; orçamento regional permanece em quatro |
| QA | Parser, sonda de luz, prova de handoff e três rotas R6 aprovados |

A porta regional do merge canônico registou a aprovação do orçamento de quatro luzes, do handoff R6→R7 e das rotas `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`.

## Tarefa ativa — DEV6-R6-SHORELINE-LEGIBILITY-005

Inspecionar a legibilidade arqueológica da margem de R6 na chegada, com foco na relação entre os nove detritos de linha de água, a estela `RuneP0_02`, as ruínas submersas e a cascata. A tarefa deve usar a evidência runtime aprovada da porta regional como ponto de partida e permanecer limitada à R6.

| Critério | Obrigatório |
|---|---|
| Linha de água | Detritos distinguíveis da margem e fora do trilho |
| Estela | `RuneP0_02` acessível e legível na chegada |
| Ruínas | Pilares e domo legíveis sob a água sem painel adicional |
| Cascata | Filetes 3D preservados sem luz ou emissão nova |
| Handoff | R6→R7 apenas visual e físico, sem construção da R7 |
| Luz | `r6_total=4` continua obrigatório |
| QA | Parser, orçamento R6, prova de handoff e todas as rotas R6 antes do PR |

## Sucessão obrigatória

A esteira mantém uma única issue `[Dev6 Continuous]` e encerra automaticamente qualquer item Dev6 anterior quando o `task_id` avançar. O fecho de `DEV6-R6-SHORELINE-LEGIBILITY-005` exige commit publicado, porta R6 aprovada e nova tarefa `ACTIVE`.
