# CP-D5-103 — Integração da Transição Viva R4→R5

## Contrato espacial

A transição preserva a saída da Floresta Densa em torno de `(-9,116)` e o desvio lateral do Acampamento Majestic em `(-88,178)`. A vegetação deve guiar a leitura da rota, mas nunca fechar o corredor ou transformar a passagem em portal.

| Camada | Aplicação | Limite |
|---|---|---|
| Saída R4 | Árvores leves e fetos laterais | Corredor central livre |
| Travessia | Solo húmido com variação contínua | Sem painéis, paredes ou trilho rígido |
| Chegada R5 | Pavilhão e abrigo lateral visíveis à distância | Preservar o desvio X cartográfico |
| Fauna | Aparição lateral, nunca no eixo | Sem colisor bloqueante |

## Sequência

1. Integrar primeiro vegetação de saída R4 e testar `arch_to_forest` por 36 segundos.
2. Adicionar marcadores de profundidade leves rumo ao Majestic e validar a chegada lateral.
3. Integrar pavilhão/fauna apenas após rota e leitura cartográfica estarem aprovadas.
4. Reverter o último lote se aparecer parede vegetal, perda do desvio Majestic ou bloqueio de Elias.
