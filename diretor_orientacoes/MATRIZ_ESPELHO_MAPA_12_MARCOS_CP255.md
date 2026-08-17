# Matriz de Espelho do Mapa — 12 Marcos, Casa Voss e Vale de Kheper

**Autoridade visual:** `mapaorigem.webp` e `origem_vale_12_pontos_casa_voss.webp` fornecidos pelo CEO.

> O mapa é a autoridade espacial. A saída da Casa Voss deve funcionar como uma leitura tridimensional do mesmo vale, e não como uma sucessão de cenários isolados.

## Regra de composição da saída

A imagem de referência obriga a uma composição 16:9 de profundidade em cinco faixas: a **Casa Voss** enquadra o limite esquerdo; a **Estrada, ponte e Arco** conduzem o olhar no primeiro plano; a **Floresta, Acampamento e Bacia** ocupam o centro; a **Vila e Observatório** escalam o flanco direito; e a **Montanha Orion** encerra o horizonte com o sinal Chronos. O Hub Temporal permanece no canto inferior direito como promessa distante. Nenhum marco pode ser representado por plano publicitário, parede vegetal ou caixa de greybox.

| Marco | Nome | Papel na vista da Casa Voss | Tradução física exigida | Frente proprietária |
|---:|---|---|---|---|
| 1 | Casa Voss | Moldura esquerda e origem da viagem | Casa, porta, lanterna, soleira rochosa e rota de saída | Dev1 |
| 2 | Estrada do Rio | Linha de fuga inferior | Lajes, margem húmida, ponte de pedra e rio atravessável | Dev1 |
| 3 | Arco das Ruínas | Silhueta de primeiro plano, afastada da porta | Arco alto, pedras de base e passagem sem bloqueio | Dev1 |
| 4 | Floresta Densa | Profundidade central e corredor vivo | Árvores por camadas, clareiras, fetos e percurso legível | Dev1 |
| 5 | Acampamento Majestic | Foco narrativo no flanco oeste | Tendas, estandarte, fogo e crista aberta sobre a bacia | Dev1 |
| 6 | Ruínas Submersas | Centro hídrico do vale | Bacia escavada, água real, ruínas emergentes, cascatas e santuário | Dev1 |
| 7 | Vila Elevada | Massa urbana em socalcos à direita | Casas escalonadas, cascata de bordo e escadaria principal | Dev2 |
| 8 | Observatório | Cúpula no topo da vila | Cúpula visível, plataforma de pedra e eixo vertical claro | Dev2 |
| 9 | Trilha da Montanha | Linha serpenteante até Orion | Trilha ascendente, afloramentos e leitura de distância | Dev2 |
| 10 | Caverna Orion | Abertura escura na serra | Entrada tectónica, penhasco e sinal de destino | Dev2 |
| 11 | Câmara do Orion Cube | Cume e ponto luminescente | Pico tridimensional, halo Chronos contido e sem painel | Dev2 |
| 12 | Hub Temporal | Mistério no canto inferior direito | Anel de monólitos e núcleo temporal visto em perspectiva | Dev2 |

## Métrica comum de aceitação

| Critério | Evidência mínima | Regra de aprovação |
|---|---|---|
| Presença espacial | Captura 16:9 da soleira da Casa Voss | Pelo menos 9 dos 12 marcos legíveis; os restantes 3 devem ser apontados por silhueta ou continuidade da rota. |
| Geometria | Captura sem HUD de depuração | Sem planos de fundo, caixas altas, paredes de árvores ou marcos flutuantes. |
| Coerência cartográfica | Comparação lado a lado com o mapa | Ordem e posição relativa dos 12 marcos respeitadas. |
| Jogabilidade | Novo Jogo e exploração por 30 segundos | Porta, terreno, ponte, rota e colisores sem bloqueios. |
| Desempenho | Registo de validação Godot | Sem erro de recursos/scripts e dentro do orçamento de luzes da GTX 1050 Ti. |

## Estado da auditoria de frentes

| Frente | Estado verificado | Decisão imediata |
|---|---|---|
| Dev1 | Base estável no commit `336f680`; os passes panorâmicos recentes que não atingiram a referência foram retirados antes de commit. | Manter o mundo estável; trabalhar apenas em geometria Dev1 validada e em pontos de handoff. |
| Dev2 | Branch remota `feature/dev2-mountain-canyon` no commit `179b37a`, com HighlandRegion, OrionDestinationRegion, RegionalCinematicDirector, registos de QA e evidências de Takes 6–7. | Repriorizar a leitura panorâmica 7–12 e integrar CartographicAnchors conforme a ordem nova. |
| Dev3 | Não possui branch própria. O módulo RegionalCinematicDirector existe na base e define Takes 1–7, mas não existe uma tomada mestre Casa Voss→12 Marcos. | Criar a especificação e a prova de uma tomada mestre, sem editar geometria fora do seu escopo. |
| Dev4 / Diretor Geral | Não possui branch ou módulo de código próprio; actua pela pasta `diretor_orientacoes/`. | Manter a matriz, resolver fronteiras e auditar evidências sem bloquear execução. |
