# CP 230 — Continuidade Cartográfica Arco → Floresta

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** interface de mapa e continuidade das Regiões 3–4.

## Alteração

O destino âmbar do mapa deixou de ser estático. Enquanto Elias está antes do Arco das Ruínas, o mapa indica `RUMO AO ARCO`. Depois de ultrapassar a zona arqueológica, a mesma indicação muda para `RUMO À FLORESTA`, usando a âncora `FLORESTA_DENSA_ENTRADA`.

| Estado de rota | Âncora de destino | Leitura para o jogador |
|---|---|---|
| Antes de cruzar o Arco | `ARCO_RUINAS` | Continuidade Casa → Estrada → Arco. |
| Depois da zona do Arco | `FLORESTA_DENSA_ENTRADA` | Continuidade Arco → massa florestal do mapa. |

O jogador mantém liberdade total: a indicação não cria setas no mundo, não move o personagem e não bloqueia qualquer região.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Mapa aberto depois de Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 231 — Próximo marco cartográfico Majestic.** O ciclo seguinte deverá fazer a orientação avançar da Floresta Densa para o Acampamento Majestic, mantendo a sequência 4 → 5 → 6 do mapa oficial.
