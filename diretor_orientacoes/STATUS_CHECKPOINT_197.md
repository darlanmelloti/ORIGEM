# ORIGEM — Checkpoint 197: Preenchimento Frio do Corredor da Floresta Densa

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `35809f8` — `feat(forest): add cold fill lights in corridor for shadow zone legibility`.

## Incremento aplicado

Foi adicionada a função `_build_forest_corridor_fill()` ao `ForestLakeRegion.gd`, que posiciona 3 `OmniLight3D` de preenchimento frio ao longo do eixo central da Floresta Densa (z=100, 148, 196), a 4.5 m de altura, simulando luz de lua filtrada pelas copas. As luzes têm sombras desactivadas para não saturar o orçamento de GL Compatibility.

| Luz | Posição Z | Energia | Alcance | Cor |
|---|---|---|---|---|
| PreenchimentoFloresta_z100 | 100 | 0.58 | 17.0 m | Azul-céu frio `(0.52, 0.62, 0.78)` |
| PreenchimentoFloresta_z148 | 148 | 0.62 | 18.5 m | Azul-céu frio `(0.52, 0.62, 0.78)` |
| PreenchimentoFloresta_z196 | 196 | 0.55 | 16.0 m | Azul-céu frio `(0.52, 0.62, 0.78)` |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 3 | `origem_v2_phase116_take3_forest_wayfinding.png` | Lajes de percurso mais visíveis; fetos com contraste melhorado; variação de altura das coníferas legível. Avaliação: 88%. |
| Gameplay 30 s | Roteiro integrado | Aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida. |

## Preservação

Pacote: `/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase197_ForestCorridorFill_Validated.zip`

SHA-256: `93f80b3071cd0e3c2b37d2daca202ed6abc892edfd89eb66a1d08bc595395d2c`

## Próximas prioridades

1. **CP 198 — Solo do Arco das Ruínas (Take 2):** Escurecer o material do leito da estrada à frente do arco para harmonizar com o crepúsculo litúrgico.
2. **CP 199 — Margem inferior das Ruínas Submersas (Take 11):** Luz de preenchimento quente na margem sul para revelar as lajes de pedra molhada.
3. **Push de todos os commits pendentes** — 7 commits aguardam sincronização com o GitHub.

> O checkpoint é uma evidência, não uma pausa. O ciclo continua com o CP 198.
