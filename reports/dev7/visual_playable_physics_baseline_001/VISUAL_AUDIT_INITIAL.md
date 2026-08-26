# Auditoria Visual Inicial — Baseline Dev7 001

## Amostra analisada

Foram verificadas as capturas runtime `road_to_arch` e `ruins_arrival`, ambas em 1600×900 e com carregamento concluído.

| Rota | Leitura confirmada | Débito visual observado | Risco de física/rota |
|---|---|---|---|
| `road_to_arch` | A estrada de lajes conduz visualmente ao arco e conserva horizonte aberto. | Vegetação, rochas e silhuetas de montanha apresentam contraste de material inconsistente e escala de protótipo; há pouca estratificação do plano médio. | Não há bloqueio aparente da via central nesta amostra. |
| `ruins_arrival` | O terreno permanece aberto e a chegada preserva a leitura macro do vale. | Estela, marcadores e água distante não formam um foco arqueológico legível; os elementos do plano médio estão dispersos e a paisagem lê-se como bloco de terreno genérico. | A navegação parece desobstruída; qualquer melhoria deve preservar a faixa de chegada e as quatro luzes R6. |

## Orientação inicial

A baseline não recomenda ainda alteração de produção. A primeira candidata deve ser uma intervenção modular de **composição visual sobre elementos existentes**, preferencialmente focada no contraste e alinhamento de ruínas/estelas R6 sem criar luz, física, colisores, água, partículas ou geometria nova. Antes de selecionar a intervenção, a baseline deve rever as restantes quatro rotas e cruzar os resultados com as verificações de grounding e orçamento de luz.

## Segunda amostra — transições centrais

| Rota | Leitura confirmada | Débito visual observado | Risco de física/rota |
|---|---|---|---|
| `forest_to_majestic` | O pavimento continua legível e aponta para o acampamento. | A aproximação apresenta elementos baixos com cores/silhuetas de protótipo e plano médio pouco articulado; o acampamento está visível, mas ainda não é foco suficientemente forte. | O corredor central permanece livre nesta captura. |
| `majestic_to_lake` | As lajes de conexão são distinguíveis no solo. | O acampamento não está enquadrado na direção de saída e a sombra alongada de um elemento lateral domina a composição sem comunicar objetivo. | A sequência de lajes parece navegável; qualquer alteração deve manter estas transições e os seus colisores. |

A partir das quatro amostras analisadas, a baseline reforça que a primeira intervenção não deve introduzir efeitos ou ativos novos. A candidata de maior valor é uma **composição modular baseada em elementos R5 existentes**, avaliada primeiro pela câmara de QA determinada pela sonda Dev5, pois permite melhorar a leitura do núcleo Majestic sem afetar água R6, ancoragem, iluminação ou física.

## Terceira amostra — transições Arco, Floresta e Ruínas

| Rota | Leitura confirmada | Débito visual observado | Risco de física/rota |
|---|---|---|---|
| `arch_to_forest` | O vale continua fisicamente aberto e o pavimento ainda indica progressão. | A faixa de água alta à esquerda e rochas contrastantes dominam a aproximação; vegetação e relevo não formam uma transição florestal convincente. | A captura não evidencia bloqueio, mas qualquer intervenção deve preservar a clareira Orion e corredor R4 ≥8 m. |
| `forest_to_ruins` | A sequência de lajes é claramente reconhecível e não está fechada por vegetação. | A água e peças arqueológicas apresentam formas/material de protótipo; a chegada carece de uma hierarquia visual que diferencie ruínas, margem e próximo objetivo. | A via está legível e deve permanecer livre; água, quatro luzes R6 e handoff são protegidos. |

## Seleção preliminar de prioridade

As seis rotas confirmam uma base física navegável, reforçada pela prova de grounding aprovada. O débito dominante é de **linguagem material e hierarquia visual**, não de física de personagem ou largura de corredor. A primeira intervenção Dev7 recomendada é uma **auditoria de material e silhueta dos elementos arqueológicos existentes da transição `forest_to_ruins`**, com escopo QA primeiro: catalogar meshes existentes e simular apenas overrides locais de material em ambiente de teste. Não devem ser criados assets, luzes, colisores, água, partículas ou geometrias; R6 continua dono de qualquer alteração posterior em produção.
