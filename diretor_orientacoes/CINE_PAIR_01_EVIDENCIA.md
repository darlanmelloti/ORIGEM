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


## Decisão CINE-PAIR-09 — Retorno por E aprovado

A prova de 30 segundos accionou `E` a partir da soleira interior e carregou `scenes/main.tscn` sem erro runtime. A captura exterior mostra Elias regressado à área Casa Voss sob o prólogo activo, confirmando que o handoff interior→exterior permanece físico e funcional depois dos ajustes de câmara Orion.

**CINE-PAIR-10 já iniciado:** Dev4 mede a continuidade visual e de estado entre regresso Orion e o prólogo exterior; Dev3 selecciona a próxima composição apenas se não quebrar esta transição aprovada. Não abrir DIR autónomo.


## Decisão CINE-PAIR-10 — Restauração exterior corrigida e aprovada

A auditoria revelou que `OrionTransitionState.restore_exterior_player()` existia, mas não era chamado pelo controlador de `scenes/main.tscn`. Foi adicionada uma verificação explícita de retorno pendente no `_ready()` principal. A restauração só ocorre após uma saída legítima do interior; o spawn normal da Casa Voss permanece intacto.

A passagem QA capturou e restaurou estado real de Elias: saúde `63`, stamina capturada `32,17`, posição e rotação de retorno. A validação limpa posterior executou 30 segundos tanto em `scenes/main.tscn` como em `scenes/orion_interior.tscn`, sem erros de parse ou runtime.

**CINE-PAIR-11 já iniciado:** Dev4 confirma o orçamento de luzes e a estabilidade da câmara no percurso integrado exterior→interior→exterior; Dev3 só inicia nova composição após esta prova sistémica. Não abrir DIR autónomo.


## Decisão CINE-PAIR-11 — Orçamento de luzes corrigido e aprovado

A auditoria inicial contou 20 nós de luz no exterior, dos quais 19 estavam visíveis, excedendo a margem definida para GTX 1050 Ti. A câmara de prólogo permanecia `CameraPrologoCasaVoss`; o interior tinha três luzes e a câmara activa correcta de Elias.

Foram desactivadas três fontes secundárias de janelas da Casa Voss — `JanelaFrontalEste_Luz`, `LuzDoSotao` e `JanelaDaAla_Luz` — porque a leitura é coberta pelos preenchimentos interiores, lareira, lanterna e luzes narrativas já existentes. A contagem exterior caiu para **16 luzes visíveis**; o interior permaneceu com **3**. A captura exterior e as sessões limpas de 30 segundos em `main.tscn` e `orion_interior.tscn` mantiveram-se sem erros.

**CINE-PAIR-12 já iniciado:** Dev4 mede a estabilidade física e visual do retorno na posição exterior real da Garganta Orion; Dev3 só avança para nova composição quando a transição de regresso, agora com orçamento correcto, estiver comprovada na geografia do mapa.


## Decisão CINE-PAIR-12 — Travessia real da Garganta Orion aprovada

A prova iniciou Elias na aproximação física real da Garganta Orion em `(-116.0, 40.04, 551.60)`. O jogador avançou por teclado através do `GatilhoFisicoInteriorOrion`; o log confirmou `ORION_HANDOFF_READY`, a captura seguinte confirmou o corredor interior, e `E` devolveu Elias ao exterior. A captura de retorno mostra a Garganta tridimensional real, sem painel, tela plana ou cena interior persistente.

O ciclo de 30 segundos terminou sem erros de runtime. O suporte do corredor e o retorno exterior permaneceram estáveis; o orçamento exterior já aprovado de 16 luzes visíveis foi preservado. Instrumentação QA foi removida e a base limpa foi novamente validada em 30 segundos no mundo principal e no interior.

**CINE-PAIR-13 já iniciado:** Dev4 prepara a matriz de continuidade de câmaras para a chegada exterior; Dev3 utiliza a prova física para seleccionar somente uma melhoria de composição do último enquadramento da Garganta, sem regressar a marcadores interiores rejeitados.


## Decisão CINE-PAIR-13 — Câmara de retorno preservada e aprovada

A medição da Garganta encontrou Elias orientado para a entrada com `yaw≈π`, inclinação de cabeça de `-0,2443 rad` e vector de avanço `(0, -0,242, 0,970)`. O retorno mantinha a geografia correta, mas o recarregamento de `main.tscn` podia reiniciar o prólogo Casa Voss e substituir a câmara restaurada.

O estado Orion passa agora a preservar também a inclinação vertical da cabeça. Além disso, `VossHouse.gd` detecta retorno pendente e não activa `CameraPrologoCasaVoss`. A nova captura de retorno mostra a Garganta sem cartela de prólogo e sob a câmara de Elias. A base limpa voltou a passar 30 segundos no mundo e no interior, sem erros.

**CINE-PAIR-14 já iniciado:** Dev4 audita as luzes locais e a orientação de leitura da Garganta após o retorno; Dev3 selecciona uma única melhoria exterior baseada na câmara preservada, sem reabrir qualquer DIR autónomo.
