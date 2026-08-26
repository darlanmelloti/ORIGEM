# ORIGEM — DEV6-R6-RUNTIME-CAPTURE-PROTOCOL-007

**Estado:** ACTIVE
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas
**Tarefa anterior:** DEV6-R6-APPROACH-FRAMING-006

## Objetivo ativo

Criar uma sonda QA determinística para a chegada R6 que espere pelo mundo, recolha uma captura pós-carregamento em `gl_compatibility` e registe os nós de composição relevantes. A sonda existe apenas para tornar as evidências de runtime repetíveis; não integra a experiência jogável.

## Critérios obrigatórios

| Área | Regra |
|---|---|
| Código de produção | Nenhuma alteração em `levels/ForestLakeRegion.gd`, `TempleLevel.gd` ou R7–R12 |
| Runtime | Esperar a instância de R6 e a conclusão de frames antes da captura |
| Evidência | Registrar água, estela, detritos, composição de margem, pilares e domo por nome e posição |
| Luz | Confirmar `r6_total=4` sem criar `Light3D` |
| Física | Não criar colisores nem alterar rotas |
| QA | Parser, orçamento R6, handoff e três rotas R6 antes do PR |

## Regra de fechamento

A tarefa só pode avançar quando a sonda produzir uma evidência repetível ou quando um bloqueio de engine for documentado com log. A substituição do `task_id` exige nova tarefa em `ACTIVE`.
