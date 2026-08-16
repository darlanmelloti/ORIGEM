# CP 231 — Continuidade Cartográfica Floresta → Majestic

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** interface de mapa e continuidade das Regiões 4–5.

## Alteração

A orientação âmbar do mapa agora acompanha três estados da rota inicial: Arco das Ruínas, Floresta Densa e Acampamento Majestic. Ao entrar suficientemente na massa florestal, o próximo destino é actualizado para a âncora `ACAMPAMENTO_MAJESTIC`, reforçando a estrutura 3 → 4 → 5 do mapa oficial.

| Progresso de Elias | Destino exibido |
|---|---|
| Antes do Arco | `RUMO AO ARCO` |
| Depois do Arco | `RUMO À FLORESTA` |
| Interior da Floresta | `RUMO AO MAJESTIC` |

A troca é exclusivamente cartográfica e não restringe a exploração, colisores ou movimentos do jogador.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Mapa aberto após Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 232 — Continuidade Majestic → Ruínas Submersas.** O ciclo seguinte deverá concluir a sequência cartográfica Dev1, orientando o jogador do Acampamento para a Bacia Central e as Ruínas Submersas, sem atravessar a fronteira da Região 7.
