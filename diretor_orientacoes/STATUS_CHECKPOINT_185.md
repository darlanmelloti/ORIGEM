# ORIGEM — Checkpoint 185: Variação de Altura das Coníferas da Floresta Densa

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `f7480ed` — `feat(forest): vary pine height scale Y 0.85-1.35 for visual diversity`.

## Incremento aplicado

As 104 coníferas da Floresta Densa passaram a ter uma escala Y independente da escala XZ. O fator de variação `height_var` é calculado de forma determinística a partir do índice de cada árvore (`0.85 + fmod(float(index * 13 + 7), 50.0) / 100.0`), produzindo uma gama de 0.85–1.35 sem aleatoriedade por frame. A escala XZ mantém-se em `tree_scale` para preservar a silhueta de copa sem alargar os troncos.

Os colisores de tronco foram atualizados para usar `trunk_height = maxf(2.3, 7.2 * tree_scale * height_var)`, mantendo a consistência física com a nova altura visual.

| Parâmetro | Antes | Depois |
|---|---|---|
| Escala Y das coníferas | Igual à escala XZ | `tree_scale × height_var` (0.85–1.35) |
| Escala XZ das coníferas | `tree_scale` | `tree_scale` (inalterada) |
| Altura do colisor | `7.2 × tree_scale` | `7.2 × tree_scale × height_var` |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 3 | `origem_v2_phase116_take3_forest_wayfinding.png` | Silhueta da floresta com diversidade vertical visível. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase185_PineHeightVariation_Validated.zip`

SHA-256:

`cadd731bb6450ffb18b5d8bdc7801bb0273e571a2d5a3ccf6fbe1c190885ef75`

## Próximas prioridades (por ordem de impacto visual)

1. **Pedras no leito do rio** — 3–4 rochas submersas para leitura de profundidade na Estrada do Rio (`RiverRoadJourney.gd`).
2. **Auditoria de Takes 1–9** — recapturar e confirmar que todos os refinamentos dos CPs 144–185 são visíveis nos enquadramentos cinematográficos.
3. **Variação de rotação das lajes de percurso** — pequenas rotações aleatórias nas lajes da Floresta Densa para naturalizar o pavimento.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
