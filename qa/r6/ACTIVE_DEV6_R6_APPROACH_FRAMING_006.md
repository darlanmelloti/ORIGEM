# ORIGEM — DEV6-R6-APPROACH-FRAMING-006

**Estado:** ACTIVE
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas
**Tarefa anterior:** DEV6-R6-SHORELINE-LEGIBILITY-005

## Objetivo ativo

Validar que a chegada às Ruínas Submersas enquadra de modo coerente a bacia, a estela `RuneP0_02`, a linha de água arqueológica e o primeiro plano de ruínas no renderer `gl_compatibility`. O objetivo é de observabilidade e composição da chegada, não de ampliação de escopo.

## Restrições obrigatórias

| Área | Regra |
|---|---|
| R6 | Alterações somente dentro da fronteira regional das Ruínas Submersas |
| Água | Sem shader adicional, painel ou aumento de emissão |
| Luz | Orçamento regional fixado em quatro luzes |
| Física | Sem colisor ou bloqueio novo no trilho Majestic→R6 |
| Handoff | R6→R7 preservado, sem geometria antecipada de R7 |
| QA | Parser, quatro luzes, handoff e três rotas R6 antes da publicação |

## Gatilho de correção

Só pode ser aplicada correção causal se uma captura runtime repetir o enquadramento insuficiente e a mudança for exclusivamente visual, não-colisível e verificável por rota. Se o enquadramento já for suficiente, registrar evidência e avançar a tarefa sem modificar produção.
