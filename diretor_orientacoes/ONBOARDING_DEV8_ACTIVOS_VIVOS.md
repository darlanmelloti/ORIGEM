# Onboarding — Dev8: Activos Vivos e Construções 3D

## Missão

Dev8 cria, importa e mantém a biblioteca de **fauna, plantas, ruínas, abrigos e construções ambientais** que dá vida ao mundo cartográfico. O trabalho deve produzir activos tridimensionais reais, reutilizáveis e preparados para Godot, com LOD, colisores e licenças documentadas.

## Repositório e orientação

| Item | Referência |
|---|---|
| Git | `https://github.com/darlanmelloti/ORIGEM.git` |
| Branch de trabalho | Criar `feature/dev8-living-assets` a partir de `feature/dev5-cartographic-world-third-person` actualizada |
| Workspace recomendado | `/home/ubuntu/ORIGEM_dev8_living_assets` |
| Orientações obrigatórias | `diretor_orientacoes/CONTINUIDADE_DEV8.md` e `diretor_orientacoes/PROTOCOLO_CONTINUIDADE_ACTIVA_DEV8.md` |
| Biblioteca e QA Dev5 | `levels/dev5/`, `assets/models_dev5/`, `assets/models_cc0/` |
| Fonte cartográfica | `levels/CartographicAnchors.gd` e `CP_D5_095_INTEGRACAO_MAPA_VIVO_R1_R6.md` |

## Escopo exclusivo

Dev8 edita apenas `assets/models_dev8/`, `assets/models_dev5/`, `levels/dev8/` e documentação associada. Pode criar previews QA próprios, mas não altera `RiverRoadJourney.gd`, `ForestLakeRegion.gd`, `VossHouse.gd`, `Player.gd` ou conteúdo R7–R12. A integração em produção cabe a Dev1/Dev7 após revisão.

## Padrões de activos

| Classe | Requisito |
|---|---|
| Fauna | GLB/GLTF, licença compatível documentada, malha/animador simples, sem colisor bloqueante por padrão |
| Vegetação | LOD leve, pivot na base, variação de escala/rotação e material PBR sustentável |
| Construções | Geometria modular real, colisor próprio, sem painéis ou silhuetas falsas |
| Ruínas | Peças laterais, nunca portais ou arcos estruturais já rejeitados |
| Importação | Nome sem espaços, origem/licença no `.md`, preview Godot e grounding por raycast |

O orçamento visual deve respeitar a GTX 1050 Ti. Não criar activos emissivos desnecessários nem exceder o plano de LOD vegetal. Para qualquer fauna ou asset externo, guardar a fonte e a licença juntamente com o activo.

## Ciclo contínuo obrigatório

1. Ler `CONTINUIDADE_DEV8.md` e seleccionar a primeira tarefa aberta.
2. Produzir um activo ou preview QA pequeno e reversível.
3. Validar parser Godot, grounding e pelo menos 36 segundos de cena/captura.
4. Publicar o activo, evidência e relatório de licença/LOD.
5. Após **10 segundos**, sincronizar Git e ler o marcador.
6. Executar imediatamente a nova tarefa. Se não houver tarefa explícita, **não parar**: usar a escada de contingência, actualizar o marcador e iniciar a próxima tarefa permitida.

> A consulta após 10 segundos é uma sincronização, não uma pausa. Nenhum checkpoint encerra o ciclo.

### Escada de contingência Dev8

1. Corrigir importação, licença, pivot, LOD, colisor ou grounding de activo existente.
2. Criar variação de activo para o marco cartográfico com menor cobertura.
3. Criar fauna ambiental leve ou construção modular reutilizável.
4. Auditar activos e produzir preview QA de 36 segundos.
5. Preparar o próximo item de biblioteca e iniciar imediatamente.

## Primeira tarefa activa

**DEV8-001 — Biblioteca de fauna e ruínas de margem.** Criar uma variação leve de fauna ambiental e um conjunto de duas ruínas laterais modulares para R3/R6. Cada activo deve ter licença registada, pivot ao solo, colisor adequado, preview QA de 36 segundos e evidência visual. Não criar cais de lajes, arco estrutural ou portal florestal.
