# CP 234 — Registo Cartográfico como Autoridade de Rota

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** `CartographicAnchors.gd`, interface de mapa e Regiões 1–6.

## Alteração

A progressão de destinos deixou de estar codificada na interface. A função `next_dev1_destination(player_z)` no registo `CartographicAnchors.gd` passou a ser a única autoridade da sequência Dev1, retornando a âncora, a legenda e o identificador do próximo marco.

| Faixa de progresso | Próximo marco oficial |
|---|---|
| Início / Estrada | Arco das Ruínas — marco 3 |
| Depois do Arco | Floresta Densa — marco 4 |
| Interior da Floresta | Acampamento Majestic — marco 5 |
| Depois do Acampamento | Ruínas Submersas — marco 6 |
| Aproximação à Bacia | Passagem Vila Elevada — marco 7, responsabilidade Dev2 |

Esta centralização permite que futuras câmaras, quests, HUDs e sistemas Dev2 consultem a mesma topologia em vez de manterem regras de destino duplicadas.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Mapa aberto após Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 235 — Auditoria visual de composição do mapa.** O ciclo seguinte verificará a relação entre os marcadores de jogador/destino e os marcos ilustrados, preservando a legibilidade em 1920×1080.
