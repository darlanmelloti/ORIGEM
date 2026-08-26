# ORIGEM — DEV6-R6-ROUTE-REGRESSION-PIPELINE-011

**Estado:** ACTIVE
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas
**Tarefa anterior:** DEV6-R6-ROUTE-TELEMETRY-BASELINE-010

## Objetivo ativo

Criar um único orquestrador QA que execute captura da matriz de rotas, extração da telemetria e verificação da baseline em sequência reprodutível. O pipeline deve aceitar diretório de evidência e não alterar a experiência de jogo.

## Restrições obrigatórias

| Área | Regra |
|---|---|
| Produção | Não alterar `ForestLakeRegion.gd`, `TempleLevel.gd`, R7–R12 ou âncoras cartográficas |
| Rotas | Não modificar spawn, alvo, velocidade, `look_at` ou corredor físico |
| Água e luz | Sem shader, painel, emissão ou `Light3D` novo |
| Física | Sem `StaticBody3D`, `CollisionShape3D` ou alteração de lajes |
| QA | Executar matriz, extração e baseline com falha imediata em qualquer etapa |
| Validação | Parser, orçamento R6, handoff e três rotas aprovados antes do PR |

## Regra de fechamento

A tarefa avança quando o pipeline produzir capturas, telemetria e baseline aprovadas numa execução completa. Uma nova tarefa `ACTIVE` deve substituir o `task_id` no contrato canônico.
