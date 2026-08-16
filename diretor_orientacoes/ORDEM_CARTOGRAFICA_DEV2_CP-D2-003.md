# Ordem Cartográfica Dev2 — CP-D2-003

**Branch exclusiva:** `feature/dev2-mountain-canyon`  
**Âmbito exclusivo:** Regiões 7–12, Takes 12–22.  
**Autoridade espacial:** `res://levels/CartographicAnchors.gd`.

> O mapa cartográfico oficial é agora a planta obrigatória do mundo 3D. Cada marco deve ocupar a sua âncora, ter uma silhueta reconhecível a média distância e ligar-se ao marco seguinte por uma rota física ou, no caso do Hub Temporal, por transição temporal explícita.

## Sequência espacial obrigatória

| Marco | Região | Âncora X/Z | Leitura no mapa e no mundo | Entrega mínima do Dev2 |
|---|---:|---:|---|---|
| 7 — Vila Elevada | 7 | `140 / 352` | Cidade em patamar oriental, visível acima da bacia do lago. | Vila, terraços, fonte/estela de chegada e rota sem bloqueio desde o handoff Dev1. |
| 8 — Observatório | 8 | `194 / 404` | Cúpula/torre dominante no topo do patamar. | Silhueta visível a partir da Vila, escadaria/trilho e composição vertical. |
| 9 — Trilha da Montanha | 9 | `174 / 414` | Percurso estreito que abandona a civilização e entra no maciço Orion. | Trilho com curvas, guardas rochosas e vista regressiva sobre Vila e lago. |
| 10 — Caverna do Orion | 10 | `-116 / 548` | Boca monumental no maciço setentrional. | Entrada orgânica, rocha estratificada, leitura de destino e orçamento de luzes controlado. |
| 11 — Câmara do Orion Cube | 11 | `-116 / 562` | Câmara de clímax imediatamente além da caverna. | Arena/câmara, Cube, rota física inequívoca e limite de colisores testado. |
| 12 — Hub Temporal | 12 | `164 / 210` | Círculo de pedras no quadrante sudeste do mapa. | Hub isolado por transição temporal do Cube; não criar estrada geográfica artificial 11→12. |

## Próximo ciclo obrigatório

### CP-D2-003 — Ancoragem Vila Elevada → Observatório

O Dev2 deve começar imediatamente por substituir as coordenadas isoladas dos construtores de `HighlandRegion.gd` pelas constantes do registo cartográfico. A Vila Elevada deve usar `VILA_ELEVADA`; o Observatório, `OBSERVATORIO`; e a origem da Trilha da Montanha, `TRILHA_MONTANHA_INICIO`.

A rota entre os três marcos deve cumprir a seguinte leitura: o jogador chega da Bacia Central pelo handoff `Vector3(140, y, 352)`, vê a Vila Elevada como primeiro volume construído, sobe para o Observatório e encontra a Trilha da Montanha como continuação natural. Não criar conteúdo, câmaras nem alterações nos ficheiros Dev1 das Regiões 1–6.

| Critério de aceitação | Obrigatório |
|---|---|
| Headless Godot 4.7.1 sem erro de parser | Sim |
| Novo Jogo + percurso Região 7–9 por pelo menos 30 segundos | Sim |
| Captura de chegada à Vila e vista do Observatório | Sim |
| Máximo estimado de 14 luzes simultâneas em vista | Sim |
| Commit próprio e push na branch Dev2 | Sim |
| Início automático do CP-D2-004 após push | Sim |

### Continuidade depois do CP-D2-003

O CP-D2-004 deve ancorar a Caverna e a Câmara do Orion. O CP-D2-005 deve implementar a transição temporal limpa Câmara → Hub, reforçando que o Hub é destino de era e não uma continuação física do caminho de montanha.

## Regras de fronteira e qualidade

O Dev2 pode ler `CartographicAnchors.gd`, o contrato cartográfico e as orientações da equipa, mas não altera `VossHouse.gd`, `RiverRoadJourney.gd`, `ForestLakeRegion.gd`, `TempleLevel.gd`, Takes 1–11 ou qualquer activo pertencente ao Dev1. Cada checkpoint só é aceite depois de teste técnico e 30 segundos de gameplay/captura. Um commit é evidência de progresso: após o push, iniciar imediatamente o checkpoint seguinte.
