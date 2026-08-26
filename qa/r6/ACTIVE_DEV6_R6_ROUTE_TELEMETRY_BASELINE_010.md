# ORIGEM — DEV6-R6-ROUTE-TELEMETRY-BASELINE-010

**Estado:** ACTIVE
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas
**Tarefa anterior:** DEV6-R6-ROUTE-TARGET-TELEMETRY-009

## Objetivo ativo

Consolidar os vetores aprovados de `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` como baseline QA versionada e criar uma verificação de desvio tolerante. A verificação deve comparar somente telemetria runtime já emitida, sem alterar o jogo.

## Restrições obrigatórias

| Área | Regra |
|---|---|
| Produção | Não alterar `ForestLakeRegion.gd`, `TempleLevel.gd`, R7–R12 ou âncoras cartográficas |
| Rotas | Não modificar spawn, alvo, velocidade, `look_at` ou corredor físico |
| Água e luz | Sem shader, painel, emissão ou `Light3D` novo |
| Física | Sem `StaticBody3D`, `CollisionShape3D` ou alteração de lajes |
| QA | Baseline e tolerância explícitas; falhar em log ausente ou desvio não permitido |
| Validação | Parser, orçamento R6, handoff e três rotas aprovados antes do PR |

## Regra de fechamento

A tarefa pode avançar quando a baseline for gerada e uma execução atual passar na verificação sem modificação de produção. Uma nova tarefa `ACTIVE` deve substituir o `task_id` no contrato canônico.
