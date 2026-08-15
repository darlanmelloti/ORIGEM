# ORIGEM — Teste do Vale de Kheper em 3D Real

Esta versão remove o painel de fundo do vale. O cenário é agora composto por terreno, lago, encostas, montanhas, ruínas, árvores, vegetação e cascata existentes no espaço 3D.

## Confirmações visuais

| Área | O que deve observar |
| --- | --- |
| Praça inicial | Ruínas de pedra com colunas e a estrada de lajes a descer para o vale. |
| Rota central | O Arco das Marés em 3D, com pedras caídas e musgo. Deve haver paralaxe clara ao mover-se para os lados. |
| Lago das Memórias | Água real no lado direito da rota; deve oscilar suavemente. |
| Margens | Relva instanciada, pedras, flores e árvores em diferentes profundidades. |
| Horizonte | Montanhas tridimensionais e cascata distante; não deve existir qualquer imagem plana tipo outdoor. |
| Ruínas laterais | Santuário da Nascente, à esquerda, e Observatório Afogado, à direita. |
| Vida ambiental | Árvores e flores balançam discretamente; pequenas luzes flutuam perto da rota. |

## Teste no Godot

1. Extraia o projeto numa pasta nova e abra o ficheiro `project.godot` no Godot 4.7.
2. Inicie com `F5`, escolha **Novo Jogo** e avance pelo caminho de pedra.
3. Mova a câmara para os lados enquanto olha para o Arco das Marés, lago e montanhas. Os objetos devem revelar profundidade por paralaxe.
4. Aproxime-se da margem do lago. A água é uma malha 3D com animação de ondas leves, mas a entrada na água ainda não é uma mecânica de jogo.
5. Confirme que não aparecem referências, inimigos ou barra de vida do Guardião P-47.

## Diagnóstico rápido

Se o jogador cair, copie a primeira mensagem vermelha do painel **Depurador** do Godot. O terreno agora cria a sua própria colisão de malha; não adicione de volta o antigo `FloorCollider` plano.

Se a taxa de fotogramas ficar baixa, no teste inicial reduza a resolução de jogo ou desative primeiro o brilho (`Glow`). Não ative ray tracing, SSR, nevoeiro volumétrico ou sombras em luzes Omni para esta placa gráfica.
