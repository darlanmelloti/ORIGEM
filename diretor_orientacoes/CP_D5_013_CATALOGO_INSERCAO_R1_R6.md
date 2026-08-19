# CP-D5-013 — Catálogo de inserção 3D R1–R6

**Autoridade espacial:** `levels/CartographicAnchors.gd` e `MAP.webp`.  
**Ferramenta obrigatória:** `levels/dev5/CartographicPlacementSystem.gd`.  
**Estado:** catálogo de preparação; nenhum item desta página é integração automática.

> Dev5 usa este catálogo para transformar cada objecto novo numa proposta espacial mensurável. Cada candidato deve permanecer a no máximo 36 m da sua âncora, usar zero luzes dinâmicas e passar parser Godot + 36 segundos de cena QA antes de ser submetido ao proprietário Dev1.

## Catálogo prioritário

| Prioridade | Marco | Âncora X/Z | Proposta Dev5 | Deslocamento local X/Z | Activo ou base real | Orçamento/colisão | Proprietário de integração | Estado |
|---:|---|---:|---|---:|---|---|---|---|
| 1 | 2 — Estrada do Rio | `(-21,4; 12)` | Ponte secundária sobre o rio, orientada para o Arco | `(0; +16)` | `assets/models_cc0/bridge_stone.glb` + candidato `StoneBridgeLandmarkPreview` | Auditar malha antes da integração; colisão de tabuleiro contínua; 0 luzes | Dev1 — `RiverRoadJourney.gd` | Candidato QA aprovado; revisão Dev1 prioritária |
| 2 | 6 — Ruínas Submersas | `(60; 252)` | Cais de lajes quebradas e colunas parciais | `(-6; +2)` | `stone_largeA/B.glb`, `stone_tallC.glb` + `SubmergedRuinsPierPreview` | Colisão apenas nas lajes transitáveis; água não emissiva; 0 luzes | Dev1 — `ForestLakeRegion.gd` | Candidato técnico; aguarda captura visual própria |
| 3 | 1 — Casa Voss | `(-22; 8)` | Anexo de apoio da Casa Voss, fora do eixo da porta | `(+5; -3)` | `VossWaystationPreview` volumétrico | Colisão das paredes e cobertura; não interceptar a saída; 0 luzes | Dev1 — `VossHouse.gd` | Candidato QA aprovado |
| 4 | 5 — Acampamento Majestic | `(-88; 178)` | Pavilhão de lona e madeira do acampamento | `(+5; -4)` | `MajesticPavilionPreview` | Colisão de postes e estrado; sem lanternas novas; 0 luzes | Dev1 — `ForestLakeRegion.gd` | Candidato QA aprovado |
| 5 | 4 — Floresta Densa | `(-9; 116)` | Portal/clareira de entrada com vegetação lateral | `(+2; +5)` | `ez_pine_tall_pbr.glb`, `ez_pine_medium_pbr.glb`, `fern_02_1k.gltf` | Medir malhas antes da integração; colisores só laterais; corredor livre ≥2,4 m | Dev1 — `ForestLakeRegion.gd` | Candidato técnico remoto; captura visual pendente |
| 6 | 3 — Arco das Ruínas | `(-16,741; 48)` | Complementos de pedra somente se superarem o arco actual | `(0; 0)` | `cliff_*`, `stone_*`; candidato de arco Dev5 rejeitado | Nenhuma duplicação do arco; só revisão A/B; 0 luzes | Dev1 — `RiverRoadJourney.gd` | Sem integração activa |

## Fichas espaciais verificáveis

| Marco | Objecto de teste | Posição mundial calculada | Posição no canvas do mapa | Desvio da âncora |
|---|---|---:|---:|---:|
| 1 | `voss_waystation` | `(-17; terreno; 5)` | `(80; 452)` | `5,83 m` |
| 2 | `bridge_secondary` | `(-21,4; terreno; 28)` | `(234; 462)` | `16,00 m` |
| 3 | `arch_review` | `(-16,741; terreno; 48)` | `(362; 463)` | `0,00 m` |
| 4 | `forest_portal_review` | `(-7; terreno; 121)` | `(334; 244)` | `5,39 m` |
| 5 | `majestic_pavilion` | `(-83; terreno; 174)` | `(187; 258)` | `6,40 m` |
| 6 | `submerged_pier` | `(54; terreno; 254)` | `(408; 351)` | `6,32 m` |

## Regras de aceleração

1. **Activos reais primeiro.** Antes de gerar primitives, procurar os GLB/GLTF locais deste catálogo; a cena QA deve comprovar que o activo não cria uma parede, outdoor ou obstáculo.
2. **Uma proposta por vez.** Dev5 prepara o candidato e a ficha; Dev1 decide a integração apenas depois da comparação no mundo real.
3. **Sem espera externa.** Falta de modelo humano rigado, decisão de integração ou CAPTCHA nunca impede o próximo candidato QA ou a próxima ficha espacial.
4. **Sem regiões alheias.** O catálogo limita-se a R1–R6. Qualquer proposta R7–R12 continua a pertencer a Dev2.
5. **Registo automático.** Ao concluir a ficha ou cena QA, actualizar `CONTINUIDADE_DEV5.md` e abrir a tarefa seguinte no mesmo commit.

## Próxima tarefa automática: CP-D5-014

Criar um **auditor de orçamento de malha Dev5** que inventarie triângulos, nós de colisão e materiais dos GLB/GLTF locais antes de uma integração. O auditor deve funcionar em cena QA e não pode alterar objectos de produção.
