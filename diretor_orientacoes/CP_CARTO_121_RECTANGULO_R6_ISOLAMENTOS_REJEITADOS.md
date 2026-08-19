# CP-CARTO-121 — Rectângulo escuro R6: isolamentos rejeitados

## Objectivo

Identificar a origem do rectângulo escuro que persiste no quadrante direito da chegada às Ruínas Submersas, usando apenas comparações QA reversíveis e capturas Xvfb feitas no 30.º segundo de uma sessão de 36 segundos.

## Comparações executadas

| Isolamento QA | Resultado da captura tardia | Conclusão |
|---|---|---|
| HUD de gameplay oculto | O rectângulo permaneceu | Não é HUD |
| Camada cartográfica dinâmica ocultada | O rectângulo permaneceu | Não é mapa UI |
| `SwordPivot` de Elias ocultado | Espada saiu do enquadramento, rectângulo permaneceu | Não é arma/viewmodel |
| `MargensRochosasDoLago` ocultadas | O rectângulo permaneceu | Não é o conjunto de rochas/fetos da margem |

As quatro tomadas mantiveram a rota R6, o mundo de produção e as regiões 1–6. A instrumentação de comparação foi removida depois da auditoria.

## Decisão

A causa permanece no mundo 3D, mas não é uma das camadas ou grupos excluídos acima. Não é seguro remover geometria adicional sem uma atribuição nova. Este checkpoint não modifica produção.

## Continuidade

A próxima investigação deve procurar instâncias legadas de geometria de fundo na Região 6 por *bounding boxes* em torno do quadrante direito da câmara, sem repetir HUD, mapa, arma, margens, árvores 66/72/76, sombras, UI, água, Rocha 24 ou emissões globais.
