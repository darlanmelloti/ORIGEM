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
