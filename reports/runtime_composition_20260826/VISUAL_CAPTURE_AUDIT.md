# Auditoria Visual de Capturas Runtime — R4/R5

## R4 — `arch_to_forest`

A captura confirma que a transição possui massa arbórea e um marco de árvore dominante, mas revela uma **superfície opaca clara de grande escala** a atravessar o primeiro plano. A aparência não corresponde a leitura natural de trilho ou terreno e deve ser investigada como risco visual antes de propor nova decoração. Também se observam suportes e marcadores de QA visíveis no enquadramento; estes devem ser distinguidos de conteúdo de produção.

## R4 — `forest_to_majestic`

A captura confirma a continuidade física do caminho de lajes até ao acampamento e não mostra a mesma superfície opaca no primeiro plano. A composição continua muito aberta, com poucos agrupamentos ambientais laterais e objetos isolados; isto é dívida visual de produção, não falha de rota.

## Limites imediatos

Nenhuma correção deve mover lajes, alterar corredores, criar parede de árvores, introduzir luz, colisores ou afetar a clareira Orion. A próxima ação segura é localizar o nó/material que gera a superfície clara observada em `arch_to_forest` e confirmar se é defeito de captura, recurso de água, marcador QA ou geometria de produção.

## R5 — `majestic_to_lake`

A captura confirma rota física, lajes e relevo, mas o enquadramento canónico privilegia a saída para a bacia e não apresenta o núcleo do Acampamento Majestic. Assim, ela é válida como evidência de regressão de rota, mas insuficiente para escolher uma melhoria artística do acampamento. A próxima captura R5 deve usar uma sonda QA de composição que observe o núcleo existente sem alterar a câmara de jogo.

## Diagnóstico técnico preliminar R4

A superfície opaca clara de `arch_to_forest` coincide espacialmente com a entrada do afluente cartográfico R4→R6. O afluente usa o material lacustre partilhado `_create_lake_material()`, configurado com `depth_draw_opaque` e `ALPHA = 1.0`. A relação é uma hipótese técnica a confirmar em captura de isolamento: não se deve alterar este material, pois ele é partilhado pela água R6 e qualquer mudança requer validação conjunta de R4/R6, orçamento de quatro luzes, handoff e rotas.
