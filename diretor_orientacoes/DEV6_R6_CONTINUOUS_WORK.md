# Dev6 — Contrato de Trabalho Contínuo das Ruínas Submersas

> **Regra operacional:** uma porta R6 aprovada nunca encerra o Dev6. Cada entrega validada deve publicar e substituir a tarefa atual por uma nova tarefa em estado `ACTIVE`.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV6-R6-ROUTE-TELEMETRY-BASELINE-010
owner: Dev6
branch: dev6/r6-submerged-ruins
```

## Limites regionais permanentes

A R6 mantém a âncora cartográfica `(60, 252)`, a ligação Majestic→margem, a bacia navegável, ruínas, filetes de cascata em geometria 3D e a leitura física para a futura Vila Elevada. A R7 não pode ser construída antecipadamente. Não criar portão, corredor artificial, painel, parede, `Light3D` adicional, emissão de água como substituto de geometria ou mudança em `CartographicAnchors.gd`.

O orçamento R6 é exactamente quatro luzes: duas luzes mundiais da bacia, preenchimento de margem e preenchimento submerso central. A sonda `inspect_r6_light_budget.gd` é obrigatória em cada entrega.

## Entregas aprovadas

| Tarefa | Resultado consolidado |
|---|---|
| `DEV6-R6-WATERLINE-READING-003` | Nove detritos arqueológicos assimétricos fora da elipse de água e do corredor. |
| `DEV6-R6-SHORELINE-LEGIBILITY-005` | Fragmento de coluna e duas pedras na margem exterior; 0 luzes e 0 colisores no conjunto. |
| `DEV6-R6-APPROACH-FRAMING-006` | Auditoria sem causa nova de produção; nenhuma alteração adicional de geometria, água, luz, shader, emissão, física ou R7. |
| `DEV6-R6-RUNTIME-CAPTURE-PROTOCOL-007` | Captura pós-carregamento repetível e inventário runtime da composição R6. |
| `DEV6-R6-CAPTURE-MATRIX-008` | Três rotas R6 com capturas 1600×900 e inventários idênticos de composição. |
| `DEV6-R6-ROUTE-TARGET-TELEMETRY-009` | Extração QA de vetores de aproximação a partir dos logs existentes, sem modificar runtime. |

## Entrega aprovada — DEV6-R6-ROUTE-TARGET-TELEMETRY-009

A sonda `extract_r6_route_telemetry.sh` registrou os vetores horizontais aprovados: `forest_to_ruins` com `31.288 m`, `majestic_to_lake` com `85.107 m` e `ruins_arrival` com `50.257 m`. A extração falha em log ausente, formato inválido ou vetor nulo e preserva integralmente o jogo.

## Tarefa ativa — DEV6-R6-ROUTE-TELEMETRY-BASELINE-010

Consolidar os vetores aprovados de `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` como baseline QA versionada e criar uma verificação de desvio tolerante. A verificação deve comparar somente telemetria runtime já emitida, sem alterar o jogo.

| Critério | Obrigatório |
|---|---|
| Produção | Não alterar `ForestLakeRegion.gd`, `TempleLevel.gd`, R7–R12 ou âncoras cartográficas |
| Rotas | Não modificar spawn, alvo, velocidade, `look_at` ou corredor físico |
| Água e luz | Sem shader, painel, emissão ou `Light3D` novo |
| Física | Sem `StaticBody3D`, `CollisionShape3D` ou alteração de lajes |
| QA | Baseline e tolerância explícitas; falhar em log ausente ou desvio não permitido |
| Validação | Parser, orçamento R6, handoff e três rotas aprovados antes do PR |

## Sucessão obrigatória

A esteira mantém uma única issue `[Dev6 Continuous]` e encerra automaticamente qualquer item Dev6 anterior quando o `task_id` avançar. O fecho de `DEV6-R6-ROUTE-TELEMETRY-BASELINE-010` exige commit publicado, porta R6 aprovada e nova tarefa `ACTIVE`.
