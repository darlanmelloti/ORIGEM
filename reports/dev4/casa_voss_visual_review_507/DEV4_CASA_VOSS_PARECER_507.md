# ORIGEM — Parecer Dev4 #507: Revisão Visual Casa Voss

**Destinatário:** Dev1
**Autoridade:** Dev4 — revisão visual/documental
**Escopo:** fachada esquerda da Casa Voss, patamar/descida, vale e horizonte de Orion
**Estado:** parecer concluído; sem mutação de produção
**Referência canónica consultada:** `876092a90f306a67e2032a81b2bf70d56f60c7d4`

## Síntese

A evidência disponível sustenta uma composição navegável e coerente: a Casa Voss funciona como origem lateral, a descida de pedra organiza o eixo físico central, o vale abre a leitura no plano médio e o horizonte fornece um marcador distante sem fechar o espaço. A recomendação é **preservar a composição actual e proceder apenas a uma futura captura 16:9 controlada**, caso Dev1 a solicite. Não há fundamento, neste parecer, para editar geometria, materiais, luzes, água, partículas, física, câmara, âncoras, rotas ou assets.

> **Conclusão operacional:** o eixo de descida é legível; a revisão identifica sobretudo critérios de enquadramento e riscos de oclusão, não uma correcção de produção.

## Evidência revista

Foram analisadas duas capturas QA já existentes, sem as modificar. A primeira é a captura 1600×900 da transição `voss_to_road`; a segunda é a captura 1920×1080 da leitura cartográfica junto à porta da Casa Voss. A issue #507 define a revisão como documental, sem produção, PR, commit ou CI.[1]

| Evidência | Leitura relevante |
|---|---|
| `voss_to_road_postload.png` — 1600×900 | A descida de lajes é central e contínua; o vale abre para ambos os lados; o horizonte é uma faixa de relevo baixo com um marcador arquitectónico distante. |
| `before_voss_door.png` — 1920×1080 | A Casa Voss está estabelecida como origem no lado esquerdo da cartografia; Orion aparece como destino distante, confirmando a relação macro, não uma autorização de alteração 3D. |

## Leitura por camadas de profundidade

| Camada | Elementos observados | Critério de leitura |
|---|---|---|
| Primeiro plano | Início da descida e terreno aberto; a fachada esquerda não está suficientemente visível para uma avaliação arquitectónica detalhada. | A fachada deve funcionar como âncora lateral, sem competir com a saída. Não se deve inferir uma falha específica da fachada a partir desta evidência incompleta. |
| Plano médio | Sequência de lajes/pedra e prado aberto. | A descida é o principal elemento de navegação. A repetição dos intervalos entre lajes é um risco de ritmo visual, mas não autoriza alteração geométrica. |
| Plano distante | Marcador arquitectónico no centro/fundo e elevações baixas do vale. | O marcador fornece destino intermédio; deve permanecer legível sem se tornar um bloqueio ou uma parede visual. |
| Horizonte | Linha contínua de relevo sob céu amplo. | O horizonte mantém profundidade e escala. A captura deve conservar a relação entre descida, marcador distante e linha de horizonte. |

## Oclusões e elementos fora do eixo

A captura não mostra uma oclusão crítica do eixo físico. O corredor central deve permanecer visualmente livre: árvores, pedras, vegetação ou outros elementos laterais não devem atravessar a descida nem gerar uma rota falsa. A fachada esquerda deve manter-se fora do centro da imagem, e o marcador distante não deve ser coberto por elementos de primeiro ou médio plano.

A baixa densidade de marcos no plano médio favorece a leitura do percurso, embora reduza a hierarquia visual quando o céu ocupa uma área grande. Este é um critério para o enquadramento da captura, não uma recomendação de adicionar assets.

## Contraste e legibilidade

A superfície cinzenta das lajes contrasta adequadamente com o terreno verde e é o elemento mais legível para navegação. A vegetação e as pedras laterais funcionam como textura secundária. O céu dominante reduz o contraste relativo do horizonte, mas a silhueta das elevações continua perceptível. A composição deve evitar UI ou mapa sobrepostos durante uma eventual captura, porque esses elementos competem com a leitura da descida e do destino distante.

## Enquadramento 16:9 sugerido

A futura captura deve manter uma câmara ligeiramente recuada da Casa Voss, reservando a fachada esquerda ao terço lateral; colocar o início da descida e o seu prolongamento no terço central; deixar o vale ocupar o plano médio; e conservar o marcador distante e a linha de horizonte no terço superior. O enquadramento deve ser limpo, sem UI/mapa sobreposto, e deve representar o estado canónico sem candidata ou alteração transitória.

| Zona do enquadramento | Função recomendada |
|---|---|
| Terço lateral esquerdo | Âncora da Casa Voss/fachada, sem dominar o eixo. |
| Terço central | Desc ida física e continuidade das lajes, com corredor livre. |
| Plano médio | Vale aberto e relevo lateral, sem oclusão do percurso. |
| Terço superior/distante | Horizonte e marcador Orion, preservando profundidade. |

## Parecer ao Dev1

**Parecer favorável à preservação da composição actual.** A evidência confirma uma leitura clara de saída Casa Voss → descida → vale → horizonte. A única acção recomendável é uma captura 16:9 controlada para documentação, se autorizada por Dev1; não é recomendada qualquer alteração de mundo. Qualquer proposta de ampliar o escopo deve ser encaminhada ao Dev9 e ao Diretor, conforme a issue #507.[1]

Este parecer não aprova produção, não inicia uma variante e não altera R1, R4 ou R6. O próximo marco é a aceitação documental do parecer por Dev1 ou uma nova instrução explícita.

## Referências

[1]: https://github.com/darlanmelloti/ORIGEM/issues/507 — ORIGEM, “DEV4: Revisão visual Casa Voss — evidência e composição”.

**Artefactos de evidência anexados separadamente:** `voss_to_road_postload.png` e `before_voss_door.png`.

## Adenda — vídeo de referência do resultado esperado

Foi analisado o vídeo `origem_gameplay_01_casa_voss.mp4` como **referência de intenção visual**, não como evidência de que o estado actual reproduza todos os elementos nem como autorização para alterar produção. A referência mostra uma Casa Voss rústica e funcional, com fachada de pedra e madeira, alpendre, porta robusta e elementos de armazenamento; parte de um patamar elevado e conduz o jogador por uma descida de pedra integrada na encosta.

A referência esperada organiza a composição em três camadas: Casa Voss e personagem no primeiro plano, vale com ruínas, pontes e rio no plano médio, e cordilheira distante com o pico Orion e o seu ponto luminoso azul no fundo. A câmara acompanha a descida em terceira pessoa, mantendo simultaneamente a progressão física e a leitura do destino distante. A casa e a rocha lateral funcionam como molduras naturais e a descida revela progressivamente o vale, em vez de o apresentar todo de uma vez.

| Critério | Referência do vídeo | Evidência QA actual | Parecer Dev4 |
|---|---|---|---|
| Fachada esquerda | Casa rústica detalhada como âncora de partida. | A captura `voss_to_road` não oferece detalhe suficiente da fachada para confirmar correspondência arquitectónica. | Tratar a fachada como âncora lateral; não inferir defeito nem alterar produção com base nesta lacuna. |
| Patamar e descida | Patamar elevado e escadaria de pedra integrada na encosta, com sensação vertical. | A captura mostra uma sequência central de lajes que conduz ao vale, mas não documenta a mesma leitura de escadaria integrada. | A descida é legível; a verticalidade e a integração visual ficam como critérios de comparação futura, não como autorização de obra. |
| Vale | Vale amplo com ruínas, pontes, rio e vegetação estruturada. | A captura mostra vale aberto e relevo baixo; os marcos médios são menos densos. | Preservar o eixo e avaliar apenas enquadramento, oclusão e legibilidade. Não adicionar assets. |
| Horizonte/Orion | Cordilheira majestosa, pico Orion e foco azul vertical. | A captura mostra linha de relevo e marcador arquitectónico distante, sem prova suficiente para afirmar equivalência ao pico Orion do vídeo. | Manter o horizonte como destino distante; qualquer discrepância requer bilhete próprio, não correcção implícita. |
| Câmara | Terceira pessoa acima do ombro, acompanhando a descida e mantendo o destino. | A captura fixa uma vista de gameplay 16:9, útil para leitura do eixo, não para validar uma sequência cinematográfica. | Recomendar captura 16:9 comparável, sem mudar câmara ou rota. |
| Oclusão | Casa/rocha emolduram a saída e a descida revela o vale progressivamente. | A descida actual está exposta e o vale abre-se cedo. | Registar como diferença de intenção visual; não ocultar nem mover cenário. |
| Contraste | Casa/personagem mais escuros contra vale luminoso e foco azul. | Lajes cinzentas contrastam com o prado; horizonte e marcador têm contraste mais baixo. | Usar contraste como critério de captura e leitura, sem mudar materiais, luzes ou pós-processamento. |

### Parecer comparativo ao Dev1

O vídeo define uma expectativa visual de **descida orientada por um marco distante**, com a Casa Voss a enquadrar lateralmente a abertura do vale e Orion a funcionar como destino de fundo. A evidência actual confirma a legibilidade do eixo Casa Voss–descida–vale–horizonte, mas não permite declarar equivalência total de fachada, verticalidade, densidade de ruínas/pontes/rio ou foco de Orion. Essas diferenças são observações de composição e devem permanecer separadas de qualquer hipótese técnica.

Recomenda-se, como próximo passo documental, uma captura 16:9 de comparação com câmara de terceira pessoa durante a descida, caso Dev1 a autorize. A captura deve apenas observar o estado canónico e registar o momento em que a fachada deixa de dominar, o vale se abre e o horizonte se torna legível. Não deve criar candidata, alterar a rota, mover a câmara, modificar assets ou afectar R1/R4/R6.

**Estado após esta adenda:** parecer visual actualizado; `production_mutations=0`; nenhuma alteração no repositório, nenhuma PR, commit, CI, gate ou captura nova iniciada.

### Referência adicional

[2]: `origem_gameplay_01_casa_voss.mp4` — vídeo fornecido pelo Diretor como referência de resultado esperado; analisado apenas para intenção visual.
