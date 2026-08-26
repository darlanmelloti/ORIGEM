# ORIGEM — DEV6-R6-ROUTE-TARGET-TELEMETRY-009

**Estado:** ACTIVE
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas
**Tarefa anterior:** DEV6-R6-CAPTURE-MATRIX-008

## Objetivo ativo

Criar uma sonda QA que registe, para `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`, o spawn reconhecido, o alvo/foco publicado pela telemetria de rota e a distância horizontal do vetor de aproximação. A sonda deve consumir logs já emitidos pelo runtime e não modificar a lógica das rotas.

## Restrições obrigatórias

| Área | Regra |
|---|---|
| Produção | Não alterar `ForestLakeRegion.gd`, `TempleLevel.gd`, R7–R12 ou âncoras cartográficas |
| Rotas | Não teletransportar, não reposicionar e não alterar `look_at` de produção |
| Água e luz | Sem shader, painel, emissão ou `Light3D` novo |
| Física | Sem `StaticBody3D`, `CollisionShape3D` ou modificação de corredor |
| Evidência | Extrair apenas telemetria emitida após o spawn de cada rota |
| QA | Parser, orçamento R6, handoff e três rotas aprovados antes do PR |

## Regra de fechamento

A tarefa avança apenas se as três rotas produzirem vetores e distâncias reprodutíveis, ou se uma rota não emitir a telemetria esperada com log preservado. Uma nova tarefa `ACTIVE` deve substituir o `task_id` no contrato canônico.
