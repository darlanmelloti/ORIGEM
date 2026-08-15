# Kit Artístico Modular — Fase 1

## Objetivo

A próxima evolução visual não consiste em expandir o Vale de Kheper. Primeiro substituímos os elementos de protótipo mais próximos da câmara por um kit de arte reutilizável. A prioridade é transformar uma faixa curta — a praça inicial, o caminho do lago e a entrada do Santuário da Nascente — numa referência de qualidade que depois possa ser replicada no restante mundo.

## Ordem de substituição

| Prioridade | Kit | Peças mínimas | Uso no ORIGEM |
| --- | --- | --- | --- |
| 1 | Rocha húmida | 6 rochas, 2 falésias, 3 pedras pequenas, 1 material triplanar | Margens do lago, contrafortes do santuário e silhueta do vale. |
| 2 | Ruínas P-0 | 3 colunas partidas, 2 paredes, 1 arco, 1 laje, 1 pedestal, 1 friso | Praça inicial, Arco das Marés, ponte e Câmara do Cubo. |
| 3 | Vegetação | 3 árvores, 4 arbustos, 2 ervas altas, 1 raiz exposta, 1 tronco caído | Margens, caminhos e enquadramento de marcos. |
| 4 | Materiais | Albedo, normal, roughness e AO para pedra, metal, musgo, solo e água | Substitui a cor plana atual por resposta física à luz. |
| 5 | Personagens | Elias, Kharu comum e Sentinela | Só depois de o ambiente próximo apresentar escala, materiais e iluminação coerentes. |

## Regras técnicas do kit

Cada peça deve ter pivô no solo, escala em metros reais, colisão simples separada da malha visual e três níveis de detalhe. No Godot, a instância distante usa `visibility_range_end`; as peças muito repetidas usam `MultiMeshInstance3D`. As superfícies devem usar um único atlas de materiais sempre que possível para reduzir mudanças de material.

O kit utiliza modelos e texturas permissivos como ponto de partida, mas recebe ajustes próprios de escala, paleta, erosão, musgo e runas P-0. O resultado precisa ser autoral, e não uma colagem de recursos de terceiros.

## Recursos gratuitos selecionados

A primeira biblioteca de materiais é o [Poly Haven][1], que disponibiliza conjuntos PBR para pedra, solo, madeira, metal e superfícies orgânicas. Para blocos de prototipagem com licença permissiva, o [Nature Kit da Kenney][2] oferece elementos de ambiente, e o [3TD Fantasy Ruins Pack][3] contém pilares, arcos, muros e templos sob CC0.

Os recursos são apenas matéria-prima. Antes de entrarem no jogo, passam por importação para `.glb`, revisão de pivô, redução de polígonos, criação de LOD, material próprio e aterramento pelo `TerrainPatch`.

## Primeiro recorte de produção

A próxima implementação substitui os blocos ainda visíveis junto à praça por quatro rochas de hero asset, duas colunas partidas, um arco erodido e uma árvore de silhueta mais natural. O objetivo é melhorar uma zona de aproximadamente 60 × 80 metros antes de tocar no resto do vale.

## Referências

[1]: https://polyhaven.com/textures "Poly Haven — Textures"
[2]: https://kenney.nl/assets/nature-kit "Kenney — Nature Kit"
[3]: https://opengameart.org/content/3td-fantasy-ruins-pack "OpenGameArt — 3TD Fantasy Ruins Pack"
