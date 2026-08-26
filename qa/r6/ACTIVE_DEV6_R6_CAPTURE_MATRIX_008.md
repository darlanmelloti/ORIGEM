# ORIGEM — DEV6-R6-CAPTURE-MATRIX-008

**Estado:** ACTIVE
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas
**Tarefa anterior:** DEV6-R6-RUNTIME-CAPTURE-PROTOCOL-007

## Objetivo ativo

Estender a sonda de captura pós-carregamento para executar `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`, produzindo uma imagem 1600×900 e uma confirmação de composição para cada rota. A tarefa mede evidência; não modifica a experiência de jogo.

## Restrições obrigatórias

| Área | Regra |
|---|---|
| Produção | Não alterar `ForestLakeRegion.gd`, `TempleLevel.gd`, R7–R12 ou âncoras cartográficas |
| Câmara | Não alterar a câmera de produção nem a lógica de orientação das rotas |
| Água e luz | Sem shader, painel, emissão ou `Light3D` novo |
| Física | Sem `StaticBody3D`, `CollisionShape3D` ou alteração de corredor |
| Evidência | Esperar cada spawn de rota e registrar composição R6 após a captura |
| QA | Parser, orçamento R6, handoff e três rotas aprovados antes da publicação |

## Regra de fechamento

A tarefa só pode avançar quando as três rotas produzirem telemetria e capturas pós-carregamento ou quando um bloqueio específico for comprovado por log. Uma nova tarefa `ACTIVE` deve substituir este `task_id` no contrato canônico.
