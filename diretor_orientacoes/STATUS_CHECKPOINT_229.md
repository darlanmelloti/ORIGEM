# CP 229 — Orientação Cartográfica para o Arco

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** interface de mapa e rota Dev1 Casa Voss → Estrada → Arco.

## Alteração

A cartografia jogável passou a indicar o **Arco das Ruínas** como destino inicial por meio de um marcador âmbar e da legenda `RUMO AO ARCO`. O destino é calculado a partir da âncora `ARCO_RUINAS`, tal como o marcador de Elias é calculado a partir da posição real do jogador.

| Elemento | Função |
|---|---|
| Marcador azul `ELIAS` | Mostra a posição actual no mundo 3D. |
| Marcador âmbar `RUMO AO ARCO` | Indica a próxima leitura espacial da rota inicial. |
| Cartografia 4:3 | Mantém o mapa completo, os dois marcadores e a legenda visíveis. |

A indicação não fixa waypoints no mundo, não modifica colisores e não impede exploração livre. Serve apenas para reforçar que o mapa oficial e o vale físico representam a mesma geografia.

## Validação

| Prova | Resultado |
|---|---|
| Mapa aberto após Novo Jogo | Aprovado |
| Elias e destino Arco visíveis no mapa | Aprovado |
| Arranque headless Godot 4.7.1 | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 230 — Rota cartográfica Arco → Floresta.** O próximo ciclo introduz a leitura de continuidade para a Floresta Densa depois do Arco, mantendo o destino actual discreto e sem bloquear a descoberta do mundo.
