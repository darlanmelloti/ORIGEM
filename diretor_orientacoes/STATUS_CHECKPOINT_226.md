# CP 226 — Bacia Central e Ruínas Submersas

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Regiões 5–6; nenhuma alteração em módulos ou activos das Regiões 7–12.

## Alteração

A Bacia Central passou a usar a âncora `RUINAS_SUBMERSAS` como origem espacial única. O centro de água, a margem ocidental, as lajes de aproximação, a elipse de exclusão de árvores e a chegada física ao lago são agora derivados do mesmo marco que aparece como ponto 6 na cartografia do jogador.

| Sub-sistema | Relação com a âncora do lago |
|---|---|
| Centro da água e ruínas | Coordenadas directas do marco 6. |
| Margem e trilho de aproximação | Deslocamentos relativos ao marco 6. |
| Lajes e patamar de chegada | Termina na margem oeste relativa à bacia. |
| Exclusão de árvores | Elipse centrada na mesma âncora, preservando a leitura hídrica. |

A geometria final mantém a rota física até ao lago, a vista sobre as ruínas e a transição posterior para a Vila Elevada, sem atravessar a fronteira do Dev2.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Fronteira Regiões 7–12 | Preservada |

## Próximo incremento autónomo

**CP 227 — Ponte cartográfica Dev1–Dev2.** O próximo ciclo documenta e reforça visualmente a passagem Ruínas Submersas → Vila Elevada, limitando-se ao lado permitido da Região 6 e usando a âncora de handoff já definida.
