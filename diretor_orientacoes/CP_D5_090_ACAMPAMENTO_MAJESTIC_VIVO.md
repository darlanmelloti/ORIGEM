# CP-D5-090 — Acampamento Majestic Vivo R5

## Objectivo

Dar vida tridimensional ao marco cartográfico do Acampamento Majestic através de uma clareira orgânica, fauna ambiental e um abrigo de pedra colapsado, mantendo o pavilhão Majestic como referência espacial e preservando o corredor de Elias.

## Implementação QA isolada

A cena `R5LivingMajesticPreview.tscn` combina o pavilhão existente com dois cervos CC0, sete elementos de vegetação aterrada e três peças de abrigo desabado. A composição respeita o desvio lateral do Majestic e usa apenas uma luz dinâmica.

| Contrato | Resultado |
|---|---|
| Fauna | 2 cervos CC0 com movimento ambiental leve |
| Vegetação | 1 pinheiro PBR, 2 árvores detalhadas, 2 leves e 2 fetos |
| Construção | Pavilhão real e abrigo colapsado; sem cairn |
| Grounding | 13 instâncias por raycast, com X/Z preservados |
| Corredor de Elias | 2 ciclos QA sem bloqueio |
| Luzes dinâmicas | 1, dentro do orçamento GTX 1050 Ti |
| Produção R1–R6 | Não modificada |

O parser Godot 4.7.1 e uma sessão QA de 36 segundos passaram sem erros de parse, runtime ou asserção. A evidência visual é `qa_evidence_dev5_r5_living/r5_living.png`.

## Limite de promoção

A composição é aprovada como candidato QA para a leitura viva de R5. Não deve ser copiada para `ForestLakeRegion.gd` sem revisão do Dev1 sobre densidade, rota final e enquadramento cinematográfico.

## Próxima tarefa contínua

**CP-D5-091 — Estrada do Rio viva R2.** Construir uma composição QA com a ponte modular, vegetação de margem, fauna afastada do tabuleiro e vestígios de abrigo sem repetir a ponte GLB rejeitada.
