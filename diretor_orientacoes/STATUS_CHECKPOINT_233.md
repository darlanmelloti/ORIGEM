# CP 233 — Handoff Cartográfico Ruínas → Vila Elevada

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** interface de mapa, Regiões 1–6 e indicação de handoff; nenhum módulo de Região 7–12 foi alterado.

## Alteração

Depois de Elias aproximar-se do marco das Ruínas Submersas, o mapa passa a exibir o destino `PASSAGEM: VILA ELEVADA`, posicionado na âncora `VILA_ELEVADA`. Esta alteração torna visível a continuidade geográfica entre a Bacia Central e a cidade elevada descrita no mapa cartográfico.

| Elemento | Estado |
|---|---|
| Geometria do handoff Dev1 | Mantida no lado permitido da Região 6. |
| Conteúdo da Vila Elevada | Não alterado; responsabilidade exclusiva Dev2. |
| Indicação no mapa | Mostra a passagem para o marco 7. |
| Exploração do jogador | Mantida sem bloqueio ou teleporte. |

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Mapa aberto após Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Fronteira Regiões 7–12 | Preservada |

## Próximo incremento autónomo

**CP 234 — Auditoria de escala e composição cartográfica Dev1.** O próximo ciclo compara a escala, a silhueta e a orientação dos seis marcos implementados com a planta oficial, preparando apenas refinamentos dentro das Regiões 1–6.
