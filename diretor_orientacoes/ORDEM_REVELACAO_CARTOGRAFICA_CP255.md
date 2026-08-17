# Ordem contínua CP 255 — Revelação cartográfica do Vale de Kheper

**Autoridade espacial:** `levels/CartographicAnchors.gd` e o mapa oficial.  
**Princípio:** ao abrir a porta da Casa Voss, o jogador deve reconhecer um vale tridimensional contínuo, e não uma sequência de cenários isolados.

## Auditoria que motivou a ordem

A captura actual da abertura mostra a cobertura da Casa Voss a ocupar o primeiro plano e uma faixa de terreno sem marcos legíveis. A composição não comunica a Estrada do Rio, o Arco das Ruínas, a Floresta Densa, as Ruínas Submersas ou a Montanha Orion. A correcção prioritária é uma **revelação em profundidade**, com geometria real e níveis de leitura, sem painéis de fundo.

## Meta visual obrigatória

| Profundidade | Marco cartográfico | Leitura exigida desde a saída da Casa Voss |
|---|---|---|
| Primeiro plano | 1 Casa Voss e 2 Estrada do Rio | Porta, lajes e margem do rio enquadram a saída sem ocupar o horizonte. |
| Plano médio | 3 Arco, 4 Floresta, 5 Acampamento | Arco distante, corredor florestal e manchas quentes de tendas distinguíveis. |
| Centro do vale | 6 Ruínas Submersas | Bacia azul, ruínas emergentes e queda de água legíveis como destino. |
| Horizonte | 7–11 Vila, Observatório, Trilha, Caverna e Câmara Orion | Silhuetas escalonadas de assentamento, cúpula e serra, culminando no pico Orion. |
| Flanco oposto | 12 Hub Temporal | Círculo de monólitos discreto, fora da rota imediata, como promessa de retorno. |

## Tarefas paralelas contínuas

| Responsável | Ordem actual | Limite de alteração | Evidência obrigatória |
|---|---|---|---|
| **Dev1 — Principal** | CP 255: reposicionar e orientar a revelação da Casa Voss; criar miradouro físico de saída, corredor visual até ao Arco e marcos panorâmicos apenas das Regiões 1–6. | `VossHouse.gd`, `RiverRoadJourney.gd`, `ForestLakeRegion.gd`, `TempleLevel.gd`, ambiente e cartografia Dev1. | Captura de abertura, headless, Novo Jogo + 30 s. |
| **Dev2 — Montanha e canyon** | CP-D2-005: criar silhuetas 3D de baixo custo das Regiões 7–12 visíveis do vale: Vila Elevada, Observatório, crista Orion, entrada da caverna e brilho distante da Câmara. | Apenas `HighlandRegion.gd`, `OrionDestinationRegion.gd` e activos das Regiões 7–12. Nunca `VossHouse.gd` ou Regiões 1–6. | Captura desde o ponto de vista Voss, headless e 30 s no respectivo sector. |
| **Dev03 — Cinemática e QA** | CP-D3-001: manter a grelha de comparação mapa→mundo, verificar visibilidade dos 12 marcos e testar três enquadramentos exteriores da Casa Voss. | Scripts/relatórios de QA e orientação; sem deslocar geometria regional sem ordem explícita. | Contact sheet com marcadores 1–12 e relatório de legibilidade. |
| **Direcção geral** | Consolidar discrepâncias e publicar prioridades apenas na pasta de orientações; não bloquear o ciclo de implementação. | Documentação de coordenação. | Ordem actualizada a cada marco relevante. |

## Critérios de aceitação CP 255

A captura inicial deve mostrar, de forma simultânea e sem HUD intrusivo, pelo menos cinco leituras espaciais: a saída Casa Voss, a estrada/lajes, o Arco como marco **distante**, a faixa florestal, a bacia/ruínas ou cascata, e a serra Orion no horizonte. O Dev1 deve continuar em ciclos até atingir pelo menos 85% desses critérios, mantendo orçamento de GTX 1050 Ti e sem modificar módulos Dev2.

## Continuidade

Após o CP 255, o próximo ciclo Dev1 é CP 256: reforçar a leitura da bacia e das Ruínas Submersas desde a estrada, usando apenas geometria 3D, neblina e hierarquia de silhuetas. Commits são evidência, não pausa.
