# ORIGEM — Blueprint Técnico do Mundo Contínuo

**Base de execução:** Checkpoint 100. Este documento traduz o mapa conceitual e a sequência de sete takes para zonas 3D contíguas no Godot 4.7.1. O objetivo é manter Elias no mesmo mundo, sem teletransportes ou telas de carregamento entre a Casa Voss e a Câmara do Orion Cube.

## Princípios de continuidade

A Casa Voss permanece no quadrante sudoeste e a porta abre para a origem da Estrada do Rio. O rio fica a leste da estrada; o arco é a primeira transição arquitetónica; a floresta fecha o campo visual antes de revelar a vila; e a montanha só se aproxima durante a ascensão. Cada marco deve ser construído sobre TerrainPatch, aterrado com `height_at`, e validado em gameplay real de no mínimo trinta segundos.

| Marco | Zona Godot | Faixa proposta (mundo) | Papel no percurso | Estado inicial |
|---:|---|---|---|---|
| 1 | `CasaVoss_Start` | x -30 a -15, z 4 a 18 | Prólogo, porta, espada e adro | Implementado e validado |
| 2 | `EstradaRio_Corridor` | x -22 a 4, z 12 a -35 | Lajes à esquerda; rio à direita | Implementado, rota corrigida |
| 3 | `ArcoRuinas_Threshold` | x -10 a 4, z -38 a -48 | Arco monumental, degraus e sombra | A construir |
| 4 | `FlorestaDensa_Path` | x -35 a 20, z -48 a -95 | Coníferas, fetos, raízes e riacho | A construir |
| 5 | `AcampamentoMajestic` | x -58 a -34, z -70 a -98 | Desvio tático opcional, a oeste | A construir |
| 6 | `RuinasSubmersas_Lago` | x 4 a 48, z -46 a -88 | Lago, domo, pilares e ponte | Ponte implementada; lago/ruínas a expandir |
| 7 | `VilaElevada_Terracos` | x 42 a 96, z -100 a -145 | Terraços, casas de pedra e escadas | A construir |
| 8 | `Observatorio_Overlook` | x 72 a 96, z -138 a -158 | Miradouro, mecanismo e pista da caverna | A construir |
| 9 | `TrilhaMontanha_Ascent` | x 38 a -72, z -150 a -230 | Ziguezague rochoso, queda de água e pontes | A construir |
| 10 | `CavernaOrion_Entrance` | x -96 a -72, z -218 a -245 | Fenda sob raízes, rocha e água fina | A construir |
| 11 | `OrionCube_Chamber` | interior da montanha | Galeria, mecanismo e Cube | A construir |
| 12 | `HubTemporal_East` | x 72 a 108, z -44 a -72 | Círculo megalítico opcional, margem leste | A construir |

## Correção topográfica necessária

O `TerrainPatch` atual ocupa aproximadamente x -110 a 110 e z 55 a -205. A posição atual do maciço Orion em x -184 está fora do terreno colidível. Antes de criar as zonas 7–11, o terreno deve ser expandido para cobrir pelo menos x -210 a 120 e z 70 a -330, com densidade de malha adequada à GTX 1050 Ti. Esta expansão é o primeiro risco técnico do mapa completo.

## Ordem de execução

1. Consolidar a topografia contínua e os corredores de navegação.
2. Entregar o corredor Casa Voss–Estrada–Arco com captura e gameplay de trinta segundos.
3. Construir floresta, acampamento e lago submerso como a zona intermédia.
4. Construir vila, observatório e subida em camadas.
5. Construir caverna, Cube e hub temporal sem quebrar a continuidade exterior.

## Critérios de aceitação por zona

Cada zona é aceite apenas com validação headless sem erros, captura em gameplay e percurso real de pelo menos trinta segundos. A rota obrigatória deve permanecer livre para Elias e futura montaria; objetos decorativos não podem bloquear a cápsula do jogador. As câmaras cinematográficas devem revelar o próximo marco, enquanto a câmara FPS mantém controlo contínuo fora das cenas controladas.
