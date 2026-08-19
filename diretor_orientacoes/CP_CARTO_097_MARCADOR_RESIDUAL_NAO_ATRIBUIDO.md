# CP-CARTO-097 — Marcador Azul Residual: Investigação por Projecção

## Resultado

**PASS técnico; causa não atribuída.** A projecção foi corrigida para a janela real do artefacto, em torno de `(0.66, 0.44)`, e ampliada a `Light3D`. Foram executadas quatro exclusões QA independentes, sempre com 36 segundos de gameplay: a luz fria do Majestic, todo o contexto do Acampamento Majestic, os sinais P0 da floresta e os materiais azul-ciano dentro de 260 metros.

O marcador azul-ciano permaneceu em todas as comparações. As exclusões demonstram que ele não pertence à luz remota, ao Acampamento Majestic, aos sinais P0 nem a uma malha `StandardMaterial3D` azul dentro do alcance testado. Todas as sondas foram removidas de `TempleLevel.gd` e o harness voltou ao modo normal.

## Evidência

| Hipótese | Resultado | Evidência |
|---|---|---|
| Luar frio Majestic | Rejeitada | `road_to_arch_majestic_light_hidden/road_to_arch_36s.png` |
| Contexto Majestic | Rejeitado | `road_to_arch_majestic_context_hidden/road_to_arch_36s.png` |
| Sinais P0 | Rejeitados | `road_to_arch_p0_hidden/road_to_arch_36s.png` |
| Materiais azul-ciano remotos | Rejeitados | `road_to_arch_blue_range/blue_hidden.txt` e captura correspondente |

## Decisão

Nenhuma alteração de produção é autorizada a partir deste artefacto sem uma identificação de renderização por object ID. O refinamento ambiental deve prosseguir por causas que sejam visíveis, materiais e reversíveis, sem voltar a testar Majestic, P0, `MarcoRibeirinho`, `tree_oak_dark` ou filtros de material azul.
