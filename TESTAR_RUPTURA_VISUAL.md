# ORIGEM — Teste da Ruptura Visual

## Objetivo desta versão

A Ruptura Visual elimina a leitura de *greybox* mais evidente e reposiciona o Sentinela Kharu como o boss final da Câmara do Cubo. O início do Vale de Kheper deve ser contemplativo, sem um inimigo de elite imediatamente visível.

## Verificações obrigatórias

| Área | O que validar |
| --- | --- |
| Início do vale | O Capitão/Sentinela não aparece na praça inicial ou no caminho de entrada. A exploração inicial permanece silenciosa. |
| Ruínas exteriores | Rochas, contrafortes, colunas partidas e fragmentos apresentam silhuetas irregulares e superfícies de pedra/musgo; não devem parecer um conjunto de cubos perfeitos. |
| Câmara do Cubo | O Sentinela espera no altar, próximo do Cubo de Orion, e só inicia o combate quando o jogador entra no seu alcance. |
| SDFGI | No interior, colunas, poças e braseiros devem ganhar luz indireta e sombras mais profundas. Se a taxa de fotogramas cair de forma excessiva, desative SDFGI em `levels/LevelEnvironment.gd` alterando `environment.sdfgi_enabled = false`. |
| Reflexos | Água e pedra húmida usam SSR moderado e ReflectionProbes locais. Reflexos só aparecerão para elementos visíveis no ecrã; isto é esperado. |
| GTX 1050 | A versão usa GI em meia resolução, quatro cascatas e 32 passos SSR. Não aumente estes parâmetros antes de medir desempenho. |

## Rotas de teste

1. Inicie um novo jogo e avance pelo Vale de Kheper sem combater um boss no exterior.
2. Entre no Santuário e atravesse a Sala dos Poços e a Ponte de Ressonância.
3. Chegue à Câmara do Cubo. O Sentinela Kharu deve estar ao lado do altar, protegido por partículas P-0 e iluminação azulada.
4. Teste o combate de postura, bloqueio e stamina.
5. Recolha uma captura de dia/crepúsculo no exterior e uma captura da Câmara do Cubo para avaliar a leitura visual.

## Nota técnica

A documentação oficial do Godot classifica SDFGI, SSR e SSAO como técnicas de custo relevante. Por isso o projeto usa uma configuração conservadora e a reserva de desativar SDFGI para computadores abaixo da GTX 1050.
