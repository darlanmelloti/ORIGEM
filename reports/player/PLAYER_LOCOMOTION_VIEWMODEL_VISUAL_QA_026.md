# ORIGEM — QA de Movimento, Câmara e Espada 026

**Frente:** Dev1 — Jogador e interação em primeira pessoa
**Referência de trabalho:** `integration/r1-r6-sprint1` em `d3bbf0d` antes desta correção
**Estado:** correção candidata validada localmente; ainda não publicada

## Evidência observada

A gravação fornecida pelo Diretor mostrava uma leitura de Elias excessivamente baixa, com a espada a entrar visualmente no solo quando a câmara apontava para baixo. A reprodução automatizada confirmou que a locomoção física horizontal já funcionava, mas revelou dois fatores que reforçavam essa perceção: o nó `Head` era reinicializado a `y=0.0` em tempo de execução e o viewmodel da espada ocupava demasiada profundidade e queda local.

A correção aplica uma altura mínima de olhos de `0.88 m` sem deslocar a cápsula do jogador, o terreno ou os seus colisores. A espada passou para uma posição compacta no canto inferior direito, em `(0.68, -0.42, -0.75)`, escala `0.44`, com compensação de inclinação de `0.75` para não mergulhar visualmente no terreno ao olhar para baixo.

## Capturas QA

| Captura | Resultado observado |
|---|---|
| `qa/player/player_view_after_fix.png` | A vista frontal mantém o trilho e o Arco legíveis; a espada fica no canto inferior direito e não toca o solo. |
| `qa/player/player_downward_view_after_fix.png` | A vista com inclinação de `-82°` mantém terreno visível e não apresenta espada a atravessar o solo. |

## Resultados automatizados

| Prova | Resultado |
|---|---|
| `QA-PLAYER-LOCO-026` | PASS: grounded, melhor deslocamento horizontal `3.469 m`, altura de olhos `0.88 m`, alcance descendente do viewmodel `1.17 m`. |
| `QA-GROUND-01` | PASS: `180` frames grounded, sem variação vertical pós-aquecimento. |
| Porta regional R2 | PASS: parser, física, rotas e orçamento R2 preservados. |
| Porta regional R4 | PASS: rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` preservadas. |
| Porta regional R6 | PASS: rota `ruins_arrival`, limites de luz e continuidade do lago preservados. |

## Limites preservados

A correção não altera `CartographicAnchors`, rotas, colisores do jogador, terreno, luzes, orçamento GTX 1050 Ti, água, materiais regionais nem regras narrativas. A prova QA adicional só é injetada quando `ORIGEM_QA_PLAYER_LOCOMOTION` está definido e não se ativa em gameplay normal.

## Próximo passo

A correção foi publicada na PR #504 para CI regular. A versão Windows será gerada somente após a revisão e os checks obrigatórios concluírem com sucesso.
