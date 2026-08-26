# Dev6 — Contrato de Trabalho Contínuo das Ruínas Submersas

> **Regra operacional:** uma porta R6 aprovada nunca encerra o Dev6. Cada entrega validada deve publicar e substituir a tarefa atual por uma nova tarefa em estado `ACTIVE`.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV6-R6-ROUTE-TARGET-TELEMETRY-009
owner: Dev6
branch: dev6/r6-submerged-ruins
```

## Limites regionais permanentes

A R6 mantém a âncora cartográfica `(60, 252)`, a ligação Majestic→margem, a bacia navegável, ruínas, filetes de cascata em geometria 3D e a leitura física para a futura Vila Elevada. A R7 não pode ser construída antecipadamente. Não criar portão, corredor artificial, painel, parede, `Light3D` adicional, emissão de água como substituto de geometria ou mudança em `CartographicAnchors.gd`.

O orçamento R6 é exactamente quatro luzes: duas luzes mundiais da bacia, preenchimento de margem e preenchimento submerso central. A sonda `inspect_r6_light_budget.gd` é obrigatória em cada entrega.

## Entrega aprovada — DEV6-R6-WATERLINE-READING-003

A composição `R6_DetritosLinhaDeAgua` acrescenta nove detritos arqueológicos assimétricos de margem no `ForestLakeRegion.gd`. Os elementos são exclusivamente visuais, ficam fora da elipse de água e do corredor Majestic→R6, e não introduzem luzes, shader, emissão, painel ou colisores.

## Entrega aprovada — DEV6-R6-SHORELINE-LEGIBILITY-005

A composição `R6_LeituraArqueologicaDaMargem` adiciona um fragmento de coluna e duas pedras assimétricas na margem exterior oeste. Os três vestígios ficam fora da elipse de água e do trilho, não têm corpos físicos, luzes, shader, emissão ou painel.

## Entrega aprovada — DEV6-R6-APPROACH-FRAMING-006

A auditoria comparou capturas da chegada R6 em `gl_compatibility` e não demonstrou causa nova de produção. Nenhuma geometria, água, luz, shader, emissão, física ou R7 foi alterada.

## Entrega aprovada — DEV6-R6-RUNTIME-CAPTURE-PROTOCOL-007

A sonda `capture_r6_arrival_runtime.sh` aguarda o spawn da chegada, estabiliza o viewport e captura evidência 1600×900. A sonda `inspect_r6_runtime_composition.gd` confirma água, estela, nove detritos, três vestígios de margem, domo, oito pilares, três marcos emergentes, zero luzes e zero colisores no conjunto de margem. Duas execuções consecutivas produziram a mesma telemetria.

## Entrega aprovada — DEV6-R6-CAPTURE-MATRIX-008

A matriz `capture_r6_route_matrix.sh` executa `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`, produzindo uma captura 1600×900 e o mesmo inventário de composição R6 para cada rota. A extensão é exclusivamente QA e não altera produção, câmera, água, luz, shader, emissão, física, handoff ou R7.

| Critério | Resultado |
|---|---|
| Rotas | Três spawns confirmados e três capturas pós-carregamento criadas |
| Composição | Água, estela, 9 detritos, 3 vestígios, domo, 8 pilares e 3 marcos confirmados |
| Restrições | 0 luzes e 0 colisores no conjunto de margem |
| QA | Parser, orçamento, handoff e três rotas R6 aprovados |

## Tarefa ativa — DEV6-R6-ROUTE-TARGET-TELEMETRY-009

Criar uma sonda QA que registe, para `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`, o spawn reconhecido, o alvo/foco publicado pela telemetria de rota e a distância horizontal do vetor de aproximação. A sonda deve consumir logs já emitidos pelo runtime e não modificar a lógica das rotas.

| Critério | Obrigatório |
|---|---|
| Produção | Não alterar `ForestLakeRegion.gd`, `TempleLevel.gd`, R7–R12 ou âncoras cartográficas |
| Rotas | Não teletransportar, não reposicionar e não alterar `look_at` de produção |
| Água e luz | Sem shader, painel, emissão ou `Light3D` novo |
| Física | Sem `StaticBody3D`, `CollisionShape3D` ou modificação de corredor |
| Evidência | Extrair apenas telemetria emitida após o spawn de cada rota |
| QA | Parser, orçamento R6, handoff e três rotas aprovados antes do PR |

## Sucessão obrigatória

A esteira mantém uma única issue `[Dev6 Continuous]` e encerra automaticamente qualquer item Dev6 anterior quando o `task_id` avançar. O fecho de `DEV6-R6-ROUTE-TARGET-TELEMETRY-009` exige commit publicado, porta R6 aprovada e nova tarefa `ACTIVE`.
