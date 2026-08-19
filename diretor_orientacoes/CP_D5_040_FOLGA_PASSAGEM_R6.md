# CP-D5-040 — Prova de folga de passagem R6

**Escopo:** harness QA novo em `levels/dev5/`. Não foram alteradas cenas regionais, rota de produção, colisores de produção ou o jogador Elias.

## Contrato de passagem

A baliza monolítica permanece no ponto cartográfico efectivo `(52, 260)` e o corredor QA preserva o eixo central `X=60`. A prova aproxima a baliza por um cilindro de raio `1,40 m` e o jogador por uma cápsula de raio `0,55 m`; a folga lateral calculada é `6,05 m`, acima do mínimo QA de `4,00 m`.

| Parâmetro | Valor |
|---|---:|
| Eixo do corredor QA | `X=60,00` |
| Centro da baliza | `X=52,00` |
| Raio do colisor da baliza | `1,40 m` |
| Raio do proxy de jogador | `0,55 m` |
| Folga lateral calculada | `6,05 m` |
| Mínimo aceitável QA | `4,00 m` |
| Ciclos de trajecto completos em 36 s | 2 |

## Resultado

A baliza voltou a aterrar no colisor `CorredorMargemR6QA`. O proxy percorreu o eixo central sem `test_move` bloqueado, sem erro de parser/script e sem intersecção com o colisor da baliza. A captura QA mostra visualmente os dois elementos separados; a representação em cápsula é exclusivamente de teste e não substitui Elias.

**Estado:** aprovado como contrato técnico QA. A integração regional continua dependente de validação Dev1 no corredor real Majestic→Ruínas com 30 segundos de gameplay; qualquer colisão, queda, redução de folga abaixo de `4,00 m` ou regressão cartográfica exige reversão.

## Próxima tarefa automática

**CP-D5-041 — Resumo de handoff R6 ao Dev1.** Preparar uma ficha concisa com âncora, colisão, folga, activos usados, evidência e critério de aceitação regional da baliza. A ficha não modifica produção nem promove o candidato automaticamente.
