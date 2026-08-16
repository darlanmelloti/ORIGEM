# CP 239 — Rota Completa Casa Voss → Vila Elevada

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Regiões 1–6 e interface cartográfica; nenhuma geometria das Regiões 7–12 foi alterada.

## Auditoria e correcção

A auditoria da rota confirmou que a implantação física dos marcos Dev1 já consulta o registo cartográfico. Foi encontrada uma lacuna de progressão no mapa: a orientação inicial apontava directamente para o Arco e omitia o marco jogável 2, **Estrada do Rio**.

A função central `CartographicAnchors.next_dev1_destination()` foi corrigida. Ao sair da Casa Voss, o primeiro destino passa a ser a Estrada do Rio; só depois a sequência avança para Arco, Floresta Densa, Acampamento Majestic, Ruínas Submersas e passagem da Vila Elevada.

| Ordem cartográfica | Marco | Estado |
|---:|---|---|
| 1 | Casa Voss | Implantação e spawn ligados à âncora oficial |
| 2 | Estrada do Rio | Restaurada como primeiro destino do mapa |
| 3 | Arco das Ruínas | Destino após a Estrada |
| 4 | Floresta Densa | Destino após o Arco |
| 5 | Acampamento Majestic | Destino após a Floresta |
| 6 | Ruínas Submersas | Destino após o Acampamento |
| 7 | Vila Elevada | Handoff visual e físico; conteúdo reservado a Dev2 |

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 240 — Auditoria visual dos marcos cartográficos.** O ciclo seguinte confirma em capturas de jogo que o marcador de Elias e os destinos são legíveis sem esconder o mundo ou comprometer a atmosfera.
