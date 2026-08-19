# CP-CARTO-106 — Auditoria da Topologia da Superfície do Rio

## Achado causal

A massa escura lateral não é um painel de fundo nem um marcador. `SuperficieRioEstrada` é uma malha contínua de **32 segmentos triangulados** entre `z=8` e `z=163`. A largura permanece em **14 metros** até ao início do afunilamento por `smoothstep(82,112,z)` e só então reduz gradualmente para 3,8 metros.

A tomada lateral da Casa Voss observa a origem larga do rio em ângulo rasante. Por isso, a primeira faixa de água ocupa uma área visual extensa, apesar de possuir geometria real, curvatura no eixo X e ondulação no vertex shader.

| Elemento | Evidência no código | Implicação visual |
|---|---|---|
| Segmentação | 32 faixas, dois triângulos por faixa | Não é outdoor/painel |
| Largura inicial | 14 m entre z=8 e z=82 | Predomina na leitura próxima da Casa |
| Afunilamento | `smoothstep(82,112,z)` até 3,8 m | Só se torna estreito já próximo da Floresta |
| Margens existentes | Rochas, fetos e taludes entre z=14 e z=106 | Não faltam elementos; falta hierarquia visual no primeiro plano |

## Decisão

Não alterar material, neblina ou acrescentar rochas isoladas: essas hipóteses foram testadas e rejeitadas. A próxima hipótese, se aberta, deve ser uma única revisão reversível da **largura inicial do rio** com validação nas tomadas lateral e Casa→Arco, preservando a posição do eixo, a rota e todos os marcos cartográficos.
