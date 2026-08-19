# CP-D5-091 — Estrada do Rio Viva R2

## Objectivo

Dar vida tridimensional ao segundo marco cartográfico com ponte modular, margens orgânicas, fauna ambiental e vestígio de abrigo, preservando a travessia de Elias e a rejeição anterior da ponte GLB leve.

## Implementação QA isolada

`R2LivingRiverRoadPreview.tscn` usa a ponte modular de pedra já aprovada, dois cervos CC0 em margens opostas, vegetação ribeirinha aterrada e dois volumes de abrigo em pedra. O tabuleiro central fica livre, a fauna permanece afastada e a água é um volume local sob a ponte.

| Contrato | Resultado |
|---|---|
| Fauna | 2 cervos CC0, afastados do tabuleiro |
| Vegetação | 2 árvores e 2 fetos nas margens |
| Construção | Ponte modular e abrigo de pedra; zero ponte GLB |
| Grounding | 9 instâncias por raycast, com X/Z preservados |
| Travessia | 4 ciclos QA confirmados sem bloqueio |
| Luzes dinâmicas | 1, dentro do orçamento GTX 1050 Ti |
| Produção R1–R6 | Não modificada |

O parser Godot 4.7.1 e uma sessão QA de 36 segundos passaram sem erros de parse, runtime ou asserção. A captura final é `qa_evidence_dev5_r2_living_fixed/r2_living_fixed.png`.

## Limite de promoção

O resultado é um candidato QA. A integração na Estrada do Rio de produção exige revisão Dev1 para confirmar alinhamento com a rota real, água existente e composição cinematográfica.

## Próxima tarefa contínua

**CP-D5-092 — Clareira viva da Floresta Densa R4.** Construir composição QA de fauna discreta, árvores com profundidade e abrigo/ruína lateral, preservando o corredor aberto e sem recriar o portal florestal rejeitado.
