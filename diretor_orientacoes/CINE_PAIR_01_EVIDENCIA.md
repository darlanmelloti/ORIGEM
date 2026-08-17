# CINE-PAIR-01 — Evidência Física e Visual do Corredor Orion

**Estado:** diagnóstico partilhado Dev3 + Dev4 concluído; escolha da alteração única seguinte em execução.

## Validação executada

A sonda temporária foi executada em duas sessões independentes de 30 segundos, com a câmara de Elias, FOV 64 e o percurso físico existente. Não foram observados erros de parse ou runtime. O orçamento observado é de **3 luzes dinâmicas**, abaixo do limite de 16.

| Ponto | Posição efectiva da câmara | Vector frontal | Intersecção frontal | Intersecções laterais | Luzes |
| --- | --- | --- | --- | --- | --- |
| Soleira | `(0.013, 1.511, 0.386)` | `(-0.201, 0.106, 0.974)` | Nenhuma até 20 m | Nenhuma até 8 m | 3 |
| Profundidade | `(-1.988, 1.510, 10.027)` | `(-0.157, 0.120, 0.980)` | Nenhuma até 20 m | Nenhuma até 8 m | 3 |

## Leitura das capturas

A telemetria confirma que o eixo escolhido não encontra parede física próxima: a sensação de bloqueio é **puramente composicional e luminosa**, não uma falha de colisão ou de direcção da câmara. A soleira mostra textura de rocha muito próxima e um vazio central sem piso legível; na profundidade, a mesma massa lateral domina e a orientação de avanço deixa de ser reconhecível.

> A próxima alteração não deve repetir alargamento de perfil, FOV, deslocamento lateral de câmara, marcadores isolados, neblina, emissão do piso ou luz de profundidade isolada, todos já rejeitados no diagnóstico CP-CINE-56.

## Decisão em curso

Dev3 seleccionará uma intervenção de **orientação de superfície contínua**, e Dev4 verificará que ela preserve os três limites: rota sem colisão nova, três ou menos luzes locais e execução estável por 30 segundos. A sonda será removida antes do commit permanente.


## Decisão CINE-PAIR-02 — Reversão

A subdivisão do sobrepiso e a variação de cor por vértice foram tecnicamente válidas e não acrescentaram luzes, colisores ou objectos separados. Contudo, nas capturas de soleira e profundidade o ganho não foi perceptível: o vazio central continuou a dominar e a faixa não se distinguiu como superfície natural de orientação. A alteração será revertida e a sonda Dev4 será removida antes do próximo commit.

> **Novo candidato rejeitado:** orientação material do piso por cor de vértice como solução isolada da legibilidade Orion.


## Correcção da sonda CINE-PAIR-03

A primeira leitura de silhueta usava alvos acima do centro do `CharacterBody3D`, inclinando artificialmente a câmara de Elias para cima. O `OrionTransitionState` real usa a altura do próprio jogador; a sonda foi corrigida para essa orientação horizontal. A captura canónica sem sonda confirma que a lacuna permanece: o enquadramento tem rocha detalhada e corredor fechado, mas o piso ocupa apenas a faixa inferior e não comunica a direcção de avanço.

**Candidato CINE-PAIR-03B em execução:** testar uma inclinação inicial descendente, discreta e específica do interior, aplicada à cabeça de Elias. Não altera FOV, posição, luzes, colisores, materiais, malha ou controlo de rato; apenas centra a leitura no piso físico que já existe.


## Decisão CINE-PAIR-03B — Aceite como base melhorada

A inclinação inicial de **-7°** aplicada à cabeça de Elias foi validada com headless e 30 segundos de runtime sem erros. A soleira passou a mostrar uma faixa ampla de piso PBR no terço inferior do enquadramento, preservando a rocha, o FOV 64, as três luzes e o percurso físico. A alteração não resolve sozinha toda a profundidade, mas ultrapassa os candidatos anteriores por tornar a direcção imediata da exploração materialmente visível.

**CINE-PAIR-04 já iniciado:** Dev4 mede a continuidade visual do piso depois do primeiro desvio; Dev3 prepara uma única melhoria de profundidade que parta desta orientação de câmara aceite, sem a substituir ou reiniciar a cadeia de tentativas rejeitadas.


## Decisão CINE-PAIR-04 — Calibração de enquadramento aceite

A variante permanente de **-11°** foi aprovada após validação headless e 30 segundos de runtime sem erros. Em comparação com a base de -7°, o piso PBR ocupa uma área maior na soleira e depois do primeiro desvio, fornecendo uma leitura mais clara da superfície transitável sem adicionar luzes, colisores, painéis ou activos isolados. O orçamento mantém-se em três luzes locais.

**CINE-PAIR-05 já iniciado:** Dev4 prepara a prova física de travessia completa da rota Orion com esta base; Dev3 define a primeira composição de destino que só será aplicada se a chegada permanecer legível durante o percurso inteiro. Não abrir DIR autónomo nem reiniciar candidatos rejeitados.


## CINE-PAIR-05 — Leitura de percurso: soleira e desvio

As duas primeiras capturas da trajectória integral confirmam que a base de -11° mantém a faixa de piso visível na soleira e no primeiro desvio. O corredor continua fechado por rocha real e não apresenta falha de colisão, céu exposto, painel ou objecto artificial. A próxima decisão depende exclusivamente da captura de chegada: não antecipar geometria de destino antes de verificar a leitura do último segmento.


## Decisão CINE-PAIR-05 — Trajectória aprovada; plataforma rejeitada

A trajectória integral de 30 segundos confirmou que Elias percorre soleira, primeiro desvio e chegada sobre o suporte físico contínuo sem erro runtime. A chegada, porém, revela que o fecho actual é uma parede mineral próxima. A plataforma CC0 de ponte foi testada como composição de destino, sem luzes ou colisores adicionais, mas apareceu como massa cinzenta recortada e materialmente dissonante contra a caverna. Foi rejeitada e será removida.

**CINE-PAIR-06 já iniciado:** Dev4 fornece a leitura técnica da parede terminal; Dev3 selecciona uma composição de destino esculpida na própria casca do túnel, sem activos externos, sem painéis e sem geometria decorativa isolada.


## Decisão CINE-PAIR-06 — Reentrância terminal revertida

A reentrância mineral foi construída ao recuar somente o centro da tampa terminal e validada por 30 segundos sem erros. A captura da chegada mostrou variação tonal da rocha, mas não criou um destino, abertura ou profundidade reconhecível: a leitura continuou a ser de parede próxima. A alteração será revertida, preservando a casca e o suporte aprovados.

**CINE-PAIR-07 já iniciado:** Dev4 prepara uma auditoria de transição exterior→interior para confirmar se a primeira composição de destino deve ocorrer antes do fecho, no último desvio, em vez de ser forçada na tampa terminal. Dev3 mantém a orientação de -11° e seleccionará um único momento narrativo dentro do corredor, não uma nova decoração.


## CINE-PAIR-07 — Último desvio: entrada e curva

A entrada do último desvio mantém piso visível, mas a leitura lateral de rocha ainda domina. Na curva final, a casca volta a ocupar quase todo o enquadramento e não oferece um marco narrativo autónomo. A decisão depende do pré-fecho: não introduzir geometria ou iluminação antes de confirmar se existe uma zona de composição útil imediatamente antes da tampa.


## Decisão CINE-PAIR-07 — Sem momento narrativo isolado no último desvio

A entrada, a curva e o pré-fecho foram capturados durante a trajectória de 30 segundos. Nenhum dos três pontos oferece espaço visual autónomo: a casca de rocha continua a dominar e o pré-fecho é a própria parede terminal. Não será introduzido um marco decorativo artificial neste segmento.

**CINE-PAIR-08 já iniciado:** substituir a trajectória por teleporte por uma prova de movimento real de Elias com teclado durante 30 segundos. Dev4 mede a progressão física; Dev3 avalia se a leitura de piso aprovada permite ao jogador perceber e seguir a rota sem assistência visual adicional.


## CINE-PAIR-08 — Movimento físico: primeiros 18 segundos

As capturas aos 8 e 18 segundos mostram que a entrada de teclado foi aceite e que Elias progride fisicamente sobre o suporte contínuo, sem queda ou erro runtime. A faixa de piso de -11° mantém a direcção de avanço legível. A decisão final depende do quadro aos 28 segundos, que confirmará se a rota mantém continuidade antes do fecho.


## Decisão CINE-PAIR-08 — Navegação física aprovada

O quadro final aos 28 segundos mantém Elias apoiado no piso da caverna e sem erro de runtime. A sequência de teclado demonstra exploração física contínua, sem teleporte, queda ou bloqueio técnico. A orientação de -11° continua a tornar o piso navegável reconhecível, embora o fecho visual da rota ainda não seja um destino narrativo completo.

**CINE-PAIR-09 já iniciado:** Dev4 verifica o contracto de retorno por `E` depois da exploração interior; Dev3 define o primeiro momento narrativo somente após a travessia e o retorno serem comprovados no mesmo ciclo. Não abrir DIR autónomo.
