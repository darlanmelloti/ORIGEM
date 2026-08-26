# Dev6 — Contrato de Trabalho Contínuo das Ruínas Submersas

> **Regra operacional:** uma porta R6 aprovada nunca encerra o Dev6. Cada entrega validada deve publicar e substituir a tarefa atual por uma nova tarefa em estado `ACTIVE`.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV6-R6-APPROACH-FRAMING-006
owner: Dev6
branch: dev6/r6-submerged-ruins
```

## Limites regionais permanentes

A R6 mantém a âncora cartográfica `(60, 252)`, a ligação Majestic→margem, a bacia navegável, ruínas, filetes de cascata em geometria 3D e a leitura física para a futura Vila Elevada. A R7 não pode ser construída antecipadamente. Não criar portão, corredor artificial, painel, parede, `Light3D` adicional, emissão de água como substituto de geometria ou mudança em `CartographicAnchors.gd`.

O orçamento R6 é exactamente quatro luzes: duas luzes mundiais da bacia, preenchimento de margem e preenchimento submerso central. A sonda `inspect_r6_light_budget.gd` é obrigatória em cada entrega.

## Entrega aprovada — DEV6-R6-WATERLINE-READING-003

A composição `R6_DetritosLinhaDeAgua` acrescenta nove detritos arqueológicos assimétricos de margem no `ForestLakeRegion.gd`. Os elementos são exclusivamente visuais, ficam fora da elipse de água e do corredor Majestic→R6, e não introduzem luzes, shader, emissão, painel ou colisores.

## Entrega aprovada — DEV6-R6-SHORELINE-LEGIBILITY-005

A composição `R6_LeituraArqueologicaDaMargem` adiciona um fragmento de coluna e duas pedras assimétricas na margem exterior oeste. A correção foi motivada por capturas de chegada que mostravam água mas não davam leitura arqueológica suficiente da margem. Os três vestígios ficam fora da elipse de água e do trilho, não têm corpos físicos, luzes, shader, emissão ou painel.

| Critério | Resultado |
|---|---|
| Linha de água | 9 detritos e 3 vestígios de chegada presentes |
| Física | 0 colisores no novo conjunto; lajes e rota preservadas |
| Iluminação | 0 luzes novas; orçamento R6 permanece em quatro |
| Handoff | R6→R7 preservado sem geometria antecipada de R7 |
| QA | Parser, sonda de luz, prova de handoff e três rotas R6 aprovados |

## Tarefa ativa — DEV6-R6-APPROACH-FRAMING-006

Validar que a chegada às Ruínas Submersas enquadra de modo coerente a bacia, a estela `RuneP0_02`, a linha de água arqueológica e o primeiro plano de ruínas no renderer `gl_compatibility`. O objectivo é de observabilidade e composição da chegada, não de ampliação de escopo.

| Critério | Obrigatório |
|---|---|
| R6 | Alterações somente dentro da fronteira regional das Ruínas Submersas |
| Água | Sem shader adicional, painel ou aumento de emissão |
| Luz | `r6_total=4` continua obrigatório |
| Física | Sem colisor ou bloqueio novo no trilho Majestic→R6 |
| Handoff | R6→R7 preservado, sem construção de R7 |
| QA | Parser, orçamento R6, prova de handoff e todas as rotas R6 antes do PR |

## Sucessão obrigatória

A esteira mantém uma única issue `[Dev6 Continuous]` e encerra automaticamente qualquer item Dev6 anterior quando o `task_id` avançar. O fecho de `DEV6-R6-APPROACH-FRAMING-006` exige commit publicado, porta R6 aprovada e nova tarefa `ACTIVE`.
