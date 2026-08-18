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
