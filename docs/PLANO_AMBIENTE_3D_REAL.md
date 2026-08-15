# ORIGEM — Plano de Ambiente 3D Real

## Objetivo

Substituir o atual painel panorâmico por relevo, água, vegetação, ruínas e montanhas que existem efetivamente no espaço 3D. A referência visual do utilizador define a direção de arte — vale verde, lago, picos e céu luminoso — mas será interpretada como um cenário original para o ORIGEM.

## Princípios aplicados

| Princípio | Aplicação no Vale de Kheper |
| --- | --- |
| Hierarquia de marcos | Ruína inicial, Arco das Marés, lago, Santuário da Nascente e cordilheira devem ser visíveis em etapas, orientando o jogador sem setas artificiais. |
| Construção por camadas | Primeiro terreno e lago; depois penhascos e montanhas médias; por fim ruínas, árvores, relva e partículas. Cada camada deve continuar funcional sem a seguinte. |
| Kit modular | Rochas, colunas, lajes, raízes, árvores e blocos de ruína serão reutilizados com escala, rotação e cor variadas. |
| Geometria real | Montanhas, encostas e margens do lago são malhas 3D; o céu continua procedimental e não há painel ilustrado no horizonte. |
| Leitura à distância | Silhuetas grandes e materiais simples para montanhas e ruínas; detalhes pequenos apenas perto do jogador. |
| Orçamento para GTX 1050 | Vegetação distante com `MultiMeshInstance3D` dividida em setores; sombras apenas no sol direcional e nas ruínas próximas; nada de ray tracing, volumetric fog ou SSR. |

## Arquitetura técnica proposta

1. `TerrainPatch.gd` cria malhas de terreno a partir de uma grelha de alturas simples e inclui uma malha de colisão apenas na área jogável.
2. `ValleyBiome.gd` coloca vegetação, pedras e ruínas por setores, usando `MultiMeshInstance3D` para relva e pequenas pedras.
3. `WaterSurface.gd` cria um lago real com uma malha subdividida e shader de ondulação leve, sem reflexões de ecrã.
4. `TempleLevel.gd` deixa de gerar um painel ilustrado e apenas orquestra os módulos 3D acima.
5. `LevelEnvironment.gd` mantém um `WorldEnvironment` e uma luz direcional; usa céu procedimental, névoa leve e tonemapping Filmic.

## Decisões de desempenho

A documentação do Godot indica que LOD é aplicável a qualquer nó que desenhe malhas 3D e que modelos distantes devem usar versões menos detalhadas [1]. Para vegetação repetida, `MultiMesh` reduz chamadas de desenho ao instanciar uma malha muitas vezes na GPU; os setores devem ser separados para preservar o culling [2]. O `WorldEnvironment` centraliza luz ambiente, tom, nevoeiro e pós-processamento, e apenas um deve existir na cena ativa [3].

## Fontes

[1] [Godot Docs — Mesh level of detail](https://docs.godotengine.org/en/stable/tutorials/3d/mesh_lod.html)

[2] [Godot Docs — MultiMesh](https://docs.godotengine.org/en/stable/classes/class_multimesh.html)

[3] [Godot Docs — Environment and post-processing](https://docs.godotengine.org/en/stable/tutorials/3d/environment_and_post_processing.html)

[4] [Vídeo indicado — What Elden Ring Teaches Environment Artists About AAA Level Production](https://www.youtube.com/watch?v=yAqT5qqPdN4)
