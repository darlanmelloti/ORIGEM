# CP 219 — Limiar Cartográfico Arco → Floresta

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Regiões 3–4 — Arco das Ruínas e Floresta Densa.  
**Contrato aplicado:** `CONTRATO_CARTOGRAFICO_MUNDO_3D.md`.

## Alteração

Foi criado o nó `LimiarCartograficoDaFloresta` no `ForestLakeRegion.gd`. Quatro árvores focais, cinco rochas pequenas e cinco fetos constituem uma transição visual entre o Arco das Ruínas e a massa central da Floresta Densa. A distribuição deixa uma abertura central completa, não cria colisores e não acrescenta luzes dinâmicas.

A implementação reforça a relação topográfica indicada no mapa: o Arco é o limiar arqueológico; depois dele, Elias percebe uma floresta contínua e atravessável que conduz ao Acampamento Majestic e às Ruínas Submersas.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Colisores novos no corredor | Nenhum |
| Luzes dinâmicas novas | Nenhuma |
| Fronteira Regiões 7–12 | Não tocada |

## Próximo incremento autónomo

**CP 220 — Panorâmica cartográfica Floresta → Acampamento Majestic → Ruínas Submersas.** O próximo passe deve preservar o corredor e aumentar a leitura de que o Acampamento está no flanco ocidental e o lago/ruínas constituem o centro hídrico do mapa.
