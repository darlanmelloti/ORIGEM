# CP-D5-094 — Arco das Ruínas Vivo R3

## Objectivo

Dar vida ao corredor cartográfico R3 com fauna ambiental, flora de margem e ruínas laterais em pedra, preservando a rota para R4 e a rejeição do arco estrutural.

## Implementação QA isolada

`R3LivingArchCorridorPreview.tscn` posiciona dois cervos CC0 fora do corredor, duas árvores, dois fetos e duas pedras de ruína lateral. Elias percorre o corredor físico em direcção à Floresta Densa sem arco estrutural, portal ou redução da escala cartográfica.

| Contrato | Resultado |
|---|---|
| Fauna | 2 cervos CC0 fora do corredor |
| Vegetação | 2 árvores e 2 fetos em margens opostas |
| Construção | 2 ruínas laterais reais; zero arco estrutural |
| Grounding | 8 instâncias por raycast |
| Corredor R3→R4 | 3 ciclos QA sem bloqueio |
| Luzes dinâmicas | 1, dentro do orçamento GTX 1050 Ti |
| Produção | Módulos R1–R6 não alterados |

O parser Godot 4.7.1 e uma sessão QA de 36 segundos passaram sem erros de parse, runtime ou asserção. A captura é `qa_evidence_dev5_r3_living/r3_living.png`.

## Próxima tarefa contínua

**CP-D5-095 — Plano de integração do mapa vivo R1–R6.** Consolidar os candidatos QA de Casa Voss, Estrada, Arco, Floresta, Majestic e Ruínas numa ordem segura de integração pelo Dev1, com limites de LOD, colisão, rotas e evidências exigidas.
