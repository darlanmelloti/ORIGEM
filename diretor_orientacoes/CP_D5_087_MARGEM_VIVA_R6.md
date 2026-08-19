# CP-D5-087 — Margem Viva R6

## Objectivo

Transformar uma área QA da margem das Ruínas Submersas numa composição tridimensional com **vida orgânica, fauna e vestígio de construção**, mantendo a âncora cartográfica R6, o corredor de Elias e a exclusão explícita do cais de lajes rejeitado.

## Implementação QA isolada

A cena `R6LivingShorePreview.tscn` introduz dois cervos Quaternius em formato GLB sob licença CC0, quatro elementos vegetais aterrados e uma ruína colapsada construída com três pedras GLB existentes. A fauna desloca-se lentamente e volta a aterrar no relevo físico; nenhum dos elementos toca em módulos regionais de produção.

| Contrato | Resultado |
|---|---|
| Fauna tridimensional | 2 cervos CC0, com movimento ambiental leve |
| Vegetação | 2 carvalhos e 2 fetos, sem parede de árvores |
| Construção | 3 peças de ruína colapsada; não é arco, cairn ou cais |
| Grounding | 9 instâncias por raycast, com X/Z preservados |
| Rota de Elias | 3 ciclos QA sem bloqueio |
| Luzes dinâmicas | 1, dentro do orçamento GTX 1050 Ti |
| Produção R1–R6 | Não modificada |

A melhoria substitui o solo QA quadriculado por ruído procedural suavizado. A captura final é `qa_evidence_dev5_r6_living_smooth/r6_living_smooth.png`; o parser Godot 4.7.1 e uma sessão de 36 segundos passaram sem erro de parse, runtime ou asserção.

## Limite de promoção

Este resultado é **aprovado como candidato QA**, não como integração automática. Dev1 deve revisar a composição, posicionamento e impacto no percurso real antes de qualquer cópia para `ForestLakeRegion.gd`.

## Próxima tarefa contínua

**CP-D5-088 — Acampamento Majestic vivo R5.** Criar uma composição QA equivalente, com vegetação de clareira, fauna discreta e abrigo/ruína tridimensional, mantendo o pavilhão aprovado, o desvio lateral cartográfico e o corredor de Elias.
