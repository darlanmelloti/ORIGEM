# CP-CINE-21 — Matriz QA Orion na Cena Principal

Foram adicionados dois estágios QA à câmara já renderizável de `scenes/main.tscn`: `orion_entrada` e `orion_camara`. A matriz confirmou que a antiga leitura exterior continha o altar/câmara do Cube fora do contexto narrativo. A Câmara Orion passou a ser visível no jogo apenas quando Elias se encontra a 10,5 m do seu centro.

A captura de entrada ficou limpa: o altar e a emissão Chronos não surgem na montanha nem na boca da caverna. O estágio QA interno, activado exclusivamente por `ORIGEM_QA_ORION_REVEAL=1`, confirma que o Cubo é carregado e pode ser enquadrado. Contudo, a sua composição isolada — cubo sobre a massa de altar sem corredor/câmara concluídos — **não é aprovada como entrega artística**.

| Critério | Resultado |
|---|---|
| Cena principal usada para a captura | Aprovado |
| Altar e Cubo ocultos fora do raio físico de Elias | Aprovado |
| Prólogo normal e limpeza de marcadores | Preservados |
| Estágio QA de entrada Orion | Limpo, sem artefacto temporal prematuro |
| Composição final da Câmara Orion | Pendente de corredor e envolvente interior reais |

## CP-CINE-22 já iniciado

A próxima frente mantém o Cubo oculto no exterior e concentra-se numa envolvente interior física construída dentro do raio da Câmara, com uma leitura de altar só após o percurso explorável. Não serão aceites cubos expostos na superfície, volumes de ocultação, cartões, paredes planas ou geometrias suspensas.
