# CP-D5-093 — Casa Voss Viva R1

## Objectivo

Dar vida ao exterior cartográfico de Casa Voss com um anexo técnico isolado, horta tridimensional, fauna discreta e vestígios domésticos, sem modificar a casa jogável, a porta ou o `Player.gd` de produção.

## Implementação QA isolada

`R1LivingVossExteriorPreview.tscn` apresenta o anexo Casa Voss aprovado, dois cervos CC0 afastados da soleira, um carvalho, dois fetos e duas pedras domésticas. Elias percorre a rota exterior na direcção da Estrada do Rio sem colidir com fauna, anexo ou horta.

| Contrato | Resultado |
|---|---|
| Fauna | 2 cervos CC0 fora da soleira e da rota |
| Horta | 1 carvalho, 2 fetos e 2 vestígios domésticos reais |
| Construção | Anexo Casa Voss aprovado em QA |
| Grounding | 8 instâncias por raycast, com X/Z preservados |
| Rota exterior | 3 ciclos QA sem bloqueio |
| Luzes dinâmicas | 1, dentro do orçamento GTX 1050 Ti |
| Produção | `VossHouse.gd`, porta e `Player.gd` não foram modificados |

O parser Godot 4.7.1 e uma sessão QA de 36 segundos passaram sem erros de parse, runtime ou asserção. A captura é `qa_evidence_dev5_r1_living/r1_living.png`.

## Limite de promoção

A composição é um candidato QA exterior. A integração na Casa Voss de produção exige revisão explícita do Dev1, sobretudo por a porta e a rota de saída serem áreas sensíveis.

## Próxima tarefa contínua

**CP-D5-094 — Arco das Ruínas vivo R3.** Construir uma composição QA do corredor R3 com flora de margem, fauna afastada e ruínas laterais em pedra, preservando a rota R3→R4 e sem construir um arco estrutural.
