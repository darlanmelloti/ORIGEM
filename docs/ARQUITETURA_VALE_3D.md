# ORIGEM — Arquitetura do Vale 3D Real

## Escala inicial

O primeiro espaço aberto será um vale de aproximadamente **220 × 260 metros**. Não é o mundo aberto completo: é uma área vertical demonstrável, com a praça inicial, estrada, Arco das Marés, lago, Santuário da Nascente e Observatório Afogado. Cada marco será uma futura subárea explorável.

## Estrutura da cena

| Módulo | Função | Geometria |
| --- | --- | --- |
| `TerrainPatch` | Solo real, encostas, vale e colisão do terreno | `ArrayMesh` gerada a partir de uma grelha de alturas de baixa densidade |
| `WaterSurface` | Lago real, margens e ondulação visual | Malha subdividida e shader leve sem SSR |
| `Biome` | Relva, flores, pedras, árvores e partículas ambientais | `MultiMeshInstance3D` por setor e árvores heroicas como malhas individuais |
| `Landmarks` | Arco, ruínas e templos que compõem as vistas | Kit modular de colunas, lajes, escadas e blocos de pedra |
| `DistantMountains` | Cadeias e picos que fecham a paisagem | Malhas 3D de baixa densidade, sem textura panorâmica |
| `LevelEnvironment` | Céu, luz direcional, névoa e tom | Um `WorldEnvironment`, um sol e efeitos moderados |

## Limites iniciais para a GTX 1050

| Recurso | Limite de protótipo | Decisão |
| --- | ---: | --- |
| Luzes com sombra | 1 | Apenas o `DirectionalLight3D` solar gera sombras. |
| Água | 1 lago | Shader de cor, transparência e ondulação; sem SSR, ray tracing ou reflexão planar em tempo real. |
| Árvores heroicas | Até 16 | Malhas individuais, visíveis e próximas. |
| Relva e pequenas pedras | Instanciadas por setores | `MultiMeshInstance3D` em três setores para culling mais eficiente. |
| Terreno | 96 × 112 vértices | Relevo real com densidade suficiente para a área inicial e colisão. |
| Pós-processamento | Tonemapping Filmic e névoa leve | Sem nevoeiro volumétrico, SDFGI, SSAO intenso ou profundidade de campo durante o jogo. |

## Composição de exploração

O jogador começa num patamar de ruínas. O caminho de pedra desce em curva até ao Arco das Marés. À direita fica o lago e o Observatório Afogado; à esquerda, numa colina baixa, o Santuário da Nascente. A cordilheira ao fundo fecha a vista, enquanto uma cascata funciona como alvo distante e sinaliza a próxima região.

> O cenário não deve depender de um painel ou foto de fundo. Cada elemento que define o horizonte deve ter volume, paralaxe e posição reais no espaço 3D.
