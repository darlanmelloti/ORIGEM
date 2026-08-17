# CP-CINE-56 — Diagnóstico de Movimento no Corredor Orion

## Validação executada

A trajectória QA foi executada com três pontos físicos sobre a rota interior: soleira `(0.00, 0.90, 0.45)`, primeiro desvio `(-0.85, 0.90, 5.20)` e profundidade `(-2.15, 0.90, 10.80)`. A validação técnica headless e uma sessão renderizada de 30 segundos concluíram sem erros.

## Evidência dos estágios 0 e 1

O avanço desde a soleira até ao primeiro desvio não altera a leitura predominante: a parede próxima ocupa a maior parte do enquadramento e o espaço de circulação permanece como uma zona escura à direita. Isto confirma que o problema não é a orientação inicial da câmara nem a ausência de comprimento do corredor. A geometria visual do anel lateral aproxima-se em excesso da câmara no eixo actual, reduzindo a legibilidade da progressão.

A correcção seguinte deverá ajustar a secção transversal inicial da malha — em particular o raio do flanco esquerdo e o ponto onde começa a curvatura — sem afectar suporte físico, spawn, handoff ou orçamento de duas luzes locais.

## Evidência do estágio 2 e decisão

No ponto profundo, o enquadramento conserva a mesma assimetria: material de rocha muito próximo à esquerda e uma abertura preta à direita, sem marco que confirme a direcção da rota. A persistência nos três pontos exclui uma falha localizada de luz ou de spawn.

**Próximo passe aberto — CP-CINE-57:** alargar selectivamente o volume do flanco esquerdo nos primeiros anéis e atrasar a curva a oeste para depois do primeiro desvio. A alteração será única, reversível e limitada à malha visual; a base física invisível continuará a suportar Elias sem alterações.

## CP-CINE-57 — Reversão do perfil aberto

O perfil experimental alargado e a curva atrasada foram testados pela mesma trajectória de 30 segundos. O resultado não melhorou a leitura: a massa de rocha continuou a ocupar a tomada e a abertura negra continuou sem indicar destino. O ajuste foi revertido integralmente.

> **Candidato rejeitado:** aumentar apenas o raio lateral e adiar a curva nos anéis iniciais. Não repetir sem uma alteração complementar de linguagem espacial.

O próximo CP deverá introduzir **um marco volumétrico real de orientação** no fundo da rota — por exemplo, uma formação de rocha central ou uma abertura de câmara lateral — em vez de continuar a modificar o volume uniforme do corredor.

## CP-CINE-58 — Reversão da luz de orientação pessoal

A calibração mais forte da luz direccional já anexa à câmara de Elias foi testada durante 30 segundos depois de restaurado o identificador canónico `Flashlight`, necessário ao controlador de combate. A alteração não produziu ganho visual material no enquadramento. Os valores padrão foram restaurados.

> **Candidato rejeitado:** aumentar energia, alcance e cone da luz pessoal sem alterar a linguagem espacial do corredor.

**Próxima melhoria aberta:** criar um marco tridimensional de orientação, aproveitando geometria existente e sem emitir nova luz dinâmica; a decisão será validada primeiro em captura estática e depois em movimento.

## CP-CINE-59 — Reversão do marco mineral CC0

A formação `stone_tallC.glb` foi testada no bordo do primeiro desvio com validação de 30 segundos. Embora seja geometria volumétrica real e não afecte a rota física, apareceu como uma massa cinzenta sem integração material com a caverna. Foi removida.

> **Candidato rejeitado:** inserir directamente o activo CC0 de rocha sem uma passagem de material e escala específica do interior.

O próximo marco terá de nascer da própria malha do túnel ou ser integrado com o mesmo material PBR de rocha, sem recorrer a um modelo isolado visualmente dissonante.

## CP-CINE-60 — Reversão da hipótese de normais do piso

A inversão da ordem dos triângulos do piso foi validada por 30 segundos. No renderizador de compatibilidade, a nova ordem eliminou visualmente o piso devido à cullagem; a topologia anterior foi restaurada. Esta tentativa não resolve a leitura da rota.

> **Candidato rejeitado:** inverter a ordem das faces do piso sobreposto como passe de iluminação.

## CP-CINE-61 — Sonda de orientação

As orientações para o flanco negativo e para o centro foram capturadas a partir do mesmo spawn. Ambas mantêm a massa de rocha próxima em primeiro plano e não fornecem um destino legível. A terceira orientação positiva será usada para confirmar se a entrada óptima é o eixo oposto.

A orientação oeste (`target=(-1.55, y, 5.30)`) foi a mais legível das três opções: organiza o arco de rocha e concentra o piso de avanço no centro inferior do enquadramento. Foi promovida para a orientação permanente da transição e validada durante 30 segundos sem erros.

**Próxima hipótese aberta — CP-CINE-62:** calibrar apenas o FOV da câmara de Elias no interior, pois o FOV padrão muito aberto amplifica as paredes laterais. Não serão alterados geometria, materiais, colisores nem luzes durante este teste.

## CP-CINE-62 — FOV moderado validado

A câmara de Elias foi ajustada de 75 graus (padrão) para **64 graus** apenas no interior Orion. A validação técnica e 30 segundos de runtime não reportaram erros. A captura apresenta o arco do corredor de forma mais centrada, reduz a dominância das paredes periféricas e mantém o piso de avanço visível no centro inferior.

Esta é a primeira melhoria composicional persistente confirmada após a auditoria de movimento. Não acrescenta luzes, colisores, vértices ou activos; afecta exclusivamente a projecção da câmara activa de Elias dentro da cena independente Orion.

**Próximo passe aberto — CP-CINE-63:** capturar deslocação de 30 segundos com FOV 64 e verificar se a legibilidade do arco se preserva para além da soleira antes de iniciar a ante-câmara.

## CP-CINE-63 — Movimento com FOV 64

A soleira mantém o arco de rocha centrado e o piso de avanço identificável. No primeiro desvio, a silhueta continua coerente, mas a abertura adiante permanece demasiadamente negra para funcionar como destino narrativo. A avaliação do ponto profundo decidirá se a próxima intervenção deve ser ante-câmara ou um tratamento material localizado de fundo.

O estágio profundo confirma que a composição FOV 64 melhora a soleira, mas não é suficiente para transformar o corredor prolongado em destino legível: a abertura no segundo segmento permanece preta.

**Próximo passe aberto — CP-CINE-64:** sem acrescentar luzes, ajustar exclusivamente o alcance e o alvo do projector já existente `ProjectorDaCurvaInterior` para cobrir a profundidade física até ao anel de 12,8 m. A energia será conservadora e a decisão será tomada pela comparação de movimento, não apenas pelo frame inicial.

## CP-CINE-64 — Projector existente prolongado

A soleira preserva a composição FOV 64 e o primeiro desvio recebe ligeiramente mais leitura de textura, sem sobreiluminar o corredor. A confirmação relevante é o estágio profundo, onde a intervenção precisa transformar a abertura preta em trajectória reconhecível sem criar novas luzes.

O estágio profundo não mostrou ganho suficiente com o projector prolongado. A alteração de alcance, ângulo e alvo foi revertida, preservando as duas luzes locais originais.

> **Candidato rejeitado:** prolongar o projector de entrada para resolver sozinho a profundidade do segundo segmento.

A próxima investigação deverá verificar a própria construção do fecho profundo — material, cullagem e silhueta da tampa terminal — antes de construir uma ante-câmara adicional.

## CP-CINE-65 — Reversão de dupla face do piso

A dupla face no material do piso foi testada no segundo segmento durante 30 segundos. A captura de profundidade não mostrou ganho perceptível; a propriedade foi removida.

> **Candidato rejeitado:** dupla face no piso PBR como solução para a rota profunda.

A próxima investigação deverá analisar a tampa terminal e a geometria do segundo segmento, porque a falta de leitura persiste após excluir orientação, FOV, luz pessoal, projector prolongado, perfil aberto, marco isolado e cullagem do piso.

## CP-CINE-66 — Ambiente moderado validado

A energia ambiente aumentada de **0,52 para 0,68** revelou a textura contínua das paredes e do trecho profundo sem acrescentar luzes dinâmicas nem eliminar o contraste escuro da caverna. A validação de 30 segundos não reportou erros. O segundo segmento continua a necessitar de um destino narrativo, mas já deixa de ser uma massa preta sem material.

**Próximo passe aberto — CP-CINE-67:** criar a primeira ante-câmara através da própria malha contínua, introduzindo uma abertura lateral e uma secção de destino real depois do anel de 12,8 m. A base física, o FOV 64, as duas luzes locais e a iluminação ambiente aprovada devem ser preservados.

## CP-CINE-67 — Ante-câmara contínua, fecho ainda ilegível

A extensão para 24,8 m e a expansão progressiva da secção foram validadas tecnicamente por 30 segundos; Elias manteve-se apoiado no novo suporte físico. Contudo, a chegada enquadra a tampa terminal como uma parede de rocha uniforme, sem oferecer um destino narrativo. A malha contínua e o suporte não são revertidos ainda, porque constituem a base física necessária para a ante-câmara; o tratamento do fecho precisa ser corrigido antes da publicação.

**Próximo passe aberto — CP-CINE-68:** integrar no fecho uma formação mineral tridimensional, modelada no próprio interior e com emissão de superfície muito baixa, para criar um ponto de orientação real sem adicionar luz dinâmica, painéis ou outdoor.

## CP-CINE-68 — Reversão da formação mineral procedural

O agregado de cinco cristais prismáticos, embora volumétrico e sem luz dinâmica, apresentou uma leitura visual de primitivas laranja desligadas da rocha. Foi removido antes de qualquer publicação.

> **Candidato rejeitado:** cristais procedurais emissivos de baixa complexidade como marco terminal. O próximo destino terá de reutilizar um activo PBR integrado ou uma variação da própria malha de rocha, sem superfícies artificiais isoladas.

## CP-CINE-69 — Reversão da curva espacial experimental

A malha com secções orientadas e viragem lateral foi validada tecnicamente em 30 segundos, incluindo o ponto de inflexão. A parede terminal deixou de estar frontal, mas a rota lateral permaneceu pouco legível no renderizador de compatibilidade; a alteração não atingiu o ganho visual exigido e não será publicada.

> **Candidato rejeitado:** curva espacial ampla sem marco PBR integrado ou nova composição material. A base aprovada permanece: corredor de 18,4 m, FOV 64 e ambiente 0,68, com duas luzes locais.

O próximo incremento precisa começar pela integração de um activo PBR real que possa fornecer um destino visual sem aspecto de primitiva, antes de alterar novamente a topologia do corredor.

## CP-CINE-70 — Reversão de marco CC0 com material integrado

O activo `stone_tallC.glb` recebeu recursivamente o material PBR da caverna e foi validado por 30 segundos. Embora a dissonância cinzenta anterior tenha sido eliminada, o marco permaneceu fora da leitura útil do enquadramento e não criou orientação perceptível. Será revertido.

> **Candidato rejeitado:** marcador lateral CC0, mesmo após integração material, sem reposicionamento sustentado por evidência de trajectória.

## CP-CINE-72 — Ambiente profundo reforçado

A segunda calibração ambiente para **0,88** foi testada no ponto profundo por 30 segundos. A rocha mantém contraste e ganha detalhe material suficiente para deixar de se fundir num vazio preto. A alteração não acrescenta luzes dinâmicas nem novos vértices.

Antes da publicação, a entrada será capturada com a mesma calibração para garantir que a soleira preserva a atmosfera e a leitura FOV 64. Se o contraste inicial se mantiver, 0,88 substitui a calibração 0,68.

### Decisão final CP-CINE-72

A captura da soleira com ambiente 0,88 preservou o tom escuro, mas não revelou o eixo central do percurso com ganho suficiente. Como a melhora ficou abaixo do limiar de aceitação, a calibração será revertida para **0,68**. A hipótese de aumentar apenas a luz ambiente fica encerrada para evitar achatar a caverna sem resolver a composição.

## CP-CINE-73 — Reversão da veia mineral discreta

A veia mineral foi colocada no flanco enquadrado e validada durante 30 segundos sem luzes ou colisores adicionais. A composição revelou pequenos elementos lineares isolados na borda direita, em vez de uma formação geológica integrada; a rota central continuou sem ganho legível. A intervenção será removida.

> **Candidato rejeitado:** veias minerais procedurais compostas por prismas/cilindros, mesmo com emissão mínima. O interior requer um activo geológico contínuo ou uma nova estrutura de rota, não detalhe pontual.

## CP-CINE-74 — Reversão da neblina de profundidade

A neblina de profundidade foi aplicada apenas ao `WorldEnvironment` e validada durante 30 segundos. No renderizador de compatibilidade, a mudança não criou volume ou legibilidade adicional discernível no eixo escuro do corredor. Será removida, preservando a base sem camada atmosférica artificial.

> **Candidato rejeitado:** neblina de profundidade como solução de leitura do corredor Orion no modo OpenGL/Compatibility.

## CP-CINE-75 — Reversão de normais do sobrepiso PBR

A alteração foi limitada ao sobrepiso PBR, sem tocar na casca do túnel rejeitada no CP-CINE-60. A validação de 30 segundos confirmou a execução técnica, mas não produziu ganho composicional suficiente na soleira: o eixo central continua sem rota legível. A ordem do sobrepiso será restaurada.

> **Candidato rejeitado:** reordenação de faces do sobrepiso como solução isolada de legibilidade Orion.
