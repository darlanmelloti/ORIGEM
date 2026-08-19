# CONTINUIDADE_DEV5 — Mundo Cartesiano e Terceira Pessoa

**Branch:** `feature/dev5-cartographic-world-third-person`.

**Base:** `3ba5638` de `feature/cine07-final`.

**Regra permanente:** um checkpoint é evidência, não paragem. Depois de publicar, ler este ficheiro, iniciar o item seguinte permitido e manter o ciclo de parser Godot + 30 segundos de gameplay/captura + avaliação visual + commit/push. **É proibido aguardar 10 segundos ou esperar que alguém publique uma tarefa.** Quando não existir item explícito, Dev5 abre e executa no mesmo ciclo a primeira tarefa da escada: (1) regressão/integração pendente; (2) composição QA de dois ou mais marcos ainda não comparada; (3) candidato 3D QA no marco menos coberto; (4) auditoria de activos/LOD; (5) proxy Elias em terceira pessoa. A tarefa escolhida deve tornar-se `ACTIVO` no marcador antes da alteração; uma fila vazia abre uma tarefa derivada, nunca uma espera.

**Sincronização Git:** `gh auth status` é opcional e não determina se a branch pode publicar. Antes de declarar bloqueio, comparar obrigatoriamente `git rev-parse --short HEAD`, `origin/feature/dev5-cartographic-world-third-person` e `git rev-list --left-right --count origin/feature/dev5-cartographic-world-third-person...HEAD`. Quando houver commits locais, usar a credencial autorizada para o `git push`; quando a contagem for `0 0`, declarar a branch sincronizada e continuar a tarefa activa.

## Fronteira

Dev5 cria módulos novos em `levels/dev5/`, `assets/models_dev5/` e `entities/player/third_person/`. Não altera módulos existentes R1–R6 nem qualquer módulo R7–R12 no primeiro ciclo. A integração com o mundo principal requer prova autónoma e revisão Dev1.

## Referências obrigatórias

- `references/dev5/MAP.webp` — mapa oficial, autoridade espacial.
- `references/dev5/Elias1600x900.jpg` — direcção artística para a apresentação de Elias em terceira pessoa; não é um modelo rigado.
- `diretor_orientacoes/ONBOARDING_DEV5_MUNDO_CARTESIANO.md` — estrutura, orçamento e protocolo.

## CP-D5-001 — CONCLUÍDO

Foi criado `levels/dev5/CartographicLandmarkObjects.gd` como root modular de objectos cartográficos, com biblioteca de materiais, orçamento técnico e gerador isolado de ponte. O parser Godot 4.7.1 passou sem tocar em módulos regionais centrais.

## CP-D5-002 — CONCLUÍDO EM QA

A Ponte de Pedra do marco 2 foi construída e validada na cena isolada `StoneBridgeLandmarkPreview.tscn`. Possui tabuleiro de 7 lajes com colisores próprios, dois encontros, arcos por aduelas, parapeitos descontínuos e zero luzes dinâmicas. O parser Godot passou e a cena manteve 36 segundos de sessão com captura interna válida. A ponte está **aprovada apenas como candidata**; não deve ser ligada à Estrada do Rio sem revisão e integração pelo proprietário R1–R6.

A evidência técnica está em `CP_D5_002_PONTE_MARCO2_QA.md`.

## CP-D5-003/004 — CONCLUÍDO COMO PROXY QA

A apresentação isolada de Elias recebeu melhorias de silhueta: colete aberto, cinto e fivela, cabelo assimétrico, bolsa lateral e espada com punho. O parser Godot 4.7.1 passou e a cena QA manteve 36 segundos com captura interna. É uma **proxy técnica**, não uma substituição de `Player.gd` nem o modelo artístico final; não toca primeira pessoa, porta E, salto, stamina ou Casa Voss.

## CP-D5-005 — CONDICIONAL, NÃO BLOQUEANTE

O candidato humano rigado está identificado, mas a aquisição automática do GLTF/FBX gratuito foi bloqueada pelo CAPTCHA do fornecedor. Integrar somente quando existir um ficheiro recuperável e uma licença/atribuição documentada. Esta condição não bloqueia nenhuma outra tarefa Dev5.

## CP-D5-006 — CONCLUÍDO EM QA

O anexo tridimensional Casa Voss foi validado isoladamente em `VossWaystationPreview.tscn`: paredes volumétricas, abertura frontal, cobertura física de duas águas e colisores próprios. O objecto ainda não pode ser colocado em `VossHouse.gd`; ver `CP_D5_006_CASA_VOSS_ANEXO_QA.md`.

## CP-D5-007 — CONCLUÍDO

A ficha `CP_D5_007_FICHAS_INTEGRACAO_R1_R6.md` foi preparada para os candidatos Dev5: ponte do marco 2 e anexo Casa Voss. Ela fixa âncoras, orçamento, colisores, proprietário R1–R6 e testes de aceitação, sem alterar módulos de produção.

## CP-D5-008 — CONCLUÍDO EM QA

O pavilhão de Acampamento Majestic foi validado isoladamente em `MajesticPavilionPreview.tscn`: estrado, postes, cobertura inclinada, lona lateral, banco e colisores próprios. O parser passou e a cena manteve 36 segundos com captura interna. O objecto permanece fora de `ForestLakeRegion.gd`; ver `CP_D5_008_PAVILHAO_MAJESTIC_QA.md`.

## CP-D5-009 — CONCLUÍDO

A matriz `CP_D5_009_MATRIZ_REVISAO_DEV1.md` ordena a revisão Dev1: ponte do marco 2, anexo Casa Voss e pavilhão Majestic. Ela proíbe integração simultânea, fixa os testes de aceitação e preserva todas as Regiões de produção até decisão do proprietário.

## Directiva de produção contínua Dev5

Dev5 é uma frente activa de **criação e refinamento do mapa real**, não uma frente de espera. A ausência de um humano rigado externo ou de uma selecção Dev1 só bloqueia a integração desse elemento específico; nunca bloqueia a criação de candidatos QA independentes, documentação espacial, ensaios de colisão ou a próxima prova de 36 segundos.

Depois de cada checkpoint, Dev5 deve ler este marcador, abrir imediatamente o próximo item permitido, actualizar o estado para **ACTIVO** e continuar. A regra é: uma evidência concluída abre a tarefa seguinte; nunca encerra o ciclo.

## CP-D5-010 — REJEITADO EM QA

O arco de ruínas estrutural teve parser e sessão de 36 segundos, mas foi rejeitado porque a captura revelou blocos demasiado primitivos e sem ganho suficiente sobre o arco de produção. O código e cenas QA foram revertidos; ver `CP_D5_010_ARCO_RUINAS_REJEITADO.md`. A rejeição não bloqueia a fila.

## CP-D5-011 — CANDIDATO TÉCNICO; AVALIAÇÃO VISUAL PENDENTE

O colaborador remoto publicou `DenseForestPortalPreview.tscn`, com troncos, galhos, rochas e camada de solo no marco 4. O parser e a sessão headless de 36 segundos passaram, sem tocar `ForestLakeRegion.gd`; ver `CP_D5_011_FLORESTA_DENSA_QA.md`.

Em paralelo, uma variante alternativa de portal criada localmente foi rejeitada visualmente por ler como estrutura provisória ou parede de árvores; ela foi revertida e documentada em `CP_D5_011_PORTAL_REJEITADO_E_PLACEMENT.md`. Esta rejeição **não invalida** o candidato remoto: o candidato remoto exige uma captura visual própria antes de qualquer aprovação ou integração.

A ferramenta `CartographicPlacementSystem.gd` é agora obrigatória: cada candidato Dev5 deve declarar marco, X/Z canónico, posição no canvas do mapa e deslocamento local antes da cena QA.

## CP-D5-012 — CANDIDATO TÉCNICO: Ruínas Submersas

Foi criado `SubmergedRuinsPierPreview.tscn` com cinco lajes quebradas, quatro colunas parciais laterais e água não emissiva. Os colisores foram limitados às lajes de travessia e às colunas laterais; o objecto não cria luzes dinâmicas nem toca `TempleLevel.gd` ou módulos regionais de produção.

A sessão headless completou 36 segundos e confirmou `landmark=6`, `submerged=true`, `emissive=false`, `dynamic_lights=0` e `production_script=false`; ver `CP_D5_012_RUINAS_SUBMERSAS_QA.md`. Também requer captura visual própria antes de se tornar candidato de integração.

## CP-D5-013 — CONCLUÍDO

O catálogo `CP_D5_013_CATALOGO_INSERCAO_R1_R6.md` mapeia os seis marcos a objectos candidatos, activos locais, deslocamentos X/Z, colisores, proprietários e estados QA. O catálogo confirma que nenhuma proposta Dev5 atravessa R1–R6 ou recebe integração automática.

## CP-D5-014 — CONCLUÍDO

A cena `MeshBudgetAuditPreview.tscn` passou parser e sessão QA de 36 segundos, contando métricas reais dos GLB/GLTF. O relatório `CP_D5_014_AUDITORIA_MALHAS.md` confirma: ponte GLB 252 triângulos; rocha 80; árvore detalhada 402; pinheiro PBR 13.424; feto 6.232. Não foram encontrados colisores importados e o lote não criou luzes dinâmicas.

## CP-D5-015 — REJEITADO EM QA

A ponte GLB leve passou parser e sessão de 36 segundos com posição R2 calculada, colisão própria e custo de 252 triângulos. Foi rejeitada porque a captura revelou tabuleiro branco de escala reduzida e guarda-corpos rectilíneos, inferiores à leitura arqueológica exigida. Ver `CP_D5_015_PONTE_GLB_REJEITADA.md`. A rejeição não bloqueia a fila.

## CP-D5-016 — REJEITADO EM QA

O candidato remoto do portal Floresta Densa passou parser e 36 segundos, mas a captura revelou troncos cilíndricos, bases cúbicas e barras horizontais com leitura de armação provisória. Foi rejeitado por não criar profundidade florestal natural; ver `CP_D5_016_PORTAL_FLORESTA_REJEITADO.md`. Não repetir portal estrutural no marco 4.

## CP-D5-017 — REJEITADO EM QA

O cais remoto passou parser e 36 segundos, mas a captura mostrou lajes cúbicas isoladas e colunas cilíndricas uniformes sobre um plano de ensaio. Não atingiu a leitura arqueológica das Ruínas Submersas e foi rejeitado; ver `CP_D5_017_CAIS_RUINAS_REJEITADO.md`. Não repetir o cais com a mesma linguagem de lajes e colunas primitivas.

## CP-D5-018 — CONCLUÍDO: Auditoria LOD vegetal
A auditoria `VegetationLodAuditPreview.tscn` mediu os quatro activos vegetais reais locais: pinheiro PBR (13.424 triângulos), árvore detalhada (402), feto (6.232) e alternativa leve (114). A tabela de densidade fixa uma árvore PBR focal, até três árvores detalhadas no plano médio e até oito elementos leves no plano distante. O feto permanece peça focal isolada, não folhagem distante em volume. Não foram encontrados colisores importados e o lote não criou luzes dinâmicas. Ver `CP_D5_018_AUDITORIA_LOD_VEGETAL.md` e `CP-D5-018_RUNTIME_HEADLESS.log`.
### Aceitação CP-D5-018
| Critério | Resultado |
|---|---|
| Dados | Aprovado: quatro activos medidos com métricas reais. |
| Resultado | Aprovado: limites focal, médio e distante documentados. |
| Orçamento | Aprovado: máximo de uma árvore PBR focal por composição QA. |
| Validação | Aprovado: parser e sessão headless de 36 segundos sem erros Dev5. |
| Continuidade | CP-D5-019 aberto como próxima tarefa activa. |

## CP-D5-019 — CONCLUÍDO EM QA: Vegetação média dos marcos 4 e 5
Foi criada `MediumVegetationCompositionPreview.tscn` para os marcos 4 e 5, usando `CartographicPlacementSystem.gd` e offsets canónicos `(0,0)`. Cada composição contém uma árvore PBR focal, três árvores detalhadas médias e quatro alternativas leves distantes, com posições irregulares e sem parede de árvores. A sessão headless completou 36 segundos e confirmou `wall_of_trees=false production_script=false`; ver `CP_D5_019_VEGETACAO_MEDIA_QA.md` e `CP-D5-019_RUNTIME_HEADLESS.log`.

## CP-D5-020 — CONCLUÍDO: Auditoria de regressão cartográfica

A cena `CartographicRegressionAuditPreview.tscn` passou parser e sessão QA de 36 segundos. Confirmou os quatro contratos activos: ponte R2, anexo Casa Voss R1, pavilhão Majestic R5 e vegetação média R4. Cada candidato declarou a âncora canónica, manteve a distância local permitida, não carregou módulos de produção e não acrescentou luzes dinâmicas. Os candidatos continuam QA; a auditoria não autoriza integração automática.

## CP-D5-021 — REJEITADO EM QA: Composição Casa→Estrada→Arco

A composição preservou as âncoras 1, 2 e 3, a rota central, zero luzes adicionais e a sessão de 36 segundos; contudo, a captura revelou terreno plano, candidatos isolados e escala visual insuficiente para representar o vale. O candidato foi removido. Não repetir a mesma composição com planos simples, marcos reduzidos ou silhuetas substitutas do Arco. A falha mostrou uma lacuna técnica real: os objectos QA ainda dependem de alturas manuais e não de aterramento no terreno.

## CP-D5-022 — CONCLUÍDO: Sistema de aterramento cartográfico

Foram criados `CartographicGroundingSystem.gd`, `CartographicGroundingPreview.gd` e `CartographicGroundingPreview.tscn`. O sistema projecta raycast vertical, preserva X/Z e ajusta somente Y. A prova em terreno físico inclinado aterrou o anexo Casa Voss de `15,00 m` para `-2,78 m` e a ponte do marco 2 de `18,00 m` para `-2,71 m`, mantendo X/Z em ambos os casos. O parser Godot 4.7.1, a sessão QA de 36 segundos e a captura interna passaram sem erro de script. Ver `CP_D5_022_ATERRAMENTO_CARTOGRAFICO.md`.

## CP-D5-023 — CONCLUÍDO: Catálogo de alturas e contratos de aterramento R1–R6

Foram criados `CartographicHeightContracts.gd`, `CartographicHeightContractsPreview.gd` e respectiva cena. A telemetria QA confirmou a cobertura dos seis marcos, as suas coordenadas X/Z canónicas, três proprietários regionais, o contrato de solo aplicável e a exclusão explícita dos candidatos já rejeitados nos marcos 3 e 6. O parser Godot 4.7.1, a sessão de 36 segundos e a captura interna passaram sem erro. Ver `CP_D5_023_CATALOGO_ALTURAS_ATERRAMENTO.md`.

## CP-D5-024 — CONCLUÍDO EM QA: Composição multi-marco aterrada Casa Voss→Estrada
A cena `MultiLandmarkGroundedPreview.tscn` colocou o anexo Casa Voss no marco 1 e a Ponte Marco 2 no marco 2 sobre terreno físico irregular, usando `CartographicGroundingSystem.gd`. Os raycasts confirmaram `grounded=true` para ambos, ajustaram Y de 15,00/18,00 m para -2,52 m e preservaram X/Z `(-22,8)` e `(-21,4;12)`. A cena manteve a passagem visual central, não incluiu o Arco rejeitado e não tocou produção. Ver `CP_D5_024_COMPOSICAO_ATERRADA_QA.md` e `CP-D5-024_RUNTIME_HEADLESS.log`.

### Aceitação CP-D5-024
| Critério | Resultado |
|---|---|
| Espacial | Aprovado: âncoras R1/R2 e X/Z preservados; somente Y resolvido por raycast. |
| Física | Aprovado: dois contactos válidos em terreno irregular, sem suspensão. |
| Visual | Aprovado em QA: ambos os marcos e ligação central no enquadramento. |
| Escopo | Aprovado: módulos novos somente em `levels/dev5/`. |
| Validação | Aprovado localmente: parser e 36 s sem erros Dev5; captura oficial pendente. |
| Continuidade | CP-D5-025 aberto automaticamente. |

## CP-D5-025 — CONCLUÍDO EM QA TÉCNICO: Avaliação de captura dos candidatos R4/R6
Foram executadas sessões independentes de 36 segundos para `DenseForestPortalPreview.tscn` e `SubmergedRuinsPierPreview.tscn`, confirmando os contratos de runtime sem `SCRIPT ERROR` ou `Parse Error`. O renderer headless não forneceu imagem de viewport válida: o fallback registou `snapshot_unavailable=headless_image`. Portanto, a avaliação visual permanece pendente e os candidatos não foram promovidos nem rejeitados por imagem. Ver `CP_D5_025_AVALIACAO_CAPTURA_QA.md` e `CP-D5-025_RUNTIME_HEADLESS.log`.

## CP-D5-026 — CONCLUÍDO: Ficha de prontidão para captura gráfica R4/R6
Foi criada `CP_D5_026_PRONTIDAO_CAPTURA_GRAFICA.md`, com procedimento reproduzível, critérios de aceitação/rejeição visual, fallback headless e verificação de escopo para `DenseForestPortalPreview.tscn` e `SubmergedRuinsPierPreview.tscn`. Os candidatos continuam QA, sem promoção, enquanto não existir viewport gráfico válido para captura. Não foram repetidas geometrias rejeitadas nem tocados módulos de produção.

## CP-D5-027 — CONCLUÍDO: Auditoria de escopo e dependências QA
A auditoria confirmou que os previews R4/R6 não instanciam `ForestLakeRegion.gd`, `TempleLevel.gd` ou `Player.gd`, não criam luzes dinâmicas nos objectos e mantêm colisores apenas na camada QA. As referências a módulos de produção encontradas em documentação são fronteiras e contratos, não dependências de runtime. Não foram repetidas geometrias rejeitadas e não houve alterações fora de `levels/dev5/` e documentação Dev5. Ver `CP_D5_027_AUDITORIA_ESCOPO.md` e `CP-D5-027_AUDITORIA_ESCoPO.log`.

## CP-D5-028 — CONCLUÍDO: Auditoria do backend de captura QA
A ficha `CP_D5_028_AUDITORIA_BACKEND_CAPTURA.md` separou a limitação do renderer headless da qualidade dos candidatos R4/R6. Godot 4.7.1 completou as sessões de 36 segundos sem `SCRIPT ERROR`/`Parse Error`, mas o backend devolveu `Image` nula para as capturas. O fallback evita `save_png` inválido. Os candidatos continuam QA sem aceitação/rejeição visual e não houve alterações em produção.

## CP-D5-029 — CONCLUÍDO: Inventário e varredura das cenas QA Dev5
A varredura de editor encontrou 15 cenas QA em `levels/dev5/` e não encontrou `SCRIPT ERROR`, `Parse Error` ou `Failed to load script`. Os avisos FSR1 foram classificados como backend Compatibility/headless. Os `.uid` gerados pela varredura foram restaurados/limpos sem incluir alterações de ambiente no checkpoint. R4/R6 continuam pendentes de viewport gráfico válido. Ver `CP_D5_029_INVENTARIO_CENAS_QA.md` e `CP-D5-029_PARSER_SWEEP.log`.

## CP-D5-030 — CONCLUÍDO: Ficha consolidada de integração QA
Foi criada `CP_D5_030_FICHA_INTEGRACAO_QA.md`, consolidando âncoras, X/Z, aterramento Y, colisores, luzes, isolamento e estados de promoção dos candidatos Dev5. A ficha confirma que nenhum candidato é integrado automaticamente; R4/R6 permanecem pendentes de viewport gráfico válido e todos os candidatos exigem revisão Dev1 antes de promoção.

## CP-D5-031 — CONCLUÍDO: Handoff de revisão Dev1
Foi criado `CP_D5_031_HANDOFF_REVISAO_DEV1.md`, organizando evidências técnicas, pendências visuais e critérios de decisão para Casa Voss, Ponte Marco 2, Portal Floresta, Vegetação média, Pavilhão Majestic e Ruínas Submersas. O handoff confirma que R4/R6 não podem ser promovidos sem viewport gráfico válido e que nenhum candidato é integrado automaticamente.

## CP-D5-032 — CONCLUÍDO: Validação do Pavilhão Majestic aterrado
O preview remoto `MajesticPavilionPreview.tscn` passou uma sessão Godot Compatibility de 36 segundos com código 0 e sem `SCRIPT ERROR`, `Parse Error`, `Invalid call` ou `Invalid get`. A cena mantém terreno, rota central, materiais próprios e isolamento de produção. A captura gráfica não foi activada no headless porque o backend não fornece `Image` válida; a pendência visual R4/R6 permanece explícita. Ver `CP_D5_032_MAJESTIC_ATERRAMENTO_QA.md` e `CP-D5-032_RUNTIME_HEADLESS.log`.

## CP-D5-033 — CONCLUÍDO: Fallback seguro de captura Majestic
O preview `MajesticPavilionPreview.gd` agora verifica textura e imagem de viewport antes de chamar `save_png`. A sessão Compatibility completou 36 segundos com código 0 e registou `snapshot_unavailable=headless_image` sem erro de script. A captura gráfica continua pendente de viewport válido e R4/R6 não foram promovidos. Ver `CP_D5_033_FALLBACK_CAPTURA_MAJESTIC.md` e `CP-D5-033_RUNTIME_HEADLESS.log`.

## CP-D5-034 — CONCLUÍDO: Fallbacks de captura dos previews QA
Foram endurecidos seis previews QA que ainda chamavam `save_png` sem verificar textura/imagem nula: `CartographicGroundingPreview`, `CartographicHeightContractsPreview`, `MajesticGroundedPavilionPreview`, `MeshBudgetAuditPreview`, `StoneBridgeGLBPreview` e `VegetationDensityAuditPreview`. A varredura editor Godot Compatibility e uma sessão de 36 segundos passaram sem `SCRIPT ERROR`/`Parse Error`; não restaram chamadas directas inseguras em `levels/dev5/`. R4/R6 continuam pendentes de viewport gráfico válido. Ver `CP_D5_034_FALLBACKS_CAPTURA_QA.md` e `CP-D5-034_PARSER_SWEEP.log`.

## CP-D5-035 — CONCLUÍDO: Auditoria de segurança da captura QA
A matriz confirmou zero cadeias directas inseguras de `save_png`, parser editor limpo e guards de textura/imagem nos previews QA. A captura headless pode continuar indisponível por imagem nula, mas já não gera chamadas inválidas. Elias permanece isolado e nenhum módulo de produção foi alterado. Ver `CP_D5_035_AUDITORIA_SEGURANCA_CAPTURA.md` e `CP-D5-035_CAPTURE_SAFETY_AUDIT.log`.

## CP-D5-036 — CONCLUÍDO: Validação da vegetação média aterrada R4/R5
O harness `GroundedVegetationR4R5Preview.tscn` passou 36 segundos com 12 instâncias aterradas, `grounded=true`, `xz_preserved=true`, `dynamic_lights_added=0` e `wall_of_trees=false`. R4 preserva o corredor central e R5 mantém a leitura do pavilhão/rota. A captura headless caiu no fallback seguro; a pendência visual continua explícita. Ver `CP_D5_036_VEGETACAO_ATERRADA_QA.md` e `CP-D5-036_RUNTIME_HEADLESS.log`.

## CP-D5-037 — CONCLUÍDO: Auditoria de recursos dos previews QA
Foram verificados 18 caminhos `res://` usados pelos previews Dev5 e pela apresentação isolada de Elias; todos existem, sem `MISSING`. A varredura de parser Godot Compatibility terminou com código 0 e sem `SCRIPT ERROR`, `Parse Error` ou falha de carregamento. R4/R6 continuam pendentes de viewport gráfico válido e nenhum módulo de produção foi alterado. Ver `CP_D5_037_AUDITORIA_RECURSOS_QA.md` e `CP-D5-037_RESOURCE_AUDIT.log`.

## CP-D5-038 — CONCLUÍDO: Smoke test runtime das cenas QA
Foram carregadas 17 cenas QA Dev5 em processos headless Compatibility isolados, todas com código 0 e sem `SCRIPT ERROR`, `Parse Error`, `Invalid call`, `Invalid get` ou falha de carregamento. O smoke test confirma integridade de instanciação, mas não substitui captura gráfica nem promove R4/R6. Ver `CP_D5_038_SMOKE_RUNTIME_QA.md` e `CP-D5-038_RUNTIME_SMOKE.log`.

## CP-D5-039 — CONCLUÍDO: Linha de base de performance QA
As 17 cenas QA foram executadas em processos headless Compatibility durante cinco segundos, todas com código 0 e sem erros Dev5. O arranque observado ficou entre 230 e 236 ms; o máximo de 236 ms em `VossWaystationPreview` não constitui outlier operacional. A medição é linha de base de processo, não FPS do mundo completo. Ver `CP_D5_039_BASELINE_PERFORMANCE_QA.md` e `CP-D5-039_PERFORMANCE_BASELINE.log`.

## CP-D5-040 — CONCLUÍDO: Auditoria de câmaras e luzes QA
A auditoria encontrou 16 declarações de `Camera3D` e 16 de luz em 17 cenas/scripts QA. Não há OmniLight3D/SpotLight3D nem múltiplas luzes dinâmicas por harness; os objectos cartográficos não criam luz própria. O parser Compatibility terminou sem erros Dev5 e o limite global de 16 luzes não é ameaçado por cenas isoladas. Ver `CP_D5_040_AUDITORIA_LUZES_CAMERAS_QA.md` e `CP-D5-040_LIGHT_CAMERA_AUDIT.log`.

## CP-D5-041 — CONCLUÍDO: Validação da baliza monolítica aterrada R6
O preview `SubmergedShoreMonolithPreview.tscn` executou durante 36 segundos em Compatibility. A âncora canónica foi confirmada em X/Z `(52.00, 260.00)`, com `grounded=true`, `xz_preserved=true` e colisor `MargemR6ColisorQA`; o candidato adicionou zero luzes dinâmicas, zero lajes de cais e zero colunas uniformes. Sem `SCRIPT ERROR` ou `Parse Error`. A advertência FSR1 é do renderer local e não bloqueou o runtime. Ver `CP_D5_041_VALIDACAO_BALIZA_MONOLITICA_R6.md` e os dois logs `CP-D5-041_R6_MONOLITH_RUNTIME*.log`. A aprovação visual de R6 permanece pendente de captura gráfica válida.

## CP-D5-042 — CONCLUÍDO: Validação de folga da baliza R6
O corredor central da cena `R6MonolithClearancePreview.tscn` foi validado durante 36 segundos. A baliza aterrada em X/Z `(52.00, 260.00)` mantém folga calculada de `6,05 m` contra o mínimo de `4,00 m`; o proxy realizou dois ciclos completos sem bloqueio. A execução final não apresentou erros Dev5. Foi corrigida no preview a atribuição de `global_position` antes da inserção do colisor na árvore, substituindo-a por `position`. Ver `CP_D5_042_VALIDACAO_FOLGA_BALIZA_R6.md` e `CP-D5-042_R6_CLEARANCE_RUNTIME_FIXED.log`.

## CP-D5-043 — CONCLUÍDO: Elias em terceira pessoa na margem R6
O preview `EliasR6ClearancePreview.tscn` validou Elias com `EliasThirdPersonPresentation`, grounding R6 em X/Z `(52.00, 260.00)`, corredor X=60, folga de `6,05 m` e dois ciclos completos sem bloqueio durante 36 segundos. `Player.gd` não foi alterado. Foi corrigida no preview a atribuição de `global_position` antes da inserção do colisor na árvore, substituindo-a por `position`. A execução final não apresentou erros Dev5. Ver `CP_D5_043_ELIAS_TERCEIRA_PESSOA_R6_VALIDACAO.md` e `CP-D5-043_ELIAS_R6_RUNTIME_FIXED.log`. A aprovação visual final continua pendente de viewport gráfico válido.

## CP-D5-044 — CONCLUÍDO: Auditoria de escopo e terceira pessoa
A auditoria confirmou zero referências operacionais a `Player.gd` ou módulos regionais de produção nos previews Dev5. `EliasThirdPersonPresentation` permanece isolada, com uma luz direccional por harness e parser Compatibility sem erros. As ocorrências de proprietários R1–R6 são apenas contratos, comentários e documentação. Ver `CP_D5_044_AUDITORIA_ESCOPO_TERCEIRA_PESSOA.md` e `CP-D5-044_SCOPE_THIRD_PERSON_AUDIT.log`.

## CP-D5-045 — CONCLUÍDO: Contrato de câmara de Elias

A cena `EliasCameraContractPreview.tscn` confirmou `follow_camera.current=false`, `CameraQAExterna.current=true` e `CameraQAExterna` como proprietária da viewport. O parser Godot 4.7.1, uma sessão de 36 segundos e a captura interna passaram; não houve alteração a `Player.gd` ou módulos regionais. Ver `CP_D5_045_CONTRATO_CAMARA_ELIAS.md`.

## CP-D5-046 — CONCLUÍDO: Auditoria de integridade de câmara dos harnesses Elias

Foram identificados três harnesses com `EliasThirdPersonPresentation`. Os dois harnesses de percurso passaram a reter referência tipada à apresentação, eliminando uma asserção causada por normalização do nome do nó em `_ready()`. Parser Godot 4.7.1 e duas sessões de 36 segundos passaram com `elias_camera_current=false`, dois ciclos de percurso por cena e zero alterações a `Player.gd` ou módulos regionais. Ver `CP_D5_046_AUDITORIA_CAMERAS_ELIAS.md`.

## CP-D5-047 — CONCLUÍDO: Matriz de contratos de apresentação de Elias
Foi criada `CP_D5_047_MATRIZ_CONTRATOS_ELIAS.md`, consolidando câmara, referência tipada, colisão QA, trajecto, grounding, folga, performance e isolamento de produção. A ficha explicita aceitação, reversão e a propriedade de Dev1 sobre `Player.gd`; não promove Elias ao jogador principal.
| Critério | Resultado |
|---|---|
| Cobertura | câmara, colisão QA, trajecto, grounding e isolamento documentados |
| Segurança | aceitação e reversão explícitas |
| Produção | Dev1 permanece proprietário de `Player.gd` |
| Continuidade | CP-D5-048 activado no mesmo ciclo |

## CP-D5-048 — CONCLUÍDO: Checklist de integração Elias R5/R6
Foi criada `CP_D5_048_CHECKLIST_INTEGRACAO_ELIAS_R5_R6.md`, convertendo a matriz em passos operacionais para Dev1. A checklist cobre câmara, identidade, colisão, percursos R5/R6, grounding, orçamento de luzes, propriedade de produção, critérios de aceitação e reversão. A tarefa permanece documental e não altera `Player.gd` nem módulos regionais.

## CP-D5-049 — CONCLUÍDO: Validação dos percursos Elias R5/R6
Os harnesses `EliasMajesticClearancePreview` e `EliasR6ClearancePreview` passaram sessões QA finais de 36 segundos. R5 confirmou âncora `(-88,178)`, trajecto X=-80, folga `5,45 m`, grounding e dois ciclos; R6 confirmou `(52,260)`, trajecto X=60, folga `6,05 m`, grounding e dois ciclos. Em ambos, `elias_camera_current=false`. Foi corrigido no preview R5 o colisor definido por `global_position` antes da entrada na árvore, usando `position`; a execução final terminou sem erros Dev5. Ver `CP_D5_049_VALIDACAO_PERCURSOS_ELIAS_R5_R6.md` e os logs `CP-D5-049_*RUNTIME*FIXED.log`.

## CP-D5-050 — CONCLUÍDO: Auditoria de ordem de construção
A auditoria encontrou zero atribuições suspeitas de `global_position` nos previews. As duas atribuições restantes pertencem legitimamente ao `CartographicGroundingSystem.gd`, que recebe candidatos já inseridos na árvore. O parser Compatibility passou sem erros e nenhum módulo de produção foi alterado. Ver `CP_D5_050_AUDITORIA_ORDEM_CONSTRUCAO.md` e `CP-D5-050_CONSTRUCTION_ORDER_AUDIT.log`.

## CP-D5-051 — CONCLUÍDO: Auditoria de inventário QA Dev5
O inventário confirmou 22 cenas QA, zero recursos `res://` ausentes, 22 luzes direccionais isoladas, zero Omni/Spot lights e 23 câmaras criadas por scripts. O parser Compatibility terminou limpo e nenhum módulo de produção foi alterado. Ver `CP_D5_051_AUDITORIA_INVENTARIO_QA.md` e `CP-D5-051_QA_INVENTORY_AUDIT.log`.

## CP-D5-052 — CONCLUÍDO: Auditoria de fallback de captura Elias
Os três harnesses Elias passaram a tratar textura de viewport e imagem nulas em headless, registando `snapshot_unavailable` em vez de provocar crash. O contrato de câmara foi revalidado durante 36 segundos com `elias_camera_current=false`, câmara externa activa e zero `SCRIPT ERROR`. Ver `CP_D5_052_AUDITORIA_FALLBACK_CAPTURA_ELIAS.md`, `CP-D5-052_CAPTURE_FALLBACK_AUDIT.log` e `CP-D5-052_EliasCameraContract_RUNTIME_FIXED.log`.

## CP-D5-053 — CONCLUÍDO: Leitura R5 com Elias, Pavilhão e vegetação
O preview `MajesticEliasVegetationReadPreview.tscn` passou 36 segundos com cinco elementos vegetais aterrados, Pavilhão em X/Z `(-88,178)`, Elias no trajecto X=-80, folga `5,45 m`, dois ciclos `clear=true`, `elias_camera_current=false`, `wall_of_trees=false` e `production_modules_changed=false`. Ver `CP_D5_053_VALIDACAO_LEITURA_R5_ELIAS_VEGETACAO.md` e `CP-D5-053_R5_ELIAS_VEGETATION_RUNTIME.log`.

## CP-D5-054 — CONCLUÍDO: Auditoria global de captura headless
Foram identificados sete handlers ainda vulneráveis a textura/imagem nulas: Elias isolado, Placement, leitura R5, folga R6, Ponte R2, monólito R6 e Voss R1. Doze handlers já têm fallback seguro; o parser permanece limpo e nenhum módulo de produção foi alterado. Ver `CP_D5_054_AUDITORIA_CAPTURA_GLOBAL.md` e `CP-D5-054_UNSAFE_CAPTURE_HANDLERS.list`.

## CP-D5-055 — CONCLUÍDO: Correcção global dos fallbacks de captura
Os sete handlers foram corrigidos para tratar textura e imagem nulas. A varredura final encontrou zero direct calls vulneráveis, o parser Compatibility passou limpo e o preview R6 manteve 36 segundos com grounding, folga `6,05 m`, dois ciclos `clear=true` e zero `SCRIPT ERROR`. Ver `CP_D5_055_CORRECAO_FALLBACKS_CAPTURA.md` e `CP-D5-055_R6_CAPTURE_RUNTIME_FINAL.log`.

## CP-D5-056 — CONCLUÍDO: Leitura R6 com Elias, baliza e vegetação
A cena publicada `R6EliasVegetationReadPreview.tscn` passou 36 segundos. Confirmou baliza grounded em X/Z `(52,260)`, Elias com câmara QA externa e `elias_camera_current=false`, trajecto X=60, folga `6,05 m`, três elementos vegetais aterrados, zero lajes, `wall_of_trees=false`, dois ciclos `clear=true` e `production_modules_changed=false`. Ver `CP_D5_056_VALIDACAO_LEITURA_R6_ELIAS_VEGETACAO.md` e `CP-D5-056_R6_ELIAS_VEGETATION_RUNTIME.log`.

## CP-D5-057 — CONCLUÍDO: Auditoria comparativa das leituras R5/R6
A comparação confirmou os contratos de Elias em R5 e R6: folgas `5,45 m` e `6,05 m`, grounding verdadeiro, câmara de Elias inactiva, dois ciclos de trajecto, zero parede de árvores, zero lajes de cais e uma luz direccional por harness. O parser Compatibility passou e nenhum módulo regional foi alterado. Ver `CP_D5_057_AUDITORIA_COMPARATIVA_LEITURAS_R5_R6.md` e `CP-D5-057_R5_R6_READ_COMPARISON_AUDIT.log`.

## CP-D5-058 — CONCLUÍDO: Validação StoneBridgeGLB R2
O preview `StoneBridgeGLBPreview.tscn` passou 36 segundos com âncora `2`, world X/Z `(-21,4;28,0)`, offset `(0;16)`, 252 triângulos e colisão `tabuleiro_continuo`. Não houve `SCRIPT ERROR` ou `Parse Error`; módulos regionais e `Player.gd` permaneceram intocados. Ver `CP_D5_058_VALIDACAO_STONE_BRIDGE_GLB.md` e `CP-D5-058_STONE_BRIDGE_RUNTIME.log`.

## CP-D5-059 — CONCLUÍDO: Validação Voss R1 e fallback de captura
O preview Voss R1 foi corrigido após uma indentação inválida no fallback automático. A execução final de 36 segundos passou sem `SCRIPT ERROR` ou `Parse Error`, com tipos explícitos para `Texture2D` e `Image`; apenas a advertência FSR1 do renderer Compatibility permaneceu. Ver `CP_D5_059_VALIDACAO_VOSS_FALLBACK.md` e `CP-D5-059_VOSS_RUNTIME_FIXED.log`.

## CP-D5-060 — CONCLUÍDO: Validação DenseForestPortal R4
O preview `DenseForestPortalPreview.tscn` passou 36 segundos com âncora `(-9,116)`, passagem de `2,4 m`, `isolated=true` e `region_script=false`. Não houve `SCRIPT ERROR` ou `Parse Error`; a aprovação visual de R4 continua pendente de viewport gráfico válido. Ver `CP_D5_060_VALIDACAO_DENSE_FOREST_PORTAL.md` e `CP-D5-060_FOREST_RUNTIME.log`.

## CP-D5-061 — CONCLUÍDO: Validação SubmergedRuins R6
O preview `SubmergedRuinsPierPreview.tscn` passou 36 segundos com landmark `6`, `submerged=true`, `emissive=false`, zero luzes dinâmicas e `production_script=false`. Não houve `SCRIPT ERROR` ou `Parse Error`; a aprovação visual R6 permanece pendente de viewport gráfico válido. Ver `CP_D5_061_VALIDACAO_SUBMERGED_RUINS.md` e `CP-D5-061_RUINS_PIER_RUNTIME.log`.

## CP-D5-062 — CONCLUÍDO: Validação monólito R6 e fallback de captura
O `SubmergedShoreMonolithPreview` foi corrigido após indentação inválida no fallback. A execução final de 36 segundos confirmou âncora `6`, X/Z `(52,260)`, grounding verdadeiro, X/Z preservado, colisor `MargemR6ColisorQA`, zero luzes dinâmicas, zero lajes, zero colunas uniformes e `production_modules_changed=false`. Ver `CP_D5_062_VALIDACAO_MONOLITO_R6_FALLBACK.md` e `CP-D5-062_MONOLITH_RUNTIME_FIXED.log`.

## CP-D5-063 — CONCLUÍDO: Rumo Elias Casa de Voss → Estrada do Rio
O preview `EliasVossRoadHeadingPreview.tscn` passou 36 segundos com Casa de Voss `(-22,8)`, estrada `(-21,4;12)`, ponte R2 `(-21,4;28)`, destino id `2`, `elias_camera_current=false` e oito ciclos de rumo. A continuidade espacial R1→R2 foi confirmada sem alterar produção. Ver `CP_D5_063_VALIDACAO_RUMO_ELIAS_VOSS_ESTRADA.md` e `CP-D5-063_VOSS_HEADING_RUNTIME.log`.

## CP-D5-064 — CONCLUÍDO: Auditoria de sequência cartográfica R1–R6
O preview `CartographicSequenceR1R6Preview.tscn` passou 36 segundos com oito marcos, `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`. A sequência percorre R1 Voss, R2 estrada, R3 arco, R4 floresta, R5 aproximação/Majestic e R6 ruínas sem saltos de âncora. Ver `CP_D5_064_AUDITORIA_SEQUENCIA_CARTOGRAFICA_R1_R6.md` e `CP-D5-064_CARTOGRAPHIC_SEQUENCE_RUNTIME.log`.

## CP-D5-065 — CONCLUÍDO: Validação de vegetação grounded R4/R5
O preview `GroundedVegetationR4R5Preview.tscn` passou 36 segundos com 12 candidatos, todos `grounded=true` e `xz_preserved=true`. Foram confirmados 6 elementos em R4, 6 em R5, zero luzes dinâmicas adicionadas, `wall_of_trees=false` e `production_modules_changed=false`. Ver `CP_D5_065_VALIDACAO_VEGETACAO_GROUNDING_R4_R5.md` e `CP-D5-065_VEGETATION_RUNTIME.log`.

## CP-D5-066 — CONCLUÍDO: Auditoria de orçamento de malha
O `MeshBudgetAuditPreview` passou 36 segundos com 20.390 triângulos, 9 nós de malha, 12 slots de material, zero colisores e zero luzes dinâmicas. Os activos representativos de ponte, pedra, árvore e feto permanecem dentro do harness GTX 1050 Ti. Ver `CP_D5_066_AUDITORIA_MESH_BUDGET.md` e `CP-D5-066_MESH_BUDGET_RUNTIME.log`.

## CP-D5-067 — CONCLUÍDO: Auditoria de LOD da vegetação
O `VegetationLodAuditPreview` passou 36 segundos com limites de 1 árvore PBR focal, 3 árvores detalhadas médias e 8 elementos leves distantes. Os activos auditados somam as malhas e materiais esperados, sem colisões duplicadas e com zero luzes dinâmicas. Ver `CP_D5_067_AUDITORIA_VEGETATION_LOD.md` e `CP-D5-067_VEGETATION_LOD_RUNTIME.log`.

## CP-D5-068 — CONCLUÍDO: Handoff cartográfico R6 → R7
O preview `EliasR6R7HandoffPreview.tscn` passou 36 segundos com partida R6 `(60,252)`, destino R7 `(140,352)`, `reached_marker_r7=true`, `elias_camera_current=false`, `marker_only=true`, `dev2_geometry_created=false` e `production_modules_changed=false`. A prova não criou Região 7 nem alterou produção. Ver `CP_D5_068_VALIDACAO_HANDOFF_R6_R7.md` e `CP-D5-068_R6_R7_HANDOFF_RUNTIME.log`.

## CP-D5-069 — CONCLUÍDO: Rumo Elias R5 → R6
O preview `EliasR5R6HeadingPreview.tscn` passou 36 segundos com partida `(-80,190)`, destino R6 id `6`, `arrival_r6=true`, próxima âncora `7`, indicação `PASSAGEM: VILA ELEVADA` e `elias_camera_current=false`. A continuidade R5→R6→R7 foi confirmada sem alterar produção. Ver `CP_D5_069_VALIDACAO_RUMO_ELIAS_R5_R6.md` e `CP-D5-069_R5_R6_HEADING_RUNTIME.log`.

## CP-D5-070 — CONCLUÍDO: Passagem Elias na Floresta R4
O preview `EliasForestClearancePreview.tscn` passou 36 segundos com âncora `(-9,116)`, corredor de `5,20 m`, folga mínima de `2,75 m`, seis elementos grounded, `forest_portal=false`, `wall_of_trees=false` e dois ciclos de rota abertos. Ver `CP_D5_070_VALIDACAO_ELIAS_FLORESTA_R4.md` e `CP-D5-070_ELIAS_FOREST_RUNTIME.log`.

## CP-D5-071 — CONCLUÍDO: Composição grounded R1/R2
O preview `MultiLandmarkGroundedPreview.tscn` passou 36 segundos com CasaVoss âncora `1` em `(-22,8)` e PonteMarco2 âncora `2` em `(-21,4;12)`, ambos grounded sobre terreno irregular, X/Z preservado, `production_script=false` e zero luzes dinâmicas. Ver `CP_D5_071_VALIDACAO_COMPOSICAO_GROUNDED_R1_R2.md` e `CP-D5-071_MULTILANDMARK_RUNTIME.log`.

## CP-D5-072 — CONCLUÍDO: Leitura R6 de Elias com vegetação
O preview `R6EliasVegetationReadPreview.tscn` passou 36 segundos com monólito grounded em `(52,260)`, vegetação de 3 elementos, folga de `6,05 m`, zero lajes, `wall_of_trees=false`, produção inalterada e dois ciclos `clear=true` com Elias. Ver `CP_D5_072_VALIDACAO_LEITURA_R6_ELIAS.md` e `CP-D5-072_R6_VEGETATION_READ_RUNTIME.log`.

## CP-D5-073 — CONCLUÍDO: Leitura de Elias no Pavilhão Majestic R5
O preview `MajesticEliasVegetationReadPreview.tscn` foi corrigido no fallback de captura e passou 36 segundos com pavilhão grounded em `(-88,178)`, folga de `5,45 m`, cinco elementos vegetais, `wall_of_trees=false`, produção inalterada e dois ciclos `clear=true` com Elias. Ver `CP_D5_073_VALIDACAO_LEITURA_MAJESTIC_R5.md` e `CP-D5-073_MAJESTIC_RUNTIME_FIXED.log`.

## CP-D5-074 — CONCLUÍDO: Auditoria de reversibilidade e fronteira Dev5
A auditoria dos últimos 20 commits confirmou zero ficheiros fora da fronteira autorizada, zero alterações a `Player.gd`, zero alterações directas aos módulos R1–R12 e commits isolados reversíveis. Ver `CP_D5_074_AUDITORIA_REVERSIBILIDADE.md`.

## CP-D5-075 — CONCLUÍDO: Composição vegetal intermediária R4/R5
O preview `MediumVegetationCompositionPreview.tscn` passou 36 segundos com Floresta Densa R4 e Acampamento Majestic R5, cada composição com 1 PBR, 3 médios e 4 distantes. A telemetria confirmou `wall_of_trees=false` e `production_script=false`. Ver `CP_D5_075_VALIDACAO_COMPOSICAO_VEGETAL_R4_R5.md` e `CP-D5-075_MEDIUM_VEGETATION_RUNTIME.log`.

## CP-D5-076 — CONCLUÍDO: Travessia Elias na ponte modular R2
O preview `EliasStoneBridgeTraversalPreview.tscn` foi corrigido para aguardar física antes da asserção de grounding e passou 36 segundos com R2 `(-21,4;28)`, colisor `tabuleiro_continuo`, grounding verdadeiro, folga `0,21 m` contra `0,20 m`, ponte modular, uma luz direccional e três ciclos sem erro. Ver `CP_D5_076_VALIDACAO_TRAVESSIA_ELIAS_PONTE_R2.md` e `CP-D5-076_ELIAS_BRIDGE_RUNTIME_FIXED.log`.

## CP-D5-077 — CONCLUÍDO: Validação StoneBridgeLandmark R2
O preview `StoneBridgeLandmarkPreview.tscn` foi corrigido no fallback de captura e passou 36 segundos sem `SCRIPT ERROR` ou `Parse Error`. O escopo de produção e `Player.gd` permaneceram intocados. Ver `CP_D5_077_VALIDACAO_STONE_BRIDGE_LANDMARK.md` e `CP-D5-077_STONE_LANDMARK_RUNTIME_FIXED.log`.

## CP-D5-078 — CONCLUÍDO: Corredor cartográfico Elias no arco R3
O preview `EliasArchCorridorPreview.tscn` passou 36 segundos com R3 `(-16,741;48)`, arco físico em Z `92`, destino R4 id `4`, `structural_arch=false` e dois ciclos `route_open=true`. A transição R3→R4 foi confirmada sem criar produção. Ver `CP_D5_078_VALIDACAO_CORREDOR_ARCO_R3.md` e `CP-D5-078_ELIAS_ARCH_RUNTIME.log`.

## CP-D5-079 — CONCLUÍDO: Folga Elias na margem R6
O preview `EliasR6ClearancePreview.tscn` passou 36 segundos com monólito grounded em `(52,260)`, colisor `CorredorMargemR6EliasQA`, folga de `6,05 m` contra `4,00 m`, apresentação `EliasThirdPersonPresentation`, câmara externa e dois ciclos `clear=true`. Ver `CP_D5_079_VALIDACAO_ELIAS_R6_CLEARANCE.md` e `CP-D5-079_ELIAS_R6_CLEARANCE_RUNTIME.log`.

## CP-D5-080 — CONCLUÍDO: Auditoria da lacuna cartográfica R1 → R2
A auditoria do contrato Elias R1→R2 confirmou Casa Voss `(-22,8)`, estrada `(-21,4;12)`, ponte R2 `(-21,4;28)`, destino via `next_dev1_destination()` igual a `2`, parser limpo, zero referências de produção no preview e zero ficheiros fora da fronteira. Ver `CP_D5_080_AUDITORIA_LACUNA_R1_R2.md`.

## CP-D5-081 — CONCLUÍDO: Auditoria de densidade vegetal
O preview `VegetationDensityAuditPreview.tscn` passou 36 segundos com 1 pinheiro focal, 3 árvores escuras médias, 1 árvore leve e 2 fetos, total de 27.208 triângulos, zero luzes dinâmicas e `wall_density=false`. Ver `CP_D5_081_AUDITORIA_DENSIDADE_VEGETAL.md` e `CP-D5-081_VEGETATION_DENSITY_RUNTIME.log`.

## CP-D5-082 — CONCLUÍDO: Revalidação da orientação exterior Elias R1→R2
O preview `EliasVossRoadHeadingPreview.tscn` passou 36 segundos com Casa Voss `(-22,8)`, estrada `(-21,4;12)`, ponte `(-21,4;28)`, destino `RUMO À ESTRADA DO RIO` id `2`, câmara externa e oito ciclos consistentes. Ver `CP_D5_082_REVALIDACAO_ORIENTACAO_EXTERIOR_R1.md` e `CP-D5-082_ELIAS_VOSS_EXTERNAL_RUNTIME.log`.

## CP-D5-083 — CONCLUÍDO: Validação da sequência cartográfica R1–R6
O preview `CartographicSequenceR1R6Preview.tscn` passou 36 segundos com oito pontos, `no_anchor_skip=true`, transição lateral Majestic `true`, chegada às Ruínas `true` e destino final âncora 7. Ver `CP_D5_083_VALIDACAO_SEQUENCIA_R1_R6.md` e `CP-D5-083_CARTOGRAPHIC_SEQUENCE_RUNTIME.log`.

## CP-D5-084 — CONCLUÍDO: Legibilidade R6 por múltiplos ângulos
O preview `R6ReadabilityAnglesPreview.tscn` passou 36 segundos com 3 ângulos, Elias/monólito/corredor visíveis, monólito em `(52,260)`, grounding verdadeiro, dois ciclos `clear=true` e produção inalterada. Ver `CP_D5_084_VALIDACAO_LEGIBILIDADE_R6_ANGULOS.md` e `CP-D5-084_R6_READABILITY_RUNTIME.log`.

## CP-D5-085 — CONCLUÍDO: Auditoria de orçamento de malha
O preview `MeshBudgetAuditPreview.tscn` passou 36 segundos com 20.390 triângulos, 9 nós de malha, 12 slots de materiais, zero colisores e zero luzes dinâmicas. Ver `CP_D5_085_AUDITORIA_MESH_BUDGET.md` e `CP-D5-085_MESH_BUDGET_RUNTIME.log`.

## CP-D5-086 — CONCLUÍDO: Auditoria de LOD de vegetação
O preview `VegetationLodAuditPreview.tscn` passou 36 segundos com limites de 1 árvore PBR focal, 3 árvores detalhadas médias e 8 elementos leves distantes; activos auditados sem colisores e zero luzes dinâmicas. Ver `CP_D5_086_AUDITORIA_VEGETATION_LOD.md` e `CP-D5-086_VEGETATION_LOD_RUNTIME.log`.

## CP-D5-087 — CONCLUÍDO: Rumo Elias R5→R6
O preview `EliasR5R6HeadingPreview.tscn` passou 36 segundos com início `(-80,190)`, destino `RUMO ÀS RUÍNAS` âncora 6, chegada R6 verdadeira e continuidade para âncora 7 `PASSAGEM: VILA ELEVADA`. Ver `CP_D5_087_VALIDACAO_RUMO_ELIAS_R5_R6.md` e `CP-D5-087_ELIAS_R5_R6_HEADING_RUNTIME.log`.

## CP-D5-088 — CONCLUÍDO: Regressão dos contratos de rota R1–R6
O preview `CartographicSequenceR1R6Preview.tscn` passou 36 segundos após as publicações recentes com 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true`, destino posterior âncora 7 e produção inalterada. Ver `CP_D5_088_REGRESSAO_CONTRATOS_ROTA.md` e `CP-D5-088_ROUTE_REGRESSION_RUNTIME.log`.

## CP-D5-089 — CONCLUÍDO: Regressão Elias third-person
O parser do projecto terminou com `PARSER_EXIT=0` e `EliasThirdPersonPreview.tscn` manteve uma sessão QA de 36 segundos com `CameraQA` externa activa, sem `SCRIPT ERROR` ou `Parse Error`. Ver `CP_D5_089_REGRESSAO_ELIAS_THIRD_PERSON.md` e `CP-D5-089_PARSER_RUNTIME.log`.

## CP-D5-090 — CONCLUÍDO: Acampamento Majestic vivo R5

`R5LivingMajesticPreview.tscn` passou parser e 36 segundos com pavilhão real, dois cervos CC0, sete elementos vegetais, três peças de abrigo colapsado, 13 aterramentos X/Z, corredor Elias livre e uma luz dinâmica. A cena não altera produção. Ver `CP_D5_090_ACAMPAMENTO_MAJESTIC_VIVO.md`.

## CP-D5-091 — CONCLUÍDO: Estrada do Rio viva R2

`R2LivingRiverRoadPreview.tscn` passou parser e 36 segundos com ponte modular, dois cervos CC0, quatro elementos vegetais, dois vestígios de abrigo, nove aterramentos X/Z, travessia livre e uma luz dinâmica. Não reutiliza ponte GLB e não altera produção. Ver `CP_D5_091_ESTRADA_RIO_VIVA.md`.

## CP-D5-092 — CONCLUÍDO: Floresta Densa viva R4

`R4LivingForestPreview.tscn` passou parser e 36 segundos com dois cervos CC0, oito elementos vegetais LOD, abrigo lateral em pedra, 12 aterramentos X/Z, corredor Elias livre e uma luz dinâmica. Não cria portal estrutural ou parede vegetal. Ver `CP_D5_092_FLORESTA_DENSA_VIVA.md`.

## CP-D5-093 — CONCLUÍDO: Casa Voss viva R1

`R1LivingVossExteriorPreview.tscn` passou parser e 36 segundos com anexo aprovado, dois cervos CC0, horta tridimensional, oito aterramentos X/Z, rota exterior livre e uma luz dinâmica. Não altera VossHouse, a porta ou Player.gd. Ver `CP_D5_093_CASA_VOSS_VIVA.md`.

## CP-D5-094 — CONCLUÍDO: Arco das Ruínas vivo R3

`R3LivingArchCorridorPreview.tscn` passou parser e 36 segundos com dois cervos CC0, quatro elementos vegetais, duas ruínas laterais, oito aterramentos X/Z, corredor R3→R4 livre e uma luz dinâmica. Não cria arco estrutural, portal ou compressão cartográfica. Ver `CP_D5_094_ARCO_RUINAS_VIVO.md`.

## CP-D5-095 — CONCLUÍDO: Plano de integração mapa vivo R1–R6

O plano `CP_D5_095_INTEGRACAO_MAPA_VIVO_R1_R6.md` consolidou candidatos R1–R6, limites LOD, colisão, rota, reversão e evidências. Referências e parser foram verificados; R2 repetiu uma sessão QA de 36 segundos sem erro.

## CP-D5-096 — CONCLUÍDO: Ficha integração R2

`CP_D5_096_FICHA_INTEGRACAO_R2.md` especifica âncora, ponte modular, fauna, flora, colisores, sequência de reversão e referências QA para o Dev1. Nenhum módulo de produção foi editado.

## CP-D5-097 — CONCLUÍDO: Ficha integração R4

`CP_D5_097_FICHA_INTEGRACAO_R4.md` define corredor mínimo, LOD, fauna, abrigo lateral, exclusão do portal estrutural e reversão para o Dev1. Nenhum módulo de produção foi editado.

## CP-D5-098 — CONCLUÍDO: Ficha integração R5
`CP_D5_098_FICHA_INTEGRACAO_R5.md` define a integração isolada do Acampamento Majestic vivo, preservando a âncora `(-88,178)`, o corredor Elias em `x=-79`, o pavilhão, abrigo lateral, LOD vegetal, 2 cervos a >=5 m, no máximo 1 luz adicional e reversão exclusiva do commit R5. A validação passou parser (`PARSER_EXIT=0`) e 36 segundos de QA com 13 eventos de grounding, `route_cycle=1`, `clear=true`, distância fauna 27,41 m, sem cairn/parede vegetal e sem módulos de produção alterados. Ver `CP_D5_098_VALIDACAO_R5_INTEGRACAO.md` e `CP-D5-098_R5_INTEGRATION_RUNTIME.log`.

## CP-D5-099 — CONCLUÍDO: Ficha integração R6
`CP_D5_099_FICHA_INTEGRACAO_R6.md` define a integração isolada da Margem Viva R6, preservando a âncora `(60,252)`, corredor Elias `x=60`, água separada da rota, ruína colapsada sem cais/cairn, 4 elementos vegetais, 2 cervos a >=5 m, no máximo 1 luz adicional e reversão exclusiva do commit R6. A validação passou parser (`PARSER_EXIT=0`) e 36 segundos de QA com 9 eventos de grounding, `route_cycle=1`, `clear=true`, distância fauna 20,08 m, `pier_slabs=0`, `collapsed_ruin=true` e sem módulos de produção alterados. Ver `CP_D5_099_VALIDACAO_R6_INTEGRACAO.md` e `CP-D5-099_R6_INTEGRATION_RUNTIME.log`.

## CP-D5-100 — CONCLUÍDO: Regressão do mapa vivo R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA após as integrações R5/R6, confirmando 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e continuidade para a âncora 7. Ver `CP_D5_100_REGRESSAO_MAPA_VIVO_R1_R6.md` e `CP-D5-100_LIVING_MAP_REGRESSION_RUNTIME.log`.

## CP-D5-101 — CONCLUÍDO: Ficha integração R3
`CP_D5_101_FICHA_INTEGRACAO_R3.md` define a integração isolada do Arco das Ruínas Vivo, preservando a âncora `(-16.741,48)`, o corredor Elias, o alvo físico `z=92`, duas ruínas laterais, 2 cervos a >=5 m, 4 elementos vegetais, ausência de arco estrutural e no máximo 1 luz candidata. A validação passou parser (`PARSER_EXIT=0`) e 36 segundos de QA com 8 eventos de grounding, 4 ciclos `clear=true`, distância mínima de 11,49 m, `structural_arch=false`, `scale_compressed=false` e sem produção alterada. Ver `CP_D5_101_VALIDACAO_R3_INTEGRACAO.md` e `CP-D5-101_R3_INTEGRATION_RUNTIME.log`.

## CP-D5-102 — CONCLUÍDO: Ficha integração R1
`CP_D5_102_FICHA_INTEGRACAO_R1.md` define a integração isolada da Casa Voss Viva, preservando a âncora `(-22,8)`, o corredor Elias `x=-21.4`, a saída R1→R2, a horta lateral, 2 cervos a >=5 m, a porta e o interior de produção intactos e no máximo 1 luz candidata. A validação passou parser (`PARSER_EXIT=0`) e 36 segundos de QA com 8 eventos de grounding, 4 ciclos `clear=true`, distância mínima de 9,07 m, `house_production_touched=false`, `door_touched=false` e sem módulos de produção alterados. Ver `CP_D5_102_VALIDACAO_R1_INTEGRACAO.md` e `CP-D5-102_R1_INTEGRATION_RUNTIME.log`.

## CP-D5-103 — CONCLUÍDO: Revalidação da integração R2
A ficha `CP_D5_096_FICHA_INTEGRACAO_R2.md` foi revalidada com parser (`PARSER_EXIT=0`) e 36 segundos de QA em `R2LivingRiverRoadPreview.tscn`, confirmando 9 eventos de grounding, 5 travessias `bridge_crossed=true` e `clear=true`, distância mínima de 12,08 m, ponte modular, `bridge_glb=false`, `wall_of_trees=false` e produção inalterada. Ver `CP_D5_103_VALIDACAO_R2_INTEGRACAO.md` e `CP-D5-103_R2_INTEGRATION_RUNTIME.log`.

## CP-D5-104 — CONCLUÍDO: Regressão Floresta Densa Viva R4
`R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 12 eventos de grounding, 3 ciclos `clear=true`, distância mínima de 20,42 m, `structural_portal=false`, `wall_of_trees=false` e produção inalterada. A captura gráfica oficial de R4 continua pendente por limitação headless. Ver `CP_D5_104_REGRESSAO_R4_VIVA.md` e `CP-D5-104_R4_REGRESSION_RUNTIME.log`.

## CP-D5-105 — CONCLUÍDO: Regressão Margem Viva R6
`R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA após a suavização orgânica, confirmando 9 eventos de grounding, 1 ciclo `clear=true`, distância fauna 20,08 m, `collapsed_ruin=true`, `pier_slabs=0`, `wall_of_trees=false` e produção inalterada. A captura gráfica oficial de R6 continua pendente por limitação headless. Ver `CP_D5_105_REGRESSAO_R6_VIVA.md` e `CP-D5-105_R6_REGRESSION_RUNTIME.log`.

## CP-D5-106 — CONCLUÍDO: Regressão sequência viva R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA após os novos handoffs, confirmando 8 checks, `no_anchor_skip=true`, R1→R2→R3→R4, `majestic_lateral=true`, R5→R6, `ruins_arrival=true` e continuidade para a âncora 7. Ver `CP_D5_106_REGRESSAO_SEQUENCIA_VIVA_R1_R6.md` e `CP-D5-106_R1_R4_SEQUENCE_RUNTIME.log`.

## CP-D5-107 — CONCLUÍDO: Regressão Clareira Majestic Viva R5
`R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 14 eventos de grounding, pavilhão visível, 1 ciclo `clear=true`, distância fauna 27,41 m, `cairn=false`, `wall_of_trees=false` e produção inalterada. Ver `CP_D5_107_REGRESSAO_R5_VIVA.md` e `CP-D5-107_R5_REGRESSION_RUNTIME.log`.

## CP-D5-108 — CONCLUÍDO: Regressão apresentação Elias third-person
`EliasThirdPersonPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando `CameraQA` externa activa, zero `SCRIPT ERROR`/`Parse Error` e nenhuma alteração a `Player.gd` ou produção. Ver `CP_D5_108_REGRESSAO_ELIAS_PRESENTATION.md` e `CP-D5-108_ELIAS_PRESENTATION_RUNTIME.log`.

## CP-D5-109 — CONCLUÍDO: Auditoria captura R4
A sessão de captura interna de `R4LivingForestPreview.tscn` passou 36 segundos com 3 ciclos `clear=true`, 12 grounding, distância fauna mínima de 20,42 m, sem portal/parede vegetal e sem erros. O fallback registou `snapshot_unavailable=headless_image`; a aprovação visual oficial de R4 permanece pendente. Ver `CP_D5_109_AUDITORIA_CAPTURA_R4.md` e `CP-D5-109_R4_CAPTURE_AUDIT_RUNTIME.log`.

## CP-D5-110 — CONCLUÍDO: Handoff Elias R3→R4
`EliasArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando âncora R3 `(-16.741,48)`, alvo físico `z=92`, 2 ciclos `route_open=true`, destino R4, câmara de Elias inactiva e `structural_arch=false`. Ver `CP_D5_110_VALIDACAO_HANDOFF_R3_R4.md` e `CP-D5-110_R3_R4_HANDOFF_RUNTIME.log`.

## CP-D5-111 — CONCLUÍDO: Correcção colocação cartográfica
`CartographicPlacementPreview.gd` teve corrigida a indentação dos fallbacks headless que causava `Parse Error: Unexpected "if" in class body`. A revalidação passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, emitindo as 6 âncoras X/Z canónicas de Casa Voss, Estrada, Arco, Floresta, Majestic e Ruínas. A alteração ficou limitada a `levels/dev5/`. Ver `CP_D5_111_CORRECCAO_PLACEMENT_QA.md`, `CP-D5-111_CARTOGRAPHIC_PLACEMENT_RUNTIME_FIXED.log` e o log inicial da regressão.

## CP-D5-112 — CONCLUÍDO: Regressão grounding cartográfico
`CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, aterrando o anexo Casa Voss de 15,00 m para -2,78 m e a ponte R2 de 18,00 m para -2,71 m, com X/Z preservados nos dois casos. Ver `CP_D5_112_REGRESSAO_GROUNDING.md` e `CP-D5-112_GROUNDING_RUNTIME.log`.

## CP-D5-113 — CONCLUÍDO: Regressão contratos de altura R1–R6
`CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando cobertura 6/6, três proprietários, grounding por raycast, `status=approved`, produção inalterada e exclusão das geometrias rejeitadas do arco R3 e cais R6. Ver `CP_D5_113_REGRESSAO_CONTRATOS_ALTURA.md` e `CP-D5-113_HEIGHT_CONTRACTS_RUNTIME.log`.

## CP-D5-114 — CONCLUÍDO: Regressão orçamento de malhas
`MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, recontando 20.390 triângulos, 9 nós de malha, 12 slots de material, zero colisores importados e zero luzes dinâmicas. Ver `CP_D5_114_AUDITORIA_MALHAS_REGRESSAO.md` e `CP-D5-114_MESH_BUDGET_RUNTIME.log`.

## CP-D5-115 — CONCLUÍDO: Regressão LOD vegetal
`VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 1 árvore PBR focal, 3 árvores detalhadas médias, 8 elementos leves distantes, zero luzes dinâmicas, zero colisores importados e produção inalterada. Ver `CP_D5_115_REGRESSAO_VEGETATION_LOD.md` e `CP-D5-115_VEGETATION_LOD_RUNTIME.log`.

## CP-D5-116 — CONCLUÍDO: Auditoria luzes dinâmicas R4/R5
A cena inicialmente procurada `LightBudgetAuditPreview.tscn` não existe; a validação efectiva foi executada em `GroundedVegetationR4R5Preview.tscn`. O parser passou (`PARSER_EXIT=0`) e a QA de 36 segundos confirmou 12 candidatos aterrados, 1 pinheiro focal, 3 árvores médias, 6 elementos leves, 2 fetos, `dynamic_lights_added=0`, `wall_of_trees=false` e produção inalterada. Ver `CP_D5_116_AUDITORIA_LUZES_VEGETACAO.md`, `CP-D5-116_LIGHT_BUDGET_RUNTIME_FIXED.log` e o log da tentativa inicial.

## CP-D5-117 — CONCLUÍDO: Regressão câmara Elias
`EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando `elias_camera_current=false`, `external_camera_current=true`, proprietário `CameraQAExterna`, uma câmara activa e nenhuma alteração a `Player.gd` ou módulos regionais. Ver `CP_D5_117_REGRESSAO_CAMERA_ELIAS.md` e `CP-D5-117_CAMERA_CONTRACT_RUNTIME.log`.

## CP-D5-118 — CONCLUÍDO: Regressão auditoria de colisores
`CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 6 candidatos, offsets X/Z zero, passagem R4 de 2,4 m, composição vegetal R4/R5, ruínas R6 submersas, 0 luzes dinâmicas globais e 0 scripts de produção. Ver `CP_D5_118_REGRESSAO_AUDITORIA_COLISORES.md` e `CP-D5-118_COLLISION_CONTRACT_RUNTIME.log`.

## CP-D5-119 — CONCLUÍDO: Regressão monólito R6
`SubmergedShoreMonolithPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando âncora 6 `(52,260)`, grounding Y `18,00→-0,00`, X/Z preservado, colisor `MargemR6ColisorQA`, `dynamic_lights_added=0`, `pier_slabs=0`, `uniform_columns=0` e produção inalterada. Ver `CP_D5_119_REGRESSAO_MONOLITO_R6.md` e `CP-D5-119_R6_MONOLITH_RUNTIME.log`.

## CP-D5-120 — CONCLUÍDO: Regressão legibilidade R6
`R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 3 ângulos com Elias, monólito e corredor visíveis, monólito `(52,260)`, 2 ciclos `clear=true`, grounding confirmado, câmara de Elias inactiva e produção inalterada. Ver `CP_D5_120_REGRESSAO_LEGIBILIDADE_R6.md` e `CP-D5-120_R6_READABILITY_RUNTIME.log`.

## CP-D5-121 — CONCLUÍDO: Regressão clareira Elias R4
`EliasForestClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 6/6 elementos aterrados, corredor de 5,20 m, clearance mínimo de 2,75 m, 2 ciclos `corridor_open=true`, câmara de Elias inactiva, portal/parede vegetal ausentes e produção inalterada. Ver `CP_D5_121_REGRESSAO_ELIAS_FLORESTA.md` e `CP-D5-121_ELIAS_FOREST_RUNTIME.log`.

## CP-D5-122 — CONCLUÍDO: Regressão ponte R2
`EliasStoneBridgeTraversalPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando âncora R2 `(-21,40;28)`, grounding no `tabuleiro_continuo`, folga 0,21 m sobre mínimo 0,20 m, ponte modular, `glb_bridge=false`, 3 ciclos aprovados, câmara externa preservada e produção inalterada. Ver `CP_D5_122_REGRESSAO_PONTE_R2.md` e `CP-D5-122_R2_BRIDGE_RUNTIME.log`.

## CP-D5-123 — CONCLUÍDO: Regressão rumo Voss→Estrada
`EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando Casa Voss `(-22,8)`, Estrada `(-21,4;12)`, Ponte R2 `(-21,4;28)`, 8 ciclos para `RUMO À ESTRADA DO RIO`, câmara externa preservada e produção inalterada. Ver `CP_D5_123_REGRESSAO_RUMO_VOSS_R2.md` e `CP-D5-123_VOSS_HEADING_RUNTIME.log`.

## CP-D5-124 — CONCLUÍDO: Regressão rumo Majestic→Ruínas
`EliasR5R6HeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando início `(-80,190)`, destino Ruínas id 6, `arrival_r6=true`, canvas R5 `(195,6;261,4)`, canvas R6 `(408,351)`, continuidade para a âncora 7 e câmara externa preservada. Ver `CP_D5_124_REGRESSAO_RUMO_MAJESTIC_R6.md` e `CP-D5-124_R5_R6_HEADING_RUNTIME.log`.

## CP-D5-125 — CONCLUÍDO: Regressão integrada R4
`R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando estado aprovado, 3 ciclos `clear=true`, fauna mínima de 20,42 m, 12 grounding, 2 cervos, 8 vegetações, portal/parede vegetal ausentes e produção inalterada. Ver `CP_D5_125_REGRESSAO_R4_INTEGRADA.md` e `CP-D5-125_R4_INTEGRATED_RUNTIME.log`.

## CP-D5-126 — CONCLUÍDO: Regressão integrada R6
`R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando estado aprovado, 1 ciclo `clear=true`, fauna mínima de 20,08 m, 9 grounding, 3 partes de ruína colapsada, `pier_slabs=0`, `wall_of_trees=false` e produção inalterada. Ver `CP_D5_126_REGRESSAO_R6_INTEGRADA.md` e `CP-D5-126_R6_INTEGRATED_RUNTIME.log`.

## CP-D5-127 — CONCLUÍDO: Regressão integrada R5
`R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando estado aprovado, 1 ciclo `clear=true`, fauna mínima de 27,41 m, 14 grounding, pavilhão visível, cairn/parede vegetal ausentes e produção inalterada. Ver `CP_D5_127_REGRESSAO_R5_INTEGRADA.md` e `CP-D5-127_R5_INTEGRATED_RUNTIME.log`.

## CP-D5-128 — CONCLUÍDO: Regressão folga Elias R6
`EliasR6ClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito aterrado `(52,260)`, colisor `CorredorMargemR6EliasQA`, rota Elias `x=60`, clearance 6,05 m sobre mínimo 4,00 m, 2 ciclos `clear=true`, viewport externo e produção inalterada. Ver `CP_D5_128_REGRESSAO_ELIAS_R6_CLEARANCE.md` e `CP-D5-128_R6_CLEARANCE_RUNTIME.log`.

## CP-D5-129 — CONCLUÍDO: Passe substituto técnico Majestic
`MajesticEliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando pavilhão aterrado `(-88,178)`, câmara `CameraQAMajesticLeitura`, rota Elias `x=-80`, clearance 5,45 m, 5 vegetações em profundidade, 2 ciclos `clear=true`, parede vegetal ausente e produção inalterada. O passe não promove visualmente o Majestic: o pavilhão procedural permanece `REJECTED_VISUAL` e o Fantasy House do Dev7 ainda não foi integrado. Ver `CP_D5_129_PASSE_SUBSTITUTO_MAJESTIC.md` e `CP-D5-129_MAJESTIC_SUBSTITUTE_RUNTIME.log`.

## CP-D5-130 — CONCLUÍDO: Validação folga técnica Majestic
`EliasMajesticClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando pavilhão aterrado `(-88,178)`, colisor `CorredorMajesticEliasQA`, rota Elias `x=-80`, clearance 5,45 m sobre mínimo 4,00 m, 2 ciclos `clear=true`, câmara externa e produção inalterada. A validação é apenas técnica; `REJECTED_VISUAL` permanece até activo autorizado do Dev7. Ver `CP_D5_130_VALIDACAO_MAJESTIC_CLEARANCE.md` e `CP-D5-130_MAJESTIC_CLEARANCE_RUNTIME.log`.

## CP-D5-131 — CONCLUÍDO: Regressão sequência R1→R6
A primeira invocação apontou para cena inexistente e terminou `QA_EXIT=1`; após diagnóstico, `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA. Foram confirmados 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true`, estado aprovado e continuidade para a âncora 7. Ver `CP_D5_131_REGRESSAO_SEQUENCIA_R1_R6.md`, `CP-D5-131_FULL_SEQUENCE_RUNTIME.log` e `CP-D5-131_FULL_SEQUENCE_FIXED_RUNTIME.log`.

## CP-D5-132 — CONCLUÍDO: Regressão contratos de altura
`CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando cobertura dos 6 marcos R1–R6, 3 proprietários de terreno, preservação X/Z, grounding por raycast, exclusão do arco estrutural R3 e do cais R6, estado aprovado e produção inalterada. Ver `CP_D5_132_REGRESSAO_CONTRATOS_ALTURA.md` e `CP-D5-132_HEIGHT_CONTRACTS_RUNTIME.log`.

## CP-D5-133 — CONCLUÍDO: Auditoria mesh budget GTX 1050 Ti
`MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 20.390 triângulos, 9 nós de malha, 12 slots de material, 0 colisores importados, 0 luzes dinâmicas e produção inalterada. Ver `CP_D5_133_AUDITORIA_MESH_BUDGET.md` e `CP-D5-133_MESH_BUDGET_RUNTIME.log`.

## CP-D5-134 — CONCLUÍDO: Regressão densidade vegetal
`VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 1 pinheiro focal, 3 árvores médias, 1 árvore leve, 2 fetos, 27.208 triângulos, 0 luzes dinâmicas, `wall_density=false` e produção inalterada. Ver `CP_D5_134_REGRESSAO_VEGETATION_DENSITY.md` e `CP-D5-134_VEGETATION_DENSITY_RUNTIME.log`.

## CP-D5-135 — CONCLUÍDO: Validação handoff R6→R7
`EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando R6 `(60,252)`, destino `PASSAGEM: VILA ELEVADA` id 7, marcador R7 `(140,352)` alcançado, `dev2_geometry_created=false`, câmara externa preservada e produção inalterada. Ver `CP_D5_135_VALIDACAO_HANDOFF_R6_R7.md` e `CP-D5-135_R6_R7_HANDOFF_RUNTIME.log`.

## CP-D5-136 — CONCLUÍDO: Regressão multi-landmark
`MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando Casa Voss R1 e Ponte Marco 2 R2 aterradas em terreno irregular, X/Z canónicos, `production_script=false`, `dynamic_lights=0` e produção inalterada. Ver `CP_D5_136_REGRESSAO_MULTI_LANDMARK.md` e `CP-D5-136_MULTI_LANDMARK_RUNTIME.log`.

## CP-D5-137 — CONCLUÍDO: Regressão integrada Casa Voss R1
`R1LivingVossExteriorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando estado aprovado, 4 ciclos `clear=true`, fauna mínima de 9,07 m, 8 grounding, 2 fauna, 5 elementos de jardim, casa/porta de produção não tocadas e produção inalterada. Ver `CP_D5_137_REGRESSAO_R1_VOSS.md` e `CP-D5-137_R1_VOSS_RUNTIME.log`.

## CP-D5-138 — CONCLUÍDO: Regressão integrada Estrada do Rio R2
`R2LivingRiverRoadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando estado aprovado, 5 travessias da ponte modular, 5 ciclos `clear=true`, fauna mínima de 12,08 m, 9 grounding, ponte GLB ausente, parede vegetal ausente e produção inalterada. Ver `CP_D5_138_REGRESSAO_R2_RIVER.md` e `CP-D5-138_R2_RIVER_RUNTIME.log`.

## CP-D5-139 — CONCLUÍDO: Regressão integrada Corredor R3
`R3LivingArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando estado aprovado, 4 ciclos `clear=true`, fauna mínima de 11,49 m, 8 grounding, `structural_arch=false`, `scale_compressed=false` e produção inalterada. Ver `CP_D5_139_REGRESSAO_R3_ARCH.md` e `CP-D5-139_R3_ARCH_RUNTIME.log`.

## CP-D5-140 — CONCLUÍDO: Regressão final Elias third-person
`EliasThirdPersonPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando `CameraQA` activa, câmara externa, corpo 3D de Elias, ausência de erros de script, `Player.gd` e módulos regionais não alterados e produção inalterada. Ver `CP_D5_140_REGRESSAO_ELIAS_FINAL.md` e `CP-D5-140_ELIAS_FINAL_RUNTIME.log`.

## CP-D5-141 — CONCLUÍDO: Regressão placement final
`CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando as 6 âncoras canónicas R1–R6, posições X/Z preservadas, ausência de offsets arbitrários e produção inalterada. Ver `CP_D5_141_REGRESSAO_PLACEMENT_FINAL.md` e `CP-D5-141_PLACEMENT_RUNTIME.log`.

## CP-D5-142 — CONCLUÍDO: Regressão grounding final
`CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando dois candidatos aterrados por raycast, `xz_preserved=true`, colisores `TerrenoColisorQA` e produção inalterada. Ver `CP_D5_142_REGRESSAO_GROUNDING_FINAL.md` e `CP-D5-142_GROUNDING_RUNTIME.log`.

## CP-D5-143 — ACTIVO
Abrir a próxima ficha de integração ou regressão autorizada imediatamente após esta publicação, sem consulta passiva ou espera temporal.




## Correcção CEO — Identidade do jogador

A identidade correcta do jogador é **Elias**. Toda a frente Dev5 usa exclusivamente `EliasThirdPersonPresentation` e `EliasThirdPersonPreview`; as nomenclaturas anteriores foram removidas de scripts, cenas, referências e documentação. A cena QA isolada passou o parser Godot 4.7.1 e manteve uma sessão de 36 segundos, com captura interna do corpo 3D provisório de Elias e da câmara externa. Esta apresentação é uma fundação técnica tridimensional, não a versão artística final do personagem.

**Tarefa activa actual:** `CP-D5-143` — abrir a próxima ficha de integração ou regressão autorizada imediatamente, sem consulta passiva ou espera temporal.
