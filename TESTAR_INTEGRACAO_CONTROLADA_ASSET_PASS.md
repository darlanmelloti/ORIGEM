# ORIGEM — Teste da Integração Controlada e Asset Pass

## Objetivo

Esta versão mantém os sistemas estáveis de combate, Chronos, stamina, salto e Santuário. A integração acrescenta apenas melhorias verificadas: shader triplanar corrigido, aterramento robusto, orçamento gráfico conservador e os primeiros modelos GLB reais.

## Zona a observar

Comece na Praça Antiga e percorra o Caminho do Lago até ao Arco das Marés. A área inicial recebeu:

| Categoria | Modelos reais adicionados |
| --- | --- |
| Rochas | Rochas grandes, pedras altas e pedras pequenas CC0. |
| Geologia | Falésia inclinada e gruta de rocha CC0. |
| Vegetação | Carvalho, árvore detalhada e árvore base CC0. |
| Navegação | Ponte de pedra CC0 perto da margem. |

## Testes obrigatórios

1. Verifique que o jogo abre sem mensagens de erro de shader.
2. Caminhe junto das rochas e colunas. Os objetos devem apoiar-se no terreno, sem flutuar ou ficar exageradamente enterrados.
3. Confirme que as árvores e rochas carregadas têm sombras e desaparecem apenas a grande distância.
4. Observe o contacto entre pedras, musgo e chão; o shader triplanar deve variar cor, fissuras e rugosidade sem estiramento óbvio.
5. Teste combate, barra de espaço e stamina para confirmar que o Asset Pass não alterou sistemas de jogo.
6. Teste a Câmara do Cubo e o Sentinela Kharu para confirmar que o desempenho continua aceitável.

## Licença dos modelos

Os modelos em `assets/models_cc0/` provêm do **Nature Kit** de Kenney, sob licença Creative Commons Zero. A cópia da licença está em `assets/models_cc0/LICENSE_CC0_KENNEY.txt`.
