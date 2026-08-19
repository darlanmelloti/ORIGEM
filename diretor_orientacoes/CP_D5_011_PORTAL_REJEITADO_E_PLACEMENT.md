# CP-D5-011 — Portal Floresta: rejeitado; ferramenta de colocação aprovada

**Marco de origem:** 4 — Floresta Densa, âncora `(-9; 116)`.  
**Resultado do portal QA:** rejeitado antes de integração.  
**Resultado da ferramenta `CartographicPlacementSystem`:** aprovado para uso Dev5.

O portal florestal foi avaliado em duas versões: uma com troncos procedurais e outra com pinheiros PBR e fetos locais. Ambas preservaram a passagem central e usaram geometria tridimensional, mas não superaram o limiar visual: a primeira parecia uma estrutura de troncos; a segunda passou a ler como uma parede de árvores, contrária ao conceito de floresta navegável. O código QA do portal foi revertido e nenhum módulo de produção foi alterado.

A frente Dev5 não pára: foi implementada a ferramenta `levels/dev5/CartographicPlacementSystem.gd`. Ela transforma objectos candidatos em registos auditáveis contendo marco, posição X/Z do mundo, posição no canvas do mapa e deslocamento local máximo permitido. A cena `CartographicPlacementPreview.tscn` validou as seis âncoras R1–R6 durante 36 segundos; o log confirmou as posições canónicas:

| Marco | Mundo X/Z | Canvas do mapa |
|---|---:|---:|
| 1 — Casa Voss | `(-22; 8)` | `(80; 452)` |
| 2 — Estrada do Rio | `(-21,4; 12)` | `(234; 462)` |
| 3 — Arco das Ruínas | `(-16,741; 48)` | `(362; 463)` |
| 4 — Floresta Densa | `(-9; 116)` | `(334; 244)` |
| 5 — Acampamento Majestic | `(-88; 178)` | `(187; 258)` |
| 6 — Ruínas Submersas | `(60; 252)` | `(408; 351)` |

> A ferramenta é uma aceleração real do processo: cada novo objecto Dev5 terá uma ficha espacial exacta antes da sua cena QA e nunca poderá ser colocado apenas por intuição visual.

## Continuidade

A próxima tarefa é **CP-D5-012 — catálogo de inserção R1–R6**. Dev5 deve criar fichas de objectos 3D prioritários por marco, usando `CartographicPlacementSystem`, seleccionando primeiro candidatos que tenham activos reais locais e não repliquem os ensaios QA rejeitados.
