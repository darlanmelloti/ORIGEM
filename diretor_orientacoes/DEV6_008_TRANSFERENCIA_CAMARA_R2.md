# DEV6-008 — Transferência de Câmara R2 para Dev1 e Dev3

## Objectivo de integração

Substituir a actual evidência de primeira pessoa da rota `road_to_arch` por uma tomada de terceira pessoa que revele simultaneamente Elias, a Estrada do Rio, as margens R2, o Arco das Ruínas e a profundidade cartográfica até z≈92.

| Condição | Valor ou limite | Proprietário |
|---|---|---|
| Harness | `ORIGEM_QA_ROUTE=road_to_arch` | Dev1 |
| Duração mínima | 36 segundos com entrada `W` contínua | Dev1 |
| Perspectiva | Terceira pessoa atrás de Elias | Dev1 / Dev3 |
| FOV | 52°–56° | Dev3 |
| Foco | Arco físico em z≈92, com a curva da estrada central | Dev3 |
| Composição | Elias inteiro, percurso no terço inferior, um plano lateral por lado | Dev3 |
| Rota e X/Z | Não alterar | Dev1 |
| Activos Dev6 | Conservar R2, 9 aterramentos e 0 luzes incrementais | Dev6 |
| Regiões 7–12 | Não carregar nem editar para a prova R2 | Dev1 / Dev3 |

## Critérios de aceitação da recaptura

A captura será aceite para revisão Dev6 apenas se preservar o percurso livre, a telemetria de 9/9 grounding e o orçamento de luzes, e se tornar inequívoca a relação espacial entre Elias, a Estrada do Rio e o Arco. Caso a tomada ainda exponha apenas arma/primeiro plano ou corte o corredor, não deve ser tratada como validação visual do candidato R2.

## Retorno para Dev6

Após a publicação da câmara pelo proprietário, Dev6 executará novamente o parser, `road_to_arch` por 36 segundos e a auditoria de regressão dos materiais, LOD e grounding R2.
