# CP-D5-073 — Elias na ponte modular R2

**Escopo:** harness QA isolado. A ponte é construída pelo construtor modular Dev5; a prova não usa nem reintroduz a ponte GLB leve rejeitada.

## Objectivo

Comprovar que Elias pode percorrer o eixo central do tabuleiro modular da ponte R2, preservando a posição cartográfica, a apresentação em terceira pessoa e uma câmara QA externa.

| Critério | Resultado QA |
|---|---|
| Âncora de ponte | R2 `(-21,4,28)` |
| Construção | Ponte modular por lajes e aduelas; sem GLB |
| Aterramento | `grounded=true`, X/Z preservado |
| Tabuleiro | Colisor contínuo por laje |
| Folga central | `0,21 m`, acima do mínimo de `0,20 m` |
| Elias | Câmara interna inactiva; câmara QA externa |
| Travessia | 4 ciclos em 36 segundos |
| Luzes | Uma direccional QA, zero Omni/Spot |

## Revisão visual

A captura mostra Elias sobre o tabuleiro de pedra modular. A leitura é adequada para a verificação de largura, continuidade e escala do personagem; continua a ser uma prova técnica e não uma promoção visual à Estrada do Rio de produção.

## Próxima tarefa automática

**CP-D5-074 — Auditoria de contratos de travessia.** Consolidar em matriz as folgas e as regras de passagem QA de R2, R4, R5 e R6, distinguindo limites técnicos de aprovação estética.
