# CONTINUIDADE_DEV1 — CP 330 EM EXECUÇÃO

**Fronteira obrigatória:** Regiões 1–6 e Takes 1–11. Não alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem módulos das Regiões 7–12.

## Base preservada

Os CPs 317–330 consolidaram a tomada recuada de Casa Voss, a prioridade da câmara de prólogo, a materialidade PBR de terreno e a confirmação da chegada arqueológica ao Arco das Ruínas. A ponte positiva em `z=58` permanece um marco lateral real; a rota espacial e visual principal é Casa Voss → Estrada do Rio → Arco das Ruínas em `z=92`.

O CP 331 corrigiu a abertura em instâncias normais e QA. O contentor `Geometry`, `Interactables`, o protótipo do interior do santuário e os emissores Chronos são ocultados de forma determinística durante a abertura; a restituição depois do handoff devolve Geometry, interacções e a câmara de Elias. A validação headless, a auditoria de emissões QA, a captura aos 18 segundos e 30 segundos de gameplay normal passaram.

## CPs 332–335 — Auditorias e reversões registadas

O CP 332 comparou a tomada com a referência e determinou que o próximo ganho estrutural não poderia vir de câmara, ponte, talude, atmosfera, vegetação ou escala. O CP-CINE-05 testou uma cadeia arqueológica intermédia no CP 333; a captura não demonstrou ganho perceptível, logo a alteração foi revertida. O CP 334 testou macrotextura de solo sem ganho perceptível e também foi revertido. O CP 335 mapeou os nós da abertura e testou a ocultação de balizas remotas; essa hipótese foi igualmente revertida por não alterar a leitura do frame.

As reversões preservam a base CP317/CP331 e impedem reabertura de candidatos já esgotados. Todos os testes técnicos headless das hipóteses transitórias passaram; nenhum código de runtime destes três testes permaneceu no ramo.

## CP-CINE-07 — Em execução imediata

**Objectivo activo:** recapturar a tomada Casa Voss no FOV e posição CP317 quando o Dev2 integrar a cadeia remota R7–R9 ordenada em `DEV2_CP_CINE_06_CADEIA_MARCOS_REMOTOS.md`. O Dev1 não altera `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem módulos R7–R12; valida somente que a integração não regressa sobre Casa, Estrada, Arco, água, colisores ou escala do vale.

A matriz obrigatória está em `CP_CINE_07_MATRIZ_RECAPTURA_CASA_VOSS.md`. A sequência de evidência mantém Casa Voss, ponte positiva como marco lateral e Arco das Ruínas como destino Dev1, seguida por Vila/Observatório/contrafortes Dev2 em profundidade. Nenhum checkpoint encerra o ciclo: o retorno CP-CINE-07 abre CP-CINE-08 imediatamente.

## CP 336 — Orçamento local validado

A auditoria runtime confirmou que a abertura usa 1 luz local activa (margem 15) e o handoff usa 4 luzes locais activas, das quais 2 têm sombra (margem 12), apesar de o inventário global regional conter luzes em sectores distantes. A configuração é compatível com o limite de 16 luzes simultâneas da GTX 1050 Ti e foi preservada. O **CP-CINE-07 permanece em execução imediata**: ao chegar a integração Dev2 R7–R9, repetir a tomada CP317 sem mudar posição, FOV ou escala e abrir CP-CINE-08 no mesmo ciclo.

## CP 338 — Eixo R6→R7 validado

`ArvoreFocalMargem_02` foi deslocada de `(61, 290)` para a margem exterior `(8, 306)`. A conífera continua física e lateral, mas deixou de bloquear o eixo de chegada à Região 7. A captura de handoff CP 338 confirma estrada, terraços e Vila Elevada legíveis; a prova OpenGL de 30 segundos passou sem erro de script. Esta alteração restringe-se a `ForestLakeRegion.gd` (R6) e não toca `HighlandRegion.gd` nem qualquer módulo R7–R12.

## Próxima tarefa já em execução — CP-CINE-07 integrado

A chain Dev2 R7–R9 foi publicada na sua branch e preparada num workspace de integração separado. Repetir a matriz congelada Casa Voss e o handoff R6→R7 com o eixo agora aberto, comparar a leitura da cadeia cartográfica e abrir CP-CINE-08 sem pausa. A branch Dev1 mantém exclusivamente as Regiões 1–6.


## CP-CARTO-30 — Bacia R6 sem painel plano

No passe mais recente, a cascata oriental `QuadMesh` foi substituída por cinco filetes tridimensionais apoiados no promontório, eliminando a leitura de outdoor azul detectada em gameplay. O parser Godot 4.7.1 e o gameplay autónomo de 30 segundos na chegada às Ruínas passaram sem erro; a captura 1600×900 confirma a remoção do painel. A alteração permaneceu exclusivamente em `ForestLakeRegion.gd`.

## Próxima tarefa já em execução — CP-CARTO-31

Refinar a leitura material e a escala orgânica do limiar ocidental das Ruínas Submersas, preservando a rota física única, a estela de chegada e o orçamento de 16 luzes dinâmicas visíveis. Não repetir emissão de água, altura do leito, escurecimento das lajes, densificação linear do trilho, mastro Majestic ou alteração de balizas rejeitados em ciclos anteriores. A tarefa exige parser Godot 4.7.1, gameplay real mínimo de 30 segundos, captura 1600×900 e avaliação visual antes de abrir o próximo checkpoint.

A integração R6→R7 permanece pronta pelo checklist pareado e aguarda publicação Dev2 CP-D2-214; esta dependência não interrompe CP-CARTO-31.

## CP-CARTO-38 a CP-CARTO-44 — Continuidade recuperada e validações publicadas

Após a recuperação do checkout cinematográfico foram publicados os CP-CARTO-38 (solo PBR), CP-CARTO-39 (leitura discreta das lanternas Majestic), CP-CARTO-40 (espada PBR de Elias), CP-CARTO-43 (referência de script do menu sem UID obsoleto) e CP-CARTO-44 (guardas nulos no limitador adaptativo de luzes). Cada alteração aceite passou por Godot 4.7.1, por captura 1600×900 e por gameplay real mínimo de 30 segundos. O fluxo público **Menu → Novo Jogo → exploração** foi revalidado sem erro de parser, carga ou runtime.

Os ensaios CP-CARTO-41 (relva procedural lateral) e CP-CARTO-42 (tonalização global de fetos) foram rejeitados e revertidos porque a evidência não demonstrou ganho visual: não reabrir estes candidatos sem um activo de geometria superior e uma hipótese mensurável.

## Próxima tarefa já em execução — CP-CARTO-45

**Objectivo:** identificar, por nó, posição e função, os pequenos elementos claros ainda visíveis na tomada estacionária de chegada às Ruínas Submersas (`cp_carto42_ruins_stationary_1600x900.png`). O passe deve actuar somente sobre a fonte real do artefacto; não alterar novamente os fetos, a relva, a emissão de água, a cota do leito, as lajes, a estela ou a fronteira R6→R7 sem uma prova causal. Antes de qualquer promoção: parser Godot 4.7.1, gameplay real de 30 segundos, captura 1600×900 e avaliação visual. A dependência Dev2 CP-D2-214 continua não bloqueante para esta investigação R6.


## CP-CARTO-45 a CP-CARTO-53 — Evidência material e macro

O CP-CARTO-49 eliminou a fonte causal dos pequenos props claros da bacia: rochas de margem, acentos e afloramentos R6 herdavam o material claro do activo base; receberam o `ruin_material` sem alterar água, rota ou colisores. O CP-CARTO-50 eliminou a folha clara remanescente aplicando corte alfa PBR exclusivamente aos `FetoRibeirinho_*`. Ambos passaram no Godot 4.7.1 e em gameplay real de 30 segundos, com capturas 1600×900, e foram publicados em `afe49b8` e `6351b5b`.

Os CP-CARTO-48 e CP-CARTO-52 foram rejeitados e revertidos: a tonalização alfa dos fetos de entrada não alterou o artefacto e o recuo de uma árvore ribeirinha não melhorou a leitura macro do Arco. Não repetir estas hipóteses sem prova causal nova. As evidências CP-CARTO-51 e CP-CARTO-53 confirmam que a Estrada é física e estável, mas o Arco permanece pouco dominante no enquadramento macro de QA.

## Próxima tarefa já em execução — prova macro Casa Voss→Estrada→Arco

Preparar uma prova de QA que conserve no mesmo eixo a saída da Casa Voss, a Estrada do Rio e a silhueta do Arco. Não promover mudanças em vegetação, escala, água, lajes, iluminação ou módulos Dev2 até a captura demonstrar a oclusão causal. A dependência Dev2 CP-D2-214 continua pendente na ponta `fd31a63` e não bloqueia este passe R1–R6.


## CP-CARTO-54 e CP-CARTO-55 — Prova macro e Harness Arco

O CP-CARTO-54 reuniu duas sessões reais de 30 segundos para Casa Voss e Estrada→Arco; confirmou as âncoras físicas, mas não autorizou alteração cega do mundo. O CP-CARTO-55 confirmou que o alvo físico `z=92` é a projecção escalada da âncora cartográfica do Arco em `z=48` e corrigiu apenas a posição do estágio QA `arco`, que intersectava uma copa. O novo take mostra o arco completo sem alterar prólogo de produção, FOV de produção, rota, colisores, luzes ou Regiões 7–12.

A próxima alteração R1–R6 exige uma lacuna demonstrada por evidência macro de produção; a integração R6→R7 continua pendente em Dev2.

## CP-CARTO-70 — Saída Casa Voss: exterior validado, gesto E isolado

A validação deste ciclo produziu três sessões de aproximadamente 36 segundos. As duas tentativas de enviar `E` e `W` para o jogo com Xvfb foram inconclusivas: ambas preservaram o prompt de salto do prólogo e o servidor devolveu a limitação `XGetInputFocus ... window of 1`. Não se trata esta falha de foco como regressão da porta. A rotina `open_front_door()` foi revista: desactiva e remove explicitamente os três corpos de colisão da porta, desactiva as formas filhas e elimina as folhas visuais ao terminar a animação.

O harness exterior `ORIGEM_QA_SKIP_OPENING=1 ORIGEM_QA_ROUTE=road_return_voss` completou 36 segundos sem erro fatal, e a captura 1600×900 confirma o jogador já no espaço exterior, com Casa Voss, trilho e terreno carregados. Assim, a área exterior não contém uma parede física global; a validação end-to-end literal de E fica pendente apenas de um ambiente com foco de teclado funcional. As evidências e o registo completo estão em `/home/ubuntu/qa_evidence_voss_vista/CP_CARTO70_VOSS_DOOR_VALIDATION.md`.

**Próxima tarefa contínua:** aguardar uma entrega Dev2 posterior a `fd31a63` para executar CP-CARTO-56 no checkout de integração. Enquanto ela não existir, não reabrir hipóteses visuais rejeitadas nem alterar R7–R12 pela branch cinematográfica.

## CP-CARTO-71 — Ponte canónica: diagnóstico causal, sem promoção

O harness dedicado da ponte positiva em `z=58` completou gameplay real de 36 segundos e confirmou que a tomada Estrada→Arco normal não enquadra esse marco lateral. A captura dedicada revelou uma faixa azul horizontal. Uma sonda QA reversível ocultou apenas `SuperficieRioEstrada` e demonstrou que a faixa desaparece, atribuindo-a à lâmina de água e não à ponte. Porém, mesmo sem água a ponte não adquiriu leitura arquitectónica suficiente; por isso, não foi alterada a água, a altura do leito, a emissão, a ponte ou a rota. A sonda foi removida, o checkout voltou a código de produção idêntico e a hipótese «alterar a água para evidenciar a ponte» fica rejeitada. As três capturas de 36 s e o relatório causal estão em `/home/ubuntu/qa_evidence_voss_vista/CP_CARTO71_CANONICAL_BRIDGE_CAUSALITY.md`.

**Próximo ciclo contínuo:** conservar a ponte como marco lateral físico, sem usá-la como pretexto para reabrir água; verificar periodicamente Dev2 para CP-CARTO-56 e seleccionar apenas uma lacuna R1–R6 ainda não coberta por hipótese rejeitada.

## CP-CARTO-72 — Silhueta do Arco em z≈30: oclusão não atribuída

Uma tomada QA temporária em `z≈30`, orientada para o Arco físico em `z=92`, passou no parser Godot 4.7.1 e em 36 segundos de gameplay. A rota de lajes está clara, mas o Arco não se torna uma silhueta reconhecível no plano médio. A comparação com a raiz `VegetacaoEstradaDoRio` oculta demonstrou imagem praticamente idêntica: esse conjunto lateral **não** é a causa das coníferas no eixo. Nenhuma árvore, água, rocha, câmara ou geometria foi alterada; ambos os harnesses temporários foram removidos e o checkout voltou ao conteúdo de produção publicado. O relatório e as capturas estão em `/home/ubuntu/qa_evidence_voss_vista/CP_CARTO72_ARCH_SILHOUETTE_Z30.md`.

**Próxima tarefa contínua:** não deslocar árvores sem causa. A próxima investigação deve atribuir os nós das coníferas no plano médio pela sua raiz exacta; somente depois se avalia uma hipótese de leitura que não repita pilotos de árvore nem modifique R7–R12.

**Extensão CP-CARTO-72:** a raiz `TransicaoOrganicaArcoFloresta` também foi ocultada apenas em QA durante 36 segundos. As coníferas no plano médio e a oclusão do Arco permaneceram; esta raiz foi excluída como causa. A guarda foi removida e não há alteração de produção. A investigação futura deve atribuir a massa restante por nó exacto, não repetir esta exclusão.

## CP-CARTO-73 — Clareira focal do Arco aprovada

A investigação por exclusão identificou a raiz causal: `FlorestaDensaRegional` criava coníferas entre `z=72–92`, ocultando por completo o Marco 3. Em vez de remover a floresta, foi promovida uma clareira focal espacial nesse intervalo, equivalente às clareiras já existentes para rota, lago e Majestic. A captura de produção mostra o Arco completo ao final das lajes, com árvores laterais e massa florestal posterior ainda presentes; a melhoria não altera água, câmara, colisores de rota, Regiões 7–12 ou escala do Arco. Parser Godot 4.7.1 e gameplay real de 36 segundos passaram sem erro. As capturas e a matriz causal estão em `/home/ubuntu/qa_evidence_voss_vista/CP_CARTO73_ARCH_SIGHTLINE_CLEARANCE.md`.

**Próxima tarefa contínua:** preservar esta abertura como linha de visão canónica Casa Voss→Estrada→Arco; não reintroduzir instâncias da Floresta Densa em `z=72–92` sem nova prova de leitura superior. CP-CARTO-56 continua condicionado à publicação Dev2 posterior a `fd31a63`.

**Verificação complementar CP-CARTO-73:** o harness `arch_to_forest` concluiu mais 36 segundos sem erro fatal. A captura confirma densidade de bosque, troncos e trilho no lado posterior do Arco; a clareira pré-Arco não introduziu um corredor vazio na entrada da Floresta Densa.

## CP-CARTO-74 — Majestic→Lago: tomada válida, sem lacuna promovida

A primeira varredura usou o valor de rota não reconhecido `majestic_lake`; as imagens dessa execução não representam a travessia regional e foram invalidadas como prova. A rota reconhecida `majestic_to_lake` completou 36 segundos sem erro fatal e mostrou terreno, lajes e vegetação consistentes, sem a superfície clara aparente na execução inválida. A auditoria QA de malhas grandes não encontrou planos extensos próximos. Não foi alterada água, terreno, luzes, campamento ou rota; todas as sondas foram removidas. O detalhe está em `/home/ubuntu/qa_evidence_voss_vista/CP_CARTO74_MAJESTIC_LAKE_WHITE_SURFACE.md`.

**Próxima tarefa contínua:** usar apenas os identificadores QA reconhecidos no orquestrador. A busca por uma lacuna R1–R6 nova deve partir de uma captura válida; CP-CARTO-56 permanece à espera da entrega Dev2 posterior a `fd31a63`.

## CP-CARTO-75 — Varredura Floresta→Majestic sem promoção

A rota QA válida `forest_to_majestic` passou por 36 segundos de gameplay sem erro fatal e confirma lajes físicas, margens de floresta e direcção espacial para Majestic. Os pontos ciano no quadro são sinais P0 já investigados, não uma causa nova; a massa de árvores é a continuidade florestal validada e não justifica repetir pilotos de árvore, relva, fetos, trilho ou mastros Majestic já rejeitados. Nenhuma alteração de produção foi feita. Evidência: `/home/ubuntu/qa_evidence_voss_vista/CP_CARTO75_FOREST_TO_MAJESTIC_SCAN.md`.

**Próxima tarefa contínua:** preservar R4→R5 e repetir a verificação Dev2 antes de qualquer integração CP-CARTO-56; só abrir um novo passe R1–R6 com causa visual distinta e uma rota QA reconhecida.

## CP-CARTO-76 — Chegada R6 validada sem alteração especulativa

O harness válido `ruins_arrival` passou em 36 segundos, com spawn `(13.67871, 1.253814, 222.0)` e alvo `(54.0, 1.253814, 252.0)`. A tomada confirma a chegada física à bacia. Os pontos azul-ciano, a estela e os marcos emergentes são elementos já atribuídos: as balizas não podem ser reabertas após CP-CARTO-58 e os materiais de margem/fetos foram corrigidos nos CP-CARTO-49/50. Não há causa visual nova, logo nenhuma alteração de água, marcadores, luzes, rochas ou câmara foi promovida. Evidência: `/home/ubuntu/qa_evidence_voss_vista/CP_CARTO76_RUINS_ARRIVAL_SCAN.md`.

**Próxima tarefa contínua:** manter esta chegada como base de CP-CARTO-56 e verificar a entrega Dev2 antes de criar outro passe. A primeira alteração futura exige uma fonte causal distinta das hipóteses já rejeitadas.

## CP-CARTO-77 — Aterramento Majestic→Ruínas excluído como causa

A rota `forest_to_ruins` passou duas sessões de 36 segundos. Ao ocultar somente a raiz `AterramentoDaChegadaMajesticRuinas` no harness, os props laterais observados permaneceram visualmente idênticos; este agrupamento não é a causa. A guarda QA foi removida e não se alteraram as rochas, árvores ou fetos da aproximação. A matriz está em `/home/ubuntu/qa_evidence_voss_vista/CP_CARTO77_FOREST_TO_RUINS_CAUSALITY.md`.

**Próxima tarefa contínua:** não repetir esta exclusão. A fonte dos props restantes deve ser atribuída por nó exacto antes de qualquer alteração; CP-CARTO-56 continua dependente de Dev2 posterior a `fd31a63`.

### Extensão CP-CARTO-77 — Afluente cartográfico

A segunda sonda causal ocultou `AfluenteCartograficoRioParaBacia` apenas no harness `forest_to_ruins`. A água lateral desapareceu, confirmando a sua fonte; o prop laranja/escuro permaneceu, pelo que não pertence ao afluente. O material e a geometria da água não foram alterados, pois as variantes de água já foram rejeitadas. A guarda QA foi removida e a matriz CP-CARTO-77 foi actualizada.

### Extensão CP-CARTO-77 — Auditoria de nós e silhuetas de aproximação

A auditoria QA de nós próximos no spawn Floresta→Ruínas identificou os candidatos no corredor, incluindo `SilhuetasDeAproximacaoDaBacia`. Ao ocultar somente essa raiz em uma sessão válida de 36 segundos, o prop laranja/escuro de primeiro plano permaneceu. As silhuetas de aproximação ficam excluídas como causa, sem alteração de pilares ou bases. Todas as sondas e a auditoria foram removidas de `ForestLakeRegion.gd` e `TempleLevel.gd`; o checkout de produção voltou a limpo. A matriz actualizada está em `qa_evidence_voss_vista/CP_CARTO77_FOREST_TO_RUINS_CAUSALITY.md`.

**Próxima tarefa contínua:** não reabrir afluente, aterramento ou silhuetas de aproximação. O prop não identificado só pode ser tratado após associação inequívoca a um nó; CP-CARTO-56 mantém a prioridade de integração assim que Dev2 publicar R7.

### Fecho CP-CARTO-77 — Prop laranja atribuído

A auditoria espacial e a construção do sector atribuem o prop laranja/escuro à dupla física `RoloDeCampoMajestic` + `LanternaDeCampoMajestic` em `TransicaoMajesticParaRuinasSubmersas`. É a brasa âmbar discreta aprovada no CP-CARTO-39, não um prop de debug. Não reabrir emissão, material, posição ou quantidade de lanternas sem nova directiva; o diagnóstico CP-CARTO-77 encerra sem alteração de produção.

## CP-CARTO-78 — Régua cartográfica X/Z aprovada

Foi integrada em `TempleLevel.gd` uma telemetria QA exclusiva que regista posição física, marco mais próximo, posição no mapa e destino seguinte para as rotas R1–R6. A primeira prova identificou uma falha real: o destino cartográfico dependia apenas de Z e ignorava o ramo ocidental Majestic. `CartographicAnchors.next_dev1_destination` e `CartographicMapUI.gd` passaram a receber `Vector2(X,Z)`. Na faixa do conector (`z=150–202`), a orientação aponta para o Majestic no lado leste e para as Ruínas após cruzar para oeste. Parser e sessões de 36 segundos passaram; a repetição Floresta→Majestic confirmou `RUMO AO MAJESTIC` sem erro.

**Próxima tarefa contínua:** CP-CARTO-79 — leituras de horizonte Casa Voss→Estrada→Arco com a régua X/Z activa. Medir o marco seguinte no sentido cartesiano antes de qualquer mudança física; manter R7–R12 fora desta branch.

## CP-CARTO-79 — Primeiro horizonte cartográfico aceite

As rotas `road_return_voss` e `road_to_arch` passaram sessões de 36 segundos com Menu→Novo Jogo e a régua X/Z activa. A Casa Voss é legível no retorno físico da Estrada; o Arco é legível no eixo das lajes no sentido norte, sem redução artificial de distância. Não surgiu nova oclusão causal que justifique tocar em terreno, água, árvores, lajes ou luzes. Relatório: `qa_evidence_carto79/CP_CARTO79_FIRST_HORIZON.md`.

**Próxima tarefa contínua:** CP-CARTO-80 — leitura cartográfica Arco→Floresta→Majestic. Validar o desvio oeste e a reconvergência para R6 com a régua X/Z, sem criar sinalização artificial nem editar Regiões 7–12.

## CP-CARTO-80 — Eixo intermédio Arco→Floresta→Majestic

A régua X/Z confirmou a passagem real Arco→Floresta: a posição inicial `(-9.0, 107.0)` está a 9 m da âncora Floresta Densa e aponta correctamente para o marco 4. Em llvmpipe, a colisão concava regional não estabiliza antes do teleporte QA e a cápsula fica sem `is_on_floor()`; não se promoveu plataforma, laje ou geometria especulativa. O flag `ORIGEM_QA_CARTO_STABILIZE=1` apenas retém a gravidade no harness `arch_to_forest`, foi validado em 36 segundos e não existe na execução normal.

A captura Floresta→Majestic, em 1600×900 e 36 segundos, confirma a rota física e a decisão X/Z rumo a Majestic, mas a bifurcação ocidental ainda não tem um marco tridimensional suficientemente legível no horizonte. A próxima correcção causal será o piloto **Estela de Direcção Majestic**, especificado em `PLANO_PILOTO_MESHY_CP_CARTO81.md`, exclusivamente quando estiver disponível um GLB descarregável; até lá, a composição de produção fica preservada. Evidências: `qa_evidence_carto80/CP_CARTO80_INTERMEDIATE_AXIS.md`, `arch_to_forest_stabilized_960x540.png` e `forest_to_majestic_1600x900.png`.

## CP-CARTO-81 — Estela Majestic: piloto rejeitado

A estela base foi temporariamente recuada e ampliada apenas em QA na rota Floresta→Majestic. A sessão de 36 segundos passou e a régua X/Z continuou a apontar para o marco 5, mas a silhueta maior não tornou a bifurcação inequivocamente legível nem atingiu o ganho mínimo de 85%. A sonda foi removida e o modelo de produção ficou inalterado. Não repetir escala ou posição desta estela com a malha `stone_tallC.glb`; o próximo candidato é um GLB assimétrico dedicado, descrito em `PLANO_PILOTO_MESHY_CP_CARTO81.md`, quando estiver descarregável.

## CP-CARTO-82 — Eixo Majestic→Ruínas validado

A rota `majestic_to_lake` passou 36 segundos no Godot 4.7.1 e a régua X/Z definiu correctamente as Ruínas Submersas como marco 6 a partir de `(-77.40, 178.00)`. A primeira perna mostra lajes físicas rumo à margem regional; a bacia não é forçada para o horizonte antes da curva oriental, preservando a distância macro do mapa. Nenhuma geometria, água, vegetação, ruína ou luz foi alterada. Evidência: `qa_evidence_carto82/CP_CARTO82_MAJESTIC_TO_RUINS.md`.

## CP-CARTO-83 — Bifurcação Floresta→Majestic: cairn rejeitado, captura QA aprovada

- **Cairn direccional:** `REJECTED_VISUAL`. A sessão `forest_to_majestic` de 36 s confirmou a direcção X/Z correcta (`próximo=5:RUMO AO MAJESTIC`), mas a pilha de rochas não adquiriu leitura focal no horizonte; a sonda foi integralmente removida de `ForestLakeRegion.gd`.
- **Evidência válida:** `qa_evidence_carto83/forest_to_majestic_cairn_viewport_960x540.png` foi gravada pelo viewport já renderizado, depois do spawn; log confirma `result=0` e telemetria de distâncias.
- **Ferramenta QA aprovada:** `ORIGEM_QA_VIEWPORT_SNAPSHOT` apenas actua com a variável de ambiente, espera dois frames de composição e elimina o falso splash do Xvfb sem afectar jogo normal.
- **Meshy:** o piloto de estela assimétrica continua especificado, mas não existe GLB recuperável depois do reset da sessão/conta. Não recriar cairn, não alterar a estela actual e não tocar lanternas, água, fetos, rochas ou árvores aprovados.
- **Próximo passo activo:** CP-CARTO-84 — validar a margem Majestic→Ruínas pelo viewport QA e investigar somente uma divergência visual causal nova.

## CP-CARTO-84 — Ligação física Majestic→Margem R6 aprovada

O diagnóstico da rota `majestic_to_lake` revelou uma lacuna curta entre `LigacaoMajesticAoTrilhoFlorestal` e `TrilhoAteAMargemDoLago`. Foi promovida `LigacaoFisicaMajesticParaMargem`: seis lajes tridimensionais e colisores baixos no único intervalo local que impedia a continuidade literal R5→R6. A alteração não acrescenta luzes, água, vegetação, placas, colisores laterais nem módulos R7–R12.

O harness QA passou a apontar o take Majestic para a primeira laje real de R6. Parser Godot 4.7.1, Menu→Novo Jogo, 36 segundos de gameplay e captura interna 1920×1080 passaram. A régua X/Z confirma `proximo=6:RUMO ÀS RUÍNAS` a partir do marco 5. A evidência encontra-se em `qa_evidence_carto84/CP_CARTO84_MAJESTIC_TO_RUINS_PHYSICAL_LINK.md`.

**Próximo passo activo:** CP-CARTO-85 — validar a entrada em movimento da margem R6, preservando a nova continuidade e sem repetir estelas, cairns, lanternas, fetos, rochas, água ou árvores já rejeitados.

## CP-CARTO-85 — Entrada física Majestic→Margem validada em movimento

O harness `ORIGEM_QA_CARTO_LINK_WALK=1` percorreu a nova ligação R5→R6 com `move_and_slide()` e a física normal do jogador, sem depender do foco Xvfb. Ao frame físico 30, Elias avançou do spawn e permaneceu `no_chao=true`; a captura interna do viewport mostra as lajes no eixo correcto e a régua X/Z mantém `proximo=6:RUMO ÀS RUÍNAS`. A janela completa foi de 36 s. Sob llvmpipe, a cadência baixa não permite alegar chegada automática à margem inteira, mas valida a entrada e a primeira secção da continuidade sem queda ou bloqueio.

A telemetria só activa no harness, não altera o jogo normal. Não foram mudadas luzes, água, árvores, fetos, rochas, estelas, cairns ou Regiões 7–12. Evidência: `qa_evidence_carto84/CP_CARTO85_MAJESTIC_RUINS_LINK_WALK.md`.

**Próximo passo activo:** CP-CARTO-86 — auditar a chegada visual a R6 desde o eixo Majestic, usando a captura interna e promovendo apenas uma causa visual nova; o piloto Meshy continua pendente de GLB recuperável.

## CP-CARTO-86 — Chegada R6 deixa de regressar ao Majestic

A tomada `ruins_arrival` revelou uma contradição cartográfica: Elias já estava no marco 6, mas `next_dev1_destination()` devolvia `RUMO AO MAJESTIC`. A causa era a ausência de uma janela específica de aproximação R6 entre `z=210` e `z<234`. A regra agora devolve `6: CHEGADA ÀS RUÍNAS`; somente depois do limiar `z>=234` continua a mostrar `PASSAGEM: VILA ELEVADA`, sem criar nem tocar módulos R7–R12.

Parser Godot 4.7.1, Menu→Novo Jogo, 36 s de runtime, captura interna 1920×1080 e régua X/Z foram aprovados. Evidência: `qa_evidence_carto86/CP_CARTO86_RUINS_ARRIVAL_DESTINATION.md`.

**Próximo passo activo:** CP-CARTO-87 — auditar a coerência do mapa UI no estado de chegada R6 e manter a passagem R7 sob a checklist pareada Dev2.

## CP-CARTO-87 — Mapa UI coerente no estado R6

A captura QA com o mapa aberto confirmou no mesmo quadro o marcador ELIAS na área do marco 6 e o destino `CHEGADA ÀS RUÍNAS`. A UI consome a mesma regra X/Z corrigida no CP-CARTO-86; não houve discrepância de posição, destino ou etiqueta, e nenhuma mudança de produção foi necessária. A imagem mantém os doze marcos do mapa oficial visíveis, mas a branch continua limitada às Regiões 1–6. Evidência: `qa_evidence_carto87/CP_CARTO87_R6_MAP_UI_COHERENCE.md`.

**Próximo passo activo:** CP-CARTO-88 — verificar a continuidade macro do marcador ELIAS entre Majestic e Ruínas no mapa oficial, sem reabrir elementos ambientais já rejeitados.


## CP-CARTO-088 a CP-CARTO-090 — Estado publicado

O CP-CARTO-088 preservou a abertura R1→R3 após o passe de terreno; o CP-CARTO-089 rejeitou o activo focal Poly Haven por ausência de ganho visual e restaurou o pinheiro PBR aprovado. O CP-CARTO-090, publicado em `c9fbc75`, substituiu a textura base de solo excessivamente granular pelo conjunto PBR `forest_ground_06`, converteu manchas de margem em volumes baixos tridimensionais ancorados ao terreno e ensaiou afloramentos CC0 inclinados fora da rota. Parser e gameplay de 36 segundos Casa Voss→Arco passaram; o resultado artístico permanece **REJECTED_VISUAL** porque a composição macro não atinge 85% do padrão solicitado.

**Próxima tarefa já iniciada — CP-CARTO-091:** atribuir por nome, classe, posição e material o marcador azul-ciano residual da captura `road_to_arch`, sem alterar vegetação, água, Arco, rotas ou luzes enquanto não houver uma fonte causal concreta. A evidência deve incluir parser Godot 4.7.1, 36 segundos de gameplay, captura 1600×900 ou superior e a comparação antes/depois. A branch continua limitada estritamente às Regiões 1–6.


## CP-CARTO-091 — Hipótese `MarcoRibeirinho` rejeitada

A sonda de nós visíveis identificou `MarcoRibeirinho_00` como candidato espacial próximo no horizonte. A sua tampa rúnica e luz foram ocultadas exclusivamente no harness `road_to_arch`; a captura de 36 segundos manteve o ponto azul-ciano sem alteração. A hipótese foi revertida integralmente, sem mudança no jogo de produção. Relatório: `CP_CARTO_091_MARCADOR_HORIZONTE_AUDITORIA.md`.

**Próxima tarefa já iniciada — CP-CARTO-092:** construir uma sonda QA de projecção câmara→mundo na rota `road_to_arch`, registando somente nós que projectem no quadrante visual direito onde o artefacto é observado. Não repetir ocultações por cor, `MarcoRibeirinho`, água, vegetação, Arco, luzes ou balizas sem associação de pixel demonstrável. Manter a fronteira R1–R6 e validar parser, 36 segundos de gameplay e captura antes de qualquer promoção.


## CP-CARTO-092 — Projecção do carvalho rejeitada

A sonda câmara→mundo filtrou o quadrante do artefacto e encontrou apenas a malha `tree_oak_dark` em `(-26.16133, 0.348372, 30.0)`. A ocultação exclusiva de QA foi validada durante 36 segundos e não modificou o ponto azul-ciano. A hipótese foi revertida; não repetir carvalho, Marco Ribeirinho, filtros amplos de cor ou alterações de vegetação baseadas nesse pixel. Relatório: `CP_CARTO_092_PROJECCAO_CARVALHO_REJEITADA.md`.

**Próxima tarefa já iniciada — CP-CARTO-093:** auditar a legibilidade material da rota de lajes Casa Voss→Arco usando somente os materiais existentes e sem mudar posição, escala, colisores, água, árvores, Arco ou luzes. O objectivo é distinguir a rota de pedra do solo PBR alternativo a médias distâncias; a hipótese só pode ser promovida se a captura de 36 segundos demonstrar ganho visual mensurável e preservação completa da trajectória física.


## CP-CARTO-093 — Lajes com leitura material reforçada

A Estrada do Rio conservou malha, rota, colisores e âncoras, mas recebeu uma calibração material mineral mais quente e normal reduzida. A captura de 36 segundos Casa Voss→Arco mostra a sequência de lajes melhor separada do solo PBR. O ganho é local e não encerra o refinamento visual do vale. Relatório: `CP_CARTO_093_MATERIAL_LAJES_ESTRADA.md`.

**Próxima tarefa já iniciada — CP-CARTO-094:** auditar a composição vegetal do horizonte R1→R3 em três planos (primeiro, médio, fundo), usando exclusivamente os activos reais já carregados. A primeira acção é identificar por raiz os conjuntos que contribuem para a leitura repetitiva, sem mover, escalar ou eliminar instâncias antes de uma associação causal. Não repetir a clareira pré-Arco, os pilotos de árvore, as alterações de água, a relva procedural ou qualquer candidato rejeitado.


## CP-CARTO-095 — Crista recuada R1→R3 validada

A crista lateral recuada em `z≈132` passou parser e 36 segundos de gameplay Casa Voss→Arco. O eixo navegável foi preservado por uma depressão central; a leitura obtém um terceiro plano topográfico posterior ao Arco sem alterar âncoras, colisores, água, luzes ou módulos R7–R12. Relatório: `CP_CARTO_095_CRISTA_RECUADA_ARCO.md`.

**Próxima tarefa já iniciada — CP-CARTO-096:** compor uma única faixa vegetal intermédia sobre a nova crista, usando apenas uma das árvores CC0 reais já aprovadas e posicionando-a fora do eixo da rota e da clareira do Arco. A hipótese deve introduzir variação de silhueta, não densidade linear; requer parser, gameplay de 36 segundos, captura e avaliação antes de promoção.


## CP-CARTO-096 — Silhueta isolada na crista rejeitada

A terceira árvore detalhada CC0 temporária em `z=132` passou tecnicamente, mas não alterou a leitura do horizonte na captura de 36 segundos. Foi removida por completo; não repetir a mesma posição, escala ou orientação. Relatório: `CP_CARTO_096_SILHUETA_CRISTA_REJEITADA.md`.

**Próxima tarefa já iniciada — CP-CARTO-097:** repetir a atribuição do marcador azul-ciano usando a janela de projecção normalizada correcta, centrada aproximadamente em `x=0.66, y=0.44` da captura 1920×1080. A auditoria deve incluir `Light3D` além de malhas visuais, pois a primeira sonda filtrou apenas malhas no quadrante incorrecto. Não repetir Marco Ribeirinho ou `tree_oak_dark`.


## CP-CARTO-097 — Marcador residual não atribuído

As exclusões QA da luz e do contexto Majestic, dos sinais P0 e de materiais azul-ciano remotos não alteraram o ponto residual no quadro Casa Voss→Arco. As sondas foram removidas integralmente; não há alteração de produção. Relatório: `CP_CARTO_097_MARCADOR_RESIDUAL_NAO_ATRIBUIDO.md`.

**Próxima tarefa já iniciada — CP-CARTO-098:** auditar a silhueta geológica lateral da crista recém-promovida, identificando se um dos afloramentos CC0 existentes pode receber apenas material/escala de leitura sem alterar posição, rota, Arco, vegetação, água ou luzes. A hipótese exige uma diferença visual mensurável na captura Casa Voss→Arco, parser Godot 4.7.1 e 36 segundos de gameplay antes de promoção.


## CP-CARTO-098 e CP-CARTO-099 — Auditoria geológica e tomada de recuo

A auditoria CP-CARTO-098 confirmou que os afloramentos laterais já estão distribuídos em quatro famílias CC0 e não autoriza uma mudança cega de material, escala ou posição. A tomada QA `road_to_arch_recede` do CP-CARTO-099 passou por 36 segundos no mesmo eixo Casa Voss→Arco; revelou que a massa escura lateral é a malha física `SuperficieRioEstrada`. Não alterar água: hipóteses dessa família já foram rejeitadas. A ferramenta QA de recuo foi preservada e não afecta jogo normal.

**Próxima tarefa já iniciada — CP-CARTO-100:** auditar a leitura espacial da Casa Voss no recuo através da rota `road_return_voss`, comparando a origem doméstica, a margem do rio e a direção do Arco sem alterar Casa, porta, iluminação, água, câmaras ou módulos R7–R12. Só uma lacuna visual nova e causal poderá abrir alteração de produção.


## CP-CARTO-100 — Retorno à Casa Voss validado

A rota `road_return_voss` ganhou captura interna de viewport e passou 36 segundos de gameplay. A limpeza cartográfica QA passou a correr antes da fotografia e removeu o `MarcoChronosAzulRemoto` remoto sem alterar produção, porta, rota ou colisores. Relatório: `CP_CARTO_100_RETORNO_CASA_VOSS_QA.md`.

**Próxima tarefa já iniciada — CP-CARTO-101:** validar a leitura de saída da Casa Voss no sentido inverso, Casa→Estrada, para comparar a origem doméstica com rio, lajes e Arco distante. O passe deve usar a rota QA existente ou uma tomada reversível equivalente, preservar FOV/câmara de produção e exigir parser Godot, 36 segundos e captura antes de qualquer alteração ambiental.


## CP-CARTO-101 — Saída Casa Voss→Estrada validada

A tomada QA `voss_to_road` foi inicialmente rejeitada por nascer dentro da casa. O spawn passou a usar a transformação real da soleira exterior e a recaptura de 36 segundos confirmou caminho livre para as lajes e o Arco, sem mexer em porta, câmara, FOV ou colisores. A qualidade global permanece abaixo do limiar artístico; relatório: `CP_CARTO_101_SAIDA_CASA_ESTRADA_QA.md`.

**Próxima tarefa já iniciada — CP-CARTO-102:** avaliar uma única camada atmosférica de profundidade usando os parâmetros existentes do `LevelEnvironment`, primeiro em modo QA e sem alterar luzes, água, FOV, geometria, árvores, Arco ou módulos R7–R12. A correcção só é promovível se a captura Casa Voss→Arco demonstrar separação adicional entre os planos do vale.


## CP-CARTO-102 — Profundidade atmosférica rejeitada

O perfil QA de neblina moderadamente mais densa passou tecnicamente, mas reduziu o contraste intermédio e não atingiu ganho visual suficiente. Foi totalmente revertido; não repetir densidade, cor, saturação ou `fog_sky_affect` isoladamente. Relatório: `CP_CARTO_102_ATMOSFERA_PROFUNDIDADE_REJEITADA.md`.

**Próxima tarefa já iniciada — CP-CARTO-103:** auditar a leitura de escala da vegetação no enquadramento Casa Voss→Arco, contando os modelos por tipo e distância. A auditoria não pode criar, mover ou remover árvores: deve apenas determinar se a discrepância visual provém de LOD, escala, espécies ou enquadramento antes de abrir qualquer hipótese de produção.


## CP-CARTO-103 — Auditoria de escala vegetal

A auditoria confirmou seis núcleos arbóreos espaçados no corredor e uma janela preservada diante do Arco. A Casa Voss concentra os assets de maior escala e requer avaliação por enquadramento antes de qualquer troca de espécie, posição ou LOD. Relatório: `CP_CARTO_103_AUDITORIA_ESCALA_VEGETAL.md`.

**Próxima tarefa já iniciada — CP-CARTO-104:** criar uma única tomada QA lateral da soleira da Casa Voss, sem mover geometria, vegetação, rio ou Arco, para distinguir erro de composição de erro de activo. Exigir parser Godot, 36 segundos, captura e decisão antes de alterar produção.


## CP-CARTO-104 e CP-CARTO-105 — Tomada lateral e margem inicial

A tomada lateral da Casa Voss passou 36 segundos e confirmou que a discrepância principal não se resolve por árvore ou câmara isolada. O afloramento CC0 temporário em `z=17` na margem inicial não produziu ganho visual perceptível e foi removido. Não repetir essa rocha isolada. Relatório: `CP_CARTO_105_AFLORAMENTO_MARGEM_INICIAL_REJEITADO.md`.

**Próxima tarefa já iniciada — CP-CARTO-106:** auditar a estrutura contínua da `SuperficieRioEstrada` (largura, variação de altura e segmentos de triângulos) em contraste com a posição da câmara lateral, sem editar a água. O objectivo é decidir se a massa escura é uma limitação de material, composição ou topologia antes de autorizar qualquer nova solução.


## CP-CARTO-106 e CP-CARTO-107 — Topologia e largura do rio

A auditoria comprovou que o rio é geometria contínua de 32 segmentos, não um painel. As larguras experimentais de 10,8 m e 8,6 m passaram gameplay mas não reduziram materialmente a massa escura lateral; ambas foram revertidas e a largura canónica de 14,0 m foi restaurada. Não repetir largura, material, neblina ou rocha isolada. Relatório: `CP_CARTO_107_LARGURA_RIO_REJEITADA.md`.

**Próxima tarefa já iniciada — CP-CARTO-108:** instrumentar uma sonda QA de geometria no enquadramento lateral para identificar nós visíveis com albedo muito escuro e projecção no quadrante esquerdo do rio. Não ocultar nem alterar produção antes de a sonda produzir um candidato causal único.


## CP-CARTO-108 — Faixa escura da Casa Voss removida

A auditoria causal identificou `EstradaDeLamaConformada` como a camada visual auxiliar responsável pela faixa escura irregular na saída. A construção foi desactivada; lajes físicas, soleira, rota para o Arco e camada macro posterior foram preservadas. As tomadas lateral e Casa Voss→Arco passaram 36 segundos. Relatório: `CP_CARTO_108_ESTRADA_LAMA_REMOVIDA.md`.

**Próxima tarefa já iniciada — CP-CARTO-109:** auditar o pequeno objecto ciano residual junto à rota de saída agora que a faixa escura foi removida. A auditoria deve primeiro identificar nome, posição e material na tomada lateral. Não ocultar nem modificar a produção até existir atribuição causal única; não reabrir as hipóteses de rio, água, atmosfera, sombras ou estrada auxiliar já encerradas.


## CP-CARTO-109 — Sinal ciano residual não atribuído

A projecção de câmara, o raio no pixel e a ocultação QA da única árvore lateral coincidente não explicaram o pequeno sinal ciano. A sonda foi revertida sem tocar produção. Relatório: `CP_CARTO_109_SINAL_CIANO_NAO_ATRIBUIDO.md`.

**Próxima tarefa já iniciada — CP-CARTO-110:** auditoria de escala do corredor Casa Voss→Arco. Medir a relação entre largura das lajes, distância ao Arco e altura das silhuetas arbóreas nos dois enquadramentos QA limpos. Só propor alteração se a leitura demonstrar um problema causal de escala; não retomar a investigação do sinal ciano nem candidatos já rejeitados.


## CP-CARTO-110 — Escala Casa Voss→Arco auditada

A escala foi verificada contra as âncoras canónicas: Casa→Arco = 40,344 m e Arco→Floresta = 68,439 m. As capturas CP-CARTO-108 preservam essa continuidade. Não existe causa de escala que justifique mover marcos, mudar FOV ou comprimir o terreno. Relatório: `CP_CARTO_110_ESCALA_CORREDOR_CASA_ARCO.md`.

**Próxima tarefa já iniciada — CP-CARTO-111:** auditar a leitura material local do Arco das Ruínas e da junta final das lajes. Aplicar no máximo uma melhoria reversível de valor/normal, apenas se não alterar o arco estrutural, as distâncias, os colisores ou a rota.


## CP-CARTO-111 — Material exclusivo do Arco rejeitado

O material PBR exclusivo do Arco não gerou ganho visual suficiente na rota validada de 36 segundos. A alteração foi revertida, sem tocar em luzes, geometria, colisores ou âncoras. Relatório: `CP_CARTO_111_MATERIAL_ARCO_REJEITADO.md`.

**Próxima tarefa já iniciada — CP-CARTO-112:** auditoria de transição entre as últimas lajes da Estrada do Rio e a clareira do Arco. Medir os elementos que ainda interrompem a leitura do caminho; não repetir alterações de material do Arco, escala, atmosfera, água, árvores isoladas ou camadas auxiliares já rejeitadas.


## CP-CARTO-112 — Sinal ciano auditado sem atribuição única

A componente visual residual foi localizada no ecrã, mas não houve nó 3D, colisor ou elemento UI causal. A instrumentação foi revertida e não se farão alterações especulativas. Relatório: `CP_CARTO_112_AUDITORIA_SINAL_CIANO.md`.

**Próxima tarefa já iniciada — CP-CARTO-113:** testar uma crista topográfica secundária, ampla e recuada entre o Arco e a entrada da Floresta Densa (R4), fora da rota e das clareiras. A finalidade é criar planos de profundidade reais, não um outdoor. Preservar as âncoras, o Arco, as lajes, as luzes e as Regiões 7–12; reverter se a tomada Casa Voss→Arco não demonstrar ganho visual claro.


## CP-CARTO-113 — Crista secundária rejeitada

A elevação secundária Z=174 não produziu ganho de profundidade suficiente na tomada de 36 segundos e foi revertida. Não foram alterados rota, marcos, luzes, colisores ou limites das Regiões 1–6. Relatório: `CP_CARTO_113_CRISTA_SECUNDARIA_REJEITADA.md`.

**Próxima tarefa já iniciada — CP-CARTO-114:** auditar a transição visual das últimas lajes da Estrada do Rio para a clareira do Arco, identificando apenas o primeiro elemento que interrompe a leitura da rota. Não repetir materiais do Arco, cristas, água, atmosfera, largura do rio, árvores isoladas ou quaisquer hipóteses já rejeitadas.


## CP-CARTO-114 — Transição lajes→Arco validada

A profundidade visual das lajes cresce gradualmente no troço Z=76→120, deixando a aproximação ao Arco mais contínua sem modificar os colisores, o eixo, a água, as luzes ou as âncoras. O parser Godot e o gameplay de 36 segundos passaram. Relatório: `CP_CARTO_114_TRANSICAO_LAJES_ARCO_VALIDADA.md`.

**Próxima tarefa já iniciada — CP-CARTO-115:** auditar a leitura da margem do rio na tomada lateral Casa Voss, agora sem a faixa escura auxiliar. Seleccionar apenas uma melhoria causal de margem ou de material de água que não repita largura do rio, afloramento isolado, atmosfera ou camadas hídricas já rejeitadas.


## CP-CARTO-115 — Composição ribeirinha compactada rejeitada

A redução de micro-rochas e fetos para agrupamentos maiores passou tecnicamente, mas não produziu ganho visual suficiente na tomada lateral de 36 segundos. A margem original foi restaurada. Relatório: `CP_CARTO_115_MARGEM_RIBEIRINHA_REJEITADA.md`.

**Próxima tarefa já iniciada — CP-CARTO-116:** auditar a leitura de relevo entre o rio e o arco no enquadramento lateral, isolando a primeira camada de geometria que crie sensação de planura. Não repetir largura do rio, redução de densidade, afloramento isolado, materiais de água, atmosfera, cristas ou camadas auxiliares já rejeitados.


## CP-CARTO-116 — Folhagem da Floresta Densa calibrada

A comparação causal no pixel do sinal ciano identificou um carvalho `OAK_DARK`. A redução selectiva da componente azul em materiais verde-azulados foi promovida para todas as instâncias desse activo, sem alterar texturas, troncos, escala, rota, colisores ou luzes. Parser e gameplay regional de 36 segundos passaram. Relatório: `CP_CARTO_116_FOLHAGEM_FLORESTA_CALIBRADA.md`.

**Próxima tarefa já iniciada — CP-CARTO-117:** validar a chegada ao Acampamento Majestic na mesma rota R4→R5 e auditar a primeira lacuna de leitura no destino. Não repetir alterações de folhagem OAK, marcadores P0, marcos ribeirinhos, composição de margem ou candidatos anteriormente rejeitados.


## CP-CARTO-117 — Árvore Majestic aterrada

A silhueta suspensa do talude esquerdo foi atribuída a `ArvoreDaFloresta_28`. A conífera incompatível foi substituída por `DARK_TREE` à escala 0,52, eliminando o objecto suspenso sem mover a rota, a clareira, os colisores, a cartografia ou as luzes. Parser e gameplay de 36 segundos passaram. Relatório: `CP_CARTO_117_ARVORE_MAJESTIC_ATERRADA.md`.

**Próxima tarefa já iniciada — CP-CARTO-118:** validar a transição física Acampamento Majestic→Ruínas Submersas na rota cartográfica e localizar a primeira lacuna visual causal da margem de chegada. Não repetir a substituição de `ArvoreDaFloresta_28`, a calibração OAK, os candidatos hídricos, marcos cianos, cristas ou alterações ambientais já rejeitadas.
