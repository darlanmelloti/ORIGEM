# ORIGEM — Seleção de Incrementos Ambientais Pós-Captura

## Decisão

As capturas runtime confirmaram que o próximo ciclo não deve repetir ajustes estáticos abstratos. Cada frente recebeu um alvo distinto, modular e verificável, sem misturar QA, produção, cartografia ou física.

| Região | Próxima tarefa proposta | Natureza | Limite principal |
|---|---|---|---|
| R4 | `DEV4-R4-CARTOGRAPHIC-INLET-MATERIAL-ISOLATION-044` | Diagnóstico QA do afluente | Não alterar material partilhado nem água R6 antes de uma prova de isolamento |
| R5 | `DEV5-R5-CAMP-COMPOSITION-PROBE-026` | Sonda QA de enquadramento do núcleo existente | Não alterar a câmara de jogo, colisores, luzes ou conectores |
| R6 | `DEV6-R6-MIDGROUND-ARCHAEOLOGY-COMPOSITION-014` | Ajuste estático em vestígios existentes | Exatamente quatro luzes, água/handoff/rotas imutáveis |

## R4

A superfície opaca visível em `arch_to_forest` coincide com o afluente cartográfico que utiliza `_create_lake_material()`. O material é partilhado com a R6, por isso qualquer alteração direta seria transversal e prematura. A tarefa seguinte deve produzir uma cena/prova de isolamento ou uma captura controlada que determine se a opacidade vem do material, da geometria ou da configuração de captura. Não deve tocar no mundo de produção.

## R5

As capturas canónicas validam a rota, mas não enquadram o núcleo do acampamento de forma suficiente para decisão artística. A tarefa seguinte deve criar uma sonda QA de composição que observe o núcleo R5 existente com um olhar de teste determinístico, sem alterar a `Camera3D` do jogador nem artefactos de produção.

## R6

A dívida visual R6 é real e está delimitada: lajes, terreno aberto e vestígios ficam demasiadamente isolados no plano médio. A próxima entrega de produção pode reorientar/escalar apenas três a cinco vestígios existentes da chegada, com prova própria de bases preservadas, zero nós/luzes/física novos, orçamento de quatro luzes, handoff e três rotas.
