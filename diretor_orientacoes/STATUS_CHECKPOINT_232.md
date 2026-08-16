# CP 232 — Continuidade Cartográfica Majestic → Ruínas

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** interface de mapa e continuidade das Regiões 5–6.

## Alteração

A rota cartográfica dinâmica agora conclui os seis marcos do Dev1. Ao aproximar-se do Acampamento Majestic, o destino âmbar é transferido para a âncora `RUINAS_SUBMERSAS`, apresentando `RUMO ÀS RUÍNAS` e reforçando a sequência 5 → 6 do mapa oficial.

| Estado de rota | Destino no mapa |
|---|---|
| Estrada inicial | Arco das Ruínas |
| Depois do Arco | Floresta Densa |
| Interior da Floresta | Acampamento Majestic |
| Depois do Acampamento | Ruínas Submersas |

A rota permanece não invasiva: não bloqueia exploração, colisores, combate ou travessia para a fronteira da Vila Elevada.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Mapa aberto após Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 233 — Passagem de responsabilidade cartográfica.** O próximo ciclo mostrará no mapa a transição das Ruínas para a Vila Elevada como handoff Dev2, sem criar conteúdo nas Regiões 7–12.
