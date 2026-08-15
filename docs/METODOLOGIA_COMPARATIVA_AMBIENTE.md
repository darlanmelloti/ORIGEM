# ORIGEM — Metodologia Comparativa para o Vale de Kheper

## Diagnóstico do protótipo

A análise do vídeo confirmou os problemas percebidos pelo utilizador: relva em blocos e por vezes flutuante, árvores demasiado geométricas, iluminação plana, ausência de sombras de contacto, escala inconsistente, composição aleatória e recortes de montanha sem volume. O resultado é um *blockout* técnico, não uma ambientação 3D final.

## Comparação de metodologias

| Referência de produção | Método observado | Aplicação prática no ORIGEM |
| --- | --- | --- |
| **Ubisoft / Far Cry 5** | Ferramentas procedurais para biomas, terreno, água doce, rochas e preenchimento iterável de grandes áreas. O objetivo não é automatizar o design, mas acelerar o preenchimento e permitir refinamento local. [1] | Um gerador de bioma por setores: relevo, zonas de água, distribuição controlada de relva, pedras, árvores e ruínas; depois, marcos e caminhos compostos manualmente. |
| **FromSoftware / Elden Ring** | Leitura do mundo por silhuetas, marcos visíveis, percursos com interesse e composição de vistas. O vídeo indicado enquadra a produção ambiental como combinação de kit modular, *blockout* e iteração de nível. [2] | O vale terá uma hierarquia clara: praça → Arco das Marés → lago/observatório → santuário → cascata e cordilheira. Cada elemento guia a exploração e não é decoração aleatória. |
| **Arte de ambiente modular moderna** | Peças modulares reutilizáveis, variação de escala/rotação/material e detalhes de quebra de repetição. O *blockout* e os testes precoces evitam investir em arte antes da escala estar correta. [3] | Kit de ruínas com três variantes de coluna, quatro pedras, lajes, arcos partidos, degraus e raízes. Materiais com variação de cor no espaço do mundo e musgo local. |
| **Godot 4** | `MultiMeshInstance3D` para instâncias repetidas; LOD/HLOD e visibilidade por distância para reduzir chamadas de desenho e custo de geometria distante. [4] [5] | Relva em setores, pedras agrupadas e árvores com LOD simples. A vegetação próxima será malha detalhada; a distante será instanciada e simplificada. |

## O que muda na implementação

A correção deixa de tentar resolver o problema com primitivas isoladas. O novo bioma usa cinco camadas, criadas por esta ordem:

1. **Terreno e sombras**: relevo escultado, sol direcional, céu e nevoeiro leve.
2. **Cobertura do solo**: material de relva com variação de altura/cor, pedras e terra exposta nas trilhas.
3. **Vegetação**: tufos de relva compostos por lâminas cruzadas, arbustos com ramos, árvores com troncos e copa dividida em grupos de folhas.
4. **Marcos**: ruínas escaladas, lago, ponte/cais, santuários e cascata.
5. **Profundidade**: montanhas 3D de baixa densidade, nevoeiro atmosférico e LOD de distância.

## Limites conscientes para a GTX 1050

O projeto não tentará reproduzir literalmente o orçamento de GPU de um jogo AAA. Serão preservadas as ideias de composição, modularidade, repetição controlada e camadas ambientais; porém, não serão ativados ray tracing, SSR, SDFGI, nevoeiro volumétrico, sombras Omni ou milhões de instâncias. A qualidade vem da direção de arte, das silhuetas e da variação local antes de depender de efeitos caros.

## Referências

[1] [GDC Vault — Procedural World Generation of Far Cry 5](https://www.gdcvault.com/play/1025557/Procedural-World-Generation-of-Far)

[2] [Next Level Game Art — What Elden Ring Teaches Environment Artists About AAA Level Production](https://www.youtube.com/watch?v=yAqT5qqPdN4)

[3] [Beyond Extent — Balancing Modularity and Uniqueness in Environment Art](https://www.beyondextent.com/articles/balancing-modularity-and-uniqueness-in-environment-art)

[4] [Godot Docs — MultiMeshInstance3D](https://docs.godotengine.org/en/stable/classes/class_multimeshinstance3d.html)

[5] [Godot Docs — Visibility ranges (HLOD)](https://docs.godotengine.org/en/stable/tutorials/3d/visibility_ranges.html)
