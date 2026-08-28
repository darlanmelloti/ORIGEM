# DEV1-R1-CASA-VOSS-HIGHLAND-OPENING-001

**Frente proprietária:** Dev1 — Região 1, Casa Voss e integração do percurso inicial.

**Base de trabalho:** `d353c4f` — inclui a correção física pós-prólogo já validada em gameplay de 60,41 segundos.

**Estado:** `ACTIVE`.

## Objetivo

Transformar a abertura exterior de **Casa Voss**, sem remover a casa existente, num início de jornada em terreno elevado. Depois da porta, Elias deve encontrar um patamar habitável e legível, uma descida física que introduza a Estrada do Rio e uma composição profunda onde a montanha de Orion e a futura caverna terminal sejam visíveis como destino distante.

O resultado deve procurar a **função de composição** do vídeo de referência, não copiar os seus ativos nem converter o ORIGEM numa imitação literal. A referência estabelece quatro leituras: refúgio rústico à esquerda, marco de ruína local, percurso descendente inequívoco e montanha/caverna como promessa no horizonte.

## Critérios de aceitação do primeiro incremento

| Área | Critério observável |
|---|---|
| Casa Voss | A fachada, a varanda/soleira e os elementos domésticos existentes continuam reconhecíveis e não têm colisão bloqueadora na saída. |
| Ponto alto | A soleira exterior fica num platô físico com leitura panorâmica real; não é permitido plano de fundo, skybox pintado ou teleporte para simular altitude. |
| Descida | Existe uma primeira sequência curta de degraus/lajes ou caminho de pedra desgastada, lateralmente enquadrada e com largura navegável mínima de 3,9 m. |
| Vale | Estrada do Rio, ponte positiva, Arco das Ruínas e rio continuam nas posições cartográficas e permanecem exploráveis. |
| Horizonte | A montanha Orion mantém-se um marco de profundidade; a caverna futura deve ser apenas uma silhueta/materialização distante, sem criar a Região 7 ou alterar as âncoras cartográficas. |
| Física | Elias não pode atravessar, ficar comprimido entre malhas ou perder contacto com o chão; a recuperação pós-prólogo conserva folga acima do terreno. |
| Desempenho | Respeitar o máximo global de 16 luzes visíveis para GTX 1050 Ti; esta etapa não adiciona luz dinâmica nova. |

## Escopo permitido nesta etapa

A implementação pode modificar exclusivamente os módulos R1 necessários para a composição e a física local:

| Ficheiro ou área | Uso permitido |
|---|---|
| `levels/VossHouse.gd` | Patamar, soleira, primeiros degraus, marcos domésticos e composição de saída. |
| `levels/TerrainPatch.gd` | Ajuste local de relevo somente se for necessário para sustentar a descida e se preservar a malha/colisor congruentes. |
| `levels/TempleLevel.gd` | Apenas ligação explícita do marco R1, se indispensável. |
| `qa/player/` | Captura e prova de exploração pós-prólogo; telemetria apenas sob variável de ambiente QA. |
| `reports/player/` | Relatório com posições, rotas, contagem de luzes e evidências. |

## Exclusões obrigatórias

Não alterar `CartographicAnchors.gd`, rotas R2–R6, água/lago R6, materiais de produção R4/R6, UI cartográfica, câmara normal do jogador, IA, combate ou a geografia de regiões futuras. Não criar neblina, partículas, painéis, planos distantes, fundos falsos, teleporte, FOV extremo ou luzes adicionais para ocultar lacunas de composição.

## Sequência de trabalho

1. Medir a soleira atual, o início da Estrada do Rio, a altura do terreno e a posição do primeiro ponto de observação.
2. Criar uma única hipótese espacial para o patamar e a descida, declarando alturas, largura navegável, nós físicos e leitura de horizonte esperada.
3. Implementar somente a geometria física mínima necessária, com a mesma orientação na malha visível e no colisor.
4. Executar parser Godot 4.7.1, `QA-GROUND-01`, `QA-POST-PROLOGUE-INPUT-060`, porta R2 e uma captura 16:9 da soleira/descent.
5. Fazer um commit isolado, `git diff --check`, `git fetch origin --prune` e comparar a base com a integração antes de qualquer publicação.
6. Publicar por push não destrutivo, abrir PR regular, aguardar CI por marcos e integrar somente se todos os checks obrigatórios passarem.

> A continuidade não autoriza micro-mutações cosméticas. Depois de completar uma hipótese e realizar a única verificação Git pós-tarefa, Dev1 deve iniciar a próxima hipótese apenas quando existir uma melhoria espacial mensurável ou uma mudança real de head/base/check/mergeability.

## Próxima ação concreta

**DEV1-R1-CASA-VOSS-HIGHLAND-SURVEY-002**: inventariar as cotas atuais da soleira, dos primeiros 40 m de Estrada, da ponte positiva e do marco Orion; produzir uma hipótese única para a elevação e descida, sem alterar ainda qualquer geometria.
