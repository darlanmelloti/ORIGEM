# ORIGEM — Blueprint Técnico do Mundo Contínuo

**Base de execução:** Checkpoint 100. Este documento traduz o mapa conceitual e a sequência de sete takes para zonas 3D contíguas no Godot 4.7.1. O objetivo é manter Elias no mesmo mundo, sem teletransportes ou telas de carregamento entre a Casa Voss e a Câmara do Orion Cube.

## Princípios de continuidade

A Casa Voss permanece no quadrante sudoeste e a porta abre para a origem da Estrada do Rio. O rio fica a leste da estrada; o arco é a primeira transição arquitetónica; a floresta fecha o campo visual antes de revelar a vila; e a montanha só se aproxima durante a ascensão. Cada marco deve ser construído sobre TerrainPatch, aterrado com `height_at`, e validado em gameplay real de no mínimo trinta segundos.

| Marco | Zona Godot | Faixa proposta (mundo) | Papel no percurso | Estado inicial |
|---:|---|---|---|---|
| 1 | `CasaVoss_Start` | x -30 a -15, z 4 a 18 | Prólogo, porta, espada e adro | Implementado e validado |
| 2 | `EstradaRio_Corridor` | x -24 a 12, z 12 a 46 | Lajes à esquerda; rio à direita | Implementado; reforço visual em curso |
| 3 | `ArcoRuinas_Threshold` | x -18 a -2, z 42 a 60 | Arco monumental, degraus e sombra | Implementado; leitura em refinamento |
| 4 | `FlorestaDensa_Path` | x -60 a 32, z 60 a 210 | Coníferas, fetos, raízes e riacho | A construir |
| 5 | `AcampamentoMajestic` | x -118 a -62, z 145 a 215 | Desvio tático opcional, a oeste | A construir |
| 6 | `RuinasSubmersas_Lago` | x -36 a 92, z 205 a 302 | Lago, domo, pilares e ponte | Bacia topográfica preparada |
| 7 | `VilaElevada_Terracos` | x 88 a 188, z 292 a 385 | Terraços, casas de pedra e escadas | A construir |
| 8 | `Observatorio_Overlook` | x 166 a 222, z 360 a 420 | Miradouro, mecanismo e pista da caverna | A construir |
| 9 | `TrilhaMontanha_Ascent` | x 34 a -108, z 390 a 535 | Ziguezague rochoso, queda de água e pontes | A construir |
| 10 | `CavernaOrion_Entrance` | x -142 a -92, z 515 a 555 | Fenda sob raízes, rocha e água fina | A construir |
| 11 | `OrionCube_Chamber` | interior de Orion, z 550+ | Galeria, mecanismo e Cube | A construir |
| 12 | `HubTemporal_East` | x 118 a 208, z 170 a 245 | Círculo megalítico opcional, margem leste | A construir |

## Correção topográfica necessária

O `TerrainPatch` regional cobre aproximadamente x -320 a 320 e z -260 a 620, com uma malha de 192 × 220 células. A expansão acomoda a rota de 12 marcos e mantém os setores antigos como ramificações de legado. As zonas distantes devem aplicar LOD, instanciamento e densidade seletiva para se manterem adequadas à GTX 1050 Ti.

## Ordem de execução

1. Consolidar a topografia contínua e os corredores de navegação.
2. Entregar o corredor Casa Voss–Estrada–Arco com captura e gameplay de trinta segundos.
3. Construir floresta, acampamento e lago submerso como a zona intermédia.
4. Construir vila, observatório e subida em camadas.
5. Construir caverna, Cube e hub temporal sem quebrar a continuidade exterior.

## Critérios de aceitação por zona

Cada zona é aceite apenas com validação headless sem erros, captura em gameplay e percurso real de pelo menos trinta segundos. A rota obrigatória deve permanecer livre para Elias e futura montaria; objetos decorativos não podem bloquear a cápsula do jogador. As câmaras cinematográficas devem revelar o próximo marco, enquanto a câmara FPS mantém controlo contínuo fora das cenas controladas.
