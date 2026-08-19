# CP-D5-092 — Floresta Densa Viva R4

## Objectivo

Dar vida tridimensional ao marco da Floresta Densa com fauna ambiental, árvores em profundidade, vegetação aterrada e um abrigo de pedra lateral, sem recriar o portal florestal estrutural já rejeitado.

## Implementação QA isolada

`R4LivingForestPreview.tscn` apresenta dois cervos CC0 fora do corredor central, oito elementos de flora dentro dos limites LOD e duas pedras como vestígio de abrigo lateral. A rota de Elias continua aberta e nenhum elemento cria uma parede vegetal ou um lintel/portal sobre o caminho.

| Contrato | Resultado |
|---|---|
| Fauna | 2 cervos CC0 com movimento ambiental leve |
| Vegetação | 1 pinheiro PBR, 3 árvores detalhadas, 2 leves e 2 fetos |
| Construção | Abrigo lateral em 2 pedras reais; zero portal estrutural |
| Grounding | 12 instâncias por raycast, com X/Z preservados |
| Corredor de Elias | 3 ciclos QA sem bloqueio |
| Luzes dinâmicas | 1, dentro do orçamento GTX 1050 Ti |
| Produção R1–R6 | Não modificada |

O parser Godot 4.7.1 e uma sessão QA de 36 segundos passaram sem erros de parse, runtime ou asserção. A captura é `qa_evidence_dev5_r4_living/r4_living.png`.

## Limite de promoção

O resultado é aprovado como candidato QA para R4. A integração no mundo de produção depende da revisão Dev1 para confirmar densidade e enquadramento cinematográfico.

## Próxima tarefa contínua

**CP-D5-093 — Casa Voss viva R1.** Construir a composição QA exterior com anexo, horta/vegetação, fauna discreta e vestígio doméstico tridimensional, mantendo a rota Casa Voss→Estrada e sem tocar na porta ou na casa jogável de produção.
