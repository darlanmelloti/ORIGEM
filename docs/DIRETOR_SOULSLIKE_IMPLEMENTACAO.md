# ORIGEM — Implementação do Guião do Diretor

## Decisão de produção

O projeto mantém o **Forward+** com escala 3D a 75%, MSAA 2× e iluminação dirigida. A direção do diretor será aplicada como **realismo estilizado**, não como fotorrealismo: materiais coerentes, paleta controlada, escala monumental, sombras, ruínas sobrepostas e combate deliberado. Esta escolha preserva a estabilidade na GTX 1050 sem sacrificar a leitura atmosférica.

> O objetivo visual do Santuário da Nascente é sugerir uma civilização erodida por ciclos temporais: pedra húmida, musgo, fissuras, metal envelhecido, poeira azul e arquitetura parcialmente reaproveitada de eras distintas.

## Tradução do guião para a versão atual

| Diretiva do diretor | Aplicação prática no ORIGEM |
| --- | --- |
| Paleta terrosa, cinzenta, ocre e azul profundo | Reduzir o verde neon, desaturar terrenos, utilizar pedra cinza-oliva e acentos temporais azul/cobre. |
| Bruma e pó temporal | Usar nevoeiro tradicional leve e partículas/quads locais. Não ativar névoa volumétrica global nesta etapa. |
| PBR e materiais verossímeis | Trabalhar com albedo, rugosidade e metalicidade já suportados pelo `StandardMaterial3D`; o próximo kit de ativos acrescentará mapas normal/roughness/AO. |
| Marcos visuais | Arco das Marés, Santuário no penedo e Observatório devem continuar visíveis de posições diferentes. |
| Espiral, verticalidade e atalhos | Rota longa para o santuário + passagem curta destrancada pelo lado interno. |
| Combate com peso | Stamina, custo de ataque/bloqueio/corrida, recuperação e bloqueio de novos golpes durante a recuperação. |
| P-47 como chefes | Os P-47 não regressam à vertical slice atual. Ficam reservados para um futuro chefe de elite, conforme a instrução anterior de removê-los do vale inicial. |

## Renderização: escolhas deliberadas

O projeto usa uma luz direcional principal com alcance de sombra limitado, ambiente moderado e tonemapping Filmic. SSAO será aplicado de forma conservadora nas ruínas, pois reforça fendas e contactos entre pedras; sombras e alcance curto são prioritários para a GTX 1050. A documentação do Godot indica que reduzir a distância máxima de sombras melhora simultaneamente a aparência local e o desempenho, enquanto SSAO deve ser mantido moderado por ser um efeito de espaço de ecrã.[1] [2]

A névoa volumétrica global foi excluída deste marco. Embora possa interagir com luz, é calculada em um buffer tridimensional e é mais cara; a documentação recomenda reduzir o volume para desempenho e reconhece que quads configurados podem ser uma alternativa mais leve para efeitos localizados.[3] O ORIGEM usará poeira temporal local e bruma tradicional no vale.

## Ordem de implementação

1. Aplicar a paleta de decadência temporal e a iluminação de ruína ao ambiente atual.
2. Adicionar stamina e recuperação de golpe ao jogador; atualizar o HUD.
3. Construir um atalho físico no Santuário da Nascente e runas ambientais interativas.
4. Testar a experiência de combate, rota e leitura visual antes de introduzir novos modelos artísticos.

## Referências

[1] [Godot Docs — Environment and post-processing](https://docs.godotengine.org/en/stable/tutorials/3d/environment_and_post_processing.html)

[2] [Godot Docs — 3D lights and shadows](https://docs.godotengine.org/en/stable/tutorials/3d/lights_and_shadows.html)

[3] [Godot Docs — Volumetric fog and fog volumes](https://docs.godotengine.org/en/stable/tutorials/3d/volumetric_fog.html)
