# Dev6 — Contrato de Trabalho Contínuo das Ruínas Submersas

> **Regra operacional:** uma porta R6 aprovada nunca encerra o Dev6. Cada entrega validada deve publicar e substituir a tarefa atual por uma nova tarefa em estado `ACTIVE`.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV6-R6-CAPTURE-MATRIX-008
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

## Entrega aprovada — DEV6-R6-APPROACH-FRAMING-006

A auditoria comparou as capturas da chegada R6 em `gl_compatibility` com a base anterior e confirmou que a entrega SHORELINE-005 não degradou a observabilidade. A variação observada pertence ao protocolo de captura e não demonstrou causa nova de produção; logo, nenhuma geometria, água, luz, shader, emissão, física ou R7 foi alterada.

| Critério | Resultado |
|---|---|
| Produção | Nenhuma alteração adicional necessária |
| Água e luz | Sem mudança; `r6_total=4` preservado |
| Física e handoff | Rota, lajes e R6→R7 preservados |
| QA | Parser, orçamento, handoff e três rotas R6 aprovados |

## Entrega aprovada — DEV6-R6-RUNTIME-CAPTURE-PROTOCOL-007

A sonda `capture_r6_arrival_runtime.sh` aguarda o spawn da chegada, estabiliza o viewport e captura evidência 1600×900. A sonda `inspect_r6_runtime_composition.gd` confirma água, estela, nove detritos, três vestígios de margem, domo, oito pilares, três marcos emergentes, zero luzes e zero colisores no conjunto de margem. Duas execuções consecutivas produziram a mesma telemetria.

| Critério | Resultado |
|---|---|
| Produção | Nenhuma alteração em gameplay, câmera, luz, água, física ou R7 |
| Runtime | Spawn pós-carregamento e captura 1600×900 repetíveis |
| Composição | Inventário R6 com todas as contagens esperadas |
| QA | Parser, orçamento, handoff e três rotas R6 aprovados |

## Tarefa ativa — DEV6-R6-CAPTURE-MATRIX-008

Estender a sonda de captura pós-carregamento para executar `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`, produzindo uma imagem 1600×900 e uma confirmação de composição para cada rota. A tarefa mede evidência; não modifica a experiência de jogo.

| Critério | Obrigatório |
|---|---|
| Produção | Não alterar `ForestLakeRegion.gd`, `TempleLevel.gd`, R7–R12 ou âncoras cartográficas |
| Câmara | Não alterar a câmera de produção nem a lógica de orientação das rotas |
| Água e luz | Sem shader, painel, emissão ou `Light3D` novo |
| Física | Sem `StaticBody3D`, `CollisionShape3D` ou alteração de corredor |
| Evidência | Esperar cada spawn de rota e registrar composição R6 após a captura |
| QA | Parser, orçamento R6, handoff e três rotas aprovados antes do PR |

## Sucessão obrigatória

A esteira mantém uma única issue `[Dev6 Continuous]` e encerra automaticamente qualquer item Dev6 anterior quando o `task_id` avançar. O fecho de `DEV6-R6-CAPTURE-MATRIX-008` exige commit publicado, porta R6 aprovada e nova tarefa `ACTIVE`.
