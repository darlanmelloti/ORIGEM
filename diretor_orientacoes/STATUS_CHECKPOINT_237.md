# CP 237 — Silhueta Cartográfica da Bacia Central

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Ruínas Submersas, margens da Bacia Central e Regiões 5–6.

## Alteração

A margem oriental, não utilizada pelo trilho principal, recebeu um pequeno promontório irregular de três rochas e a `CascataDaBaciaOriental`. O conjunto torna a borda elevada da bacia mais legível contra o lago e recupera a ideia de cascatas laterais do mapa cartográfico.

| Critério | Decisão |
|---|---|
| Lado escolhido | Margem oriental, afastada da entrada ocidental do jogador. |
| Rochas | Três elementos orgânicos, com escala e inclinação distintas. |
| Cascata | Quad de água com material do lago, sem partículas ou luz adicional. |
| Navegação | Sem novos colisores; trilho e lajes de chegada preservados. |
| GPU alvo | Sem aumento de luzes dinâmicas. |

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 238 — Leitura monumental da transição para Vila Elevada.** O próximo ciclo reforçará, apenas no lado da Região 6, a leitura da subida oriental como destino geográfico da Vila Elevada, mantendo o conteúdo da Região 7 sob responsabilidade Dev2.
