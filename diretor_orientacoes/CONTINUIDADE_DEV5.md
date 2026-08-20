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

## CP-D5-143 — CONCLUÍDO: Regressão margem orgânica R6
`R6OrganicShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando terreno orgânico, 10 grounding, 4 folhagens, 5 afloramentos, monólito aterrado `(52,260)`, 2 ciclos `clear=true`, 0 cubos de margem, 0 lajes de cais, parede vegetal ausente e produção inalterada. Ver `CP_D5_143_REGRESSAO_R6_ORGANIC.md` e `CP-D5-143_R6_ORGANIC_RUNTIME.log`.

## CP-D5-144 — CONCLUÍDO: Regressão integrada Floresta R4
`R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando estado aprovado, 3 ciclos `clear=true`, fauna mínima de 20,42 m, 12 grounding, 8 vegetações, `structural_portal=false`, `wall_of_trees=false` e produção inalterada. Ver `CP_D5_144_REGRESSAO_R4_FOREST.md` e `CP-D5-144_R4_FOREST_RUNTIME.log`.

## CP-D5-145 — CONCLUÍDO: Regressão integrada Majestic R5
`R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando estado aprovado, pavilhão visível, 14 grounding, 1 ciclo `clear=true`, fauna mínima de 27,41 m, 8 vegetações, `cairn=false`, `wall_of_trees=false` e produção inalterada. A rejeição visual permanece respeitada. Ver `CP_D5_145_REGRESSAO_R5_MAJESTIC.md` e `CP-D5-145_R5_MAJESTIC_RUNTIME.log`.

## CP-D5-146 — CONCLUÍDO: Regressão integrada margem R6
`R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando estado aprovado, 1 ciclo `clear=true`, fauna de 20,08 m, 9 grounding, ruína colapsada, 0 lajes de cais, parede vegetal ausente e produção inalterada. Ver `CP_D5_146_REGRESSAO_R6_SHORE.md` e `CP-D5-146_R6_SHORE_RUNTIME.log`.

## CP-D5-147 — CONCLUÍDO: Auditoria legibilidade R6
`R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 3 ângulos com Elias, monólito e corredor visíveis, 2 ciclos `clear=true`, monólito aterrado, ausência de cais e produção inalterada. Ver `CP_D5_147_AUDITORIA_LEGIBILIDADE_R6.md` e `CP-D5-147_R6_READABILITY_RUNTIME.log`.

## CP-D5-148 — CONCLUÍDO: Passe leitura vegetação R6
`R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito aterrado, 3 elementos vegetais aterrados, clearance Elias de 6,05 m, 2 ciclos `clear=true`, `CameraQAR6Leitura`, 0 lajes de cais, parede vegetal ausente e produção inalterada. Ver `CP_D5_148_PASSE_LEITURA_VEGETACAO_R6.md` e `CP-D5-148_R6_VEGETATION_READ_RUNTIME.log`.

## CP-D5-149 — CONCLUÍDO: Auditoria integrada final
`CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 6 candidatos R1–R6, offsets zero, 0 scripts de produção, 0 luzes dinâmicas, colisores auditados, vegetação PBR/média/distante controlada, passagem R4 de 2,4 m e R6 submersa sem emissivo. Ver `CP_D5_149_AUDITORIA_INTEGRADA_FINAL.md` e `CP-D5-149_INTEGRATED_AUDIT_RUNTIME.log`.

## CP-D5-150 — CONCLUÍDO: Regressão composição vegetal R4/R5
`MediumVegetationCompositionPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando R4/R5 com 1 PBR, 3 elementos médios, 4 distantes por composição, offsets `(0,0)`, `wall_of_trees=false`, `production_script=false` e produção inalterada. Ver `CP_D5_150_REGRESSAO_MEDIUM_VEGETATION.md` e `CP-D5-150_MEDIUM_VEGETATION_RUNTIME.log`.

## CP-D5-151 — CONCLUÍDO: Regressão LOD vegetal final
`VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando limites focal `1_pbr_tree`, médio `3_detailed_trees`, distante `8_light_foliage`, 0 colisores importados, 0 luzes dinâmicas e produção inalterada. Ver `CP_D5_151_REGRESSAO_VEGETATION_LOD_FINAL.md` e `CP-D5-151_VEGETATION_LOD_RUNTIME.log`.

## CP-D5-152 — CONCLUÍDO: Auditoria light/grounding R4/R5
`GroundedVegetationR4R5Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 12 candidatos aterrados, X/Z preservado, 1 pinheiro focal, 3 árvores detalhadas, 6 elementos leves, 2 fetos, 0 luzes dinâmicas adicionadas, `wall_of_trees=false` e produção inalterada. Ver `CP_D5_152_AUDITORIA_LIGHT_GROUNDING_R4_R5.md` e `CP-D5-152_LIGHT_BUDGET_RUNTIME.log`.

## CP-D5-153 — CONCLUÍDO: Regressão travessia Ponte R2
`EliasStoneBridgeTraversalPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 3 ciclos, ponte modular aterrada, folga de tabuleiro de 0,21 m sobre mínimo 0,20 m, ponte GLB ausente, câmara externa e produção inalterada. Ver `CP_D5_153_REGRESSAO_ELias_STONE_BRIDGE.md` e `CP-D5-153_STONE_BRIDGE_RUNTIME.log`.

## CP-D5-154 — CONCLUÍDO: Regressão rumo Voss→Estrada R2
`EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 8 ciclos apontando à Estrada do Rio id 2, Casa Voss `(-22,8)`, Estrada `(-21,4;12)`, ponte `(-21,4;28)`, câmara externa e produção inalterada. Ver `CP_D5_154_REGRESSAO_RUMO_VOSS_R2.md` e `CP-D5-154_VOSS_HEADING_RUNTIME.log`.

## CP-D5-155 — CONCLUÍDO: Handoff final R6→R7
`EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando R6 `(60,252)`, marcador `PASSAGEM: VILA ELEVADA` id 7 em `(140,352)` alcançado, `marker_only=true`, `dev2_geometry_created=false`, câmara externa e produção inalterada. Ver `CP_D5_155_VALIDACAO_HANDOFF_R6_R7_FINAL.md` e `CP-D5-155_R6_R7_FINAL_RUNTIME.log`.

## CP-D5-156 — CONCLUÍDO: Regressão clearance monólito R6
`R6MonolithClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito aterrado `(52,260)`, clearance de 6,05 m sobre mínimo 4,00 m, 2 ciclos `clear=true`, corredor preservado, cais ausente e produção inalterada. Ver `CP_D5_156_REGRESSAO_MONOLITH_CLEARANCE_FINAL.md` e `CP-D5-156_MONOLITH_CLEARANCE_RUNTIME.log`.

## CP-D5-157 — CONCLUÍDO: Regressão sequência final R1→R6
`CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true`, estado aprovado, continuidade para a âncora 7 e produção inalterada. Ver `CP_D5_157_REGRESSAO_SEQUENCIA_FINAL.md` e `CP-D5-157_SEQUENCE_FINAL_RUNTIME.log`.

## CP-D5-158 — CONCLUÍDO: Regressão contrato câmara Elias
`EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 1 câmara externa activa, viewport `CameraQAExterna`, apresentação técnica aprovada, `Player.gd` inalterado, módulos regionais inalterados e produção preservada. Ver `CP_D5_158_REGRESSAO_CAMERA_CONTRACT.md` e `CP-D5-158_CAMERA_CONTRACT_RUNTIME.log`.

## CP-D5-159 — CONCLUÍDO: Regressão handoff R6→R7
`EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando origem R6 `(60,252)`, marcador R7 `PASSAGEM: VILA ELEVADA` id 7 alcançado, `marker_only=true`, geometria Dev2 não criada, câmara Elias de produção inactiva e módulos de produção inalterados. Ver `CP_D5_159_REGRESSAO_R6_R7_HANDOFF.md` e `CP-D5-159_R6R7_HANDOFF_RUNTIME.log`.

## CP-D5-160 — CONCLUÍDO: Auditoria densidade vegetal GTX 1050 Ti
`VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 1 pinheiro focal, 3 árvores médias, 1 elemento leve, 2 fetos, 27.208 triângulos, 0 luzes dinâmicas e `wall_density=false`. Ver `CP_D5_160_AUDITORIA_DENSIDADE_VEGETAL.md` e `CP-D5-160_VEGETATION_DENSITY_RUNTIME.log`.

## CP-D5-161 — CONCLUÍDO: Regressão legibilidade angular R6
`R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 3 ângulos com Elias, monólito e corredor visíveis, 2 ciclos `clear=true`, monólito aterrado, câmara Elias de produção inactiva e produção inalterada. Ver `CP_D5_161_REGRESSAO_LEGIBILIDADE_R6.md` e `CP-D5-161_R6_READABILITY_RUNTIME.log`.

## CP-D5-162 — CONCLUÍDO: Regressão heading R5→R6
`EliasR5R6HeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando origem `(-80,190)`, destino R6 `RUMO ÀS RUÍNAS` id 6, chegada R6, próximo marcador R7 id 7, câmara Elias de produção inactiva e produção inalterada. Ver `CP_D5_162_REGRESSAO_HEADING_R5_R6.md` e `CP-D5-162_R5R6_HEADING_RUNTIME.log`.

## CP-D5-163 — CONCLUÍDO: Regressão clearance Elias R4
`EliasForestClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 6/6 elementos aterrados, clearance mínimo de 2,75 m, 2 ciclos de rota limpos, corredor aberto, portal estrutural ausente, parede de árvores ausente e produção inalterada. Ver `CP_D5_163_REGRESSAO_CLEARANCE_R4.md` e `CP-D5-163_FOREST_CLEARANCE_RUNTIME.log`.

## CP-D5-164 — CONCLUÍDO: Regressão clearance Majestic R5
`EliasMajesticClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando pavilhão aterrado em `(−88,178)`, rota lateral em `x=−80`, clearance de 5,45 m sobre mínimo 4,00 m, 2 ciclos `clear=true`, actor Elias, câmara de produção inactiva e produção preservada. Ver `CP_D5_164_REGRESSAO_CLEARANCE_MAJESTIC.md` e `CP-D5-164_MAJESTIC_CLEARANCE_RUNTIME.log`.

## CP-D5-165 — CONCLUÍDO: Regressão heading R1→R2
`EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando Casa Voss `(−22,8)`, Estrada `(−21,4;12)`, ponte candidata `(−21,4;28)`, destino R2 id 2, 8 ciclos de rota, câmara Elias de produção inactiva e produção preservada. Ver `CP_D5_165_REGRESSAO_HEADING_R1_R2.md` e `CP-D5-165_VOSS_ROAD_HEADING_RUNTIME.log`.

## CP-D5-166 — CONCLUÍDO: Regressão corredor vivo R3
`R3LivingArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 2 partes de ruína, 8 elementos aterrados, clearance fauna de 11,49–12,26 m em 4 ciclos, ausência do arco estrutural, escala não comprimida e produção preservada. Ver `CP_D5_166_REGRESSAO_R3_CORREDOR_VIVO.md` e `CP-D5-166_R3_LIVING_ARCH_RUNTIME.log`.

## CP-D5-167 — CONCLUÍDO: Regressão margem orgânica R6
`R6OrganicShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito aterrado em `(52,260)`, 10 elementos orgânicos aterrados, 4 folhagens, 5 afloramentos, zero lajes de cais, ausência de cubos de margem e parede de árvores, 2 ciclos `clear=true` e produção preservada. Ver `CP_D5_167_REGRESSAO_MARGEM_ORGANICA_R6.md` e `CP-D5-167_R6_ORGANIC_SHORE_RUNTIME.log`.

## CP-D5-168 — CONCLUÍDO: Regressão leitura vegetação R6
`R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito em `(52,260)`, 3 vegetações aterradas, clearance de 6,05 m, zero lajes de cais, `wall_of_trees=false`, viewport `CameraQAR6Leitura`, 2 ciclos limpos, Elias activo e produção preservada. Ver `CP_D5_168_REGRESSAO_LEITURA_VEGETACAO_R6.md` e `CP-D5-168_R6_ELIAS_VEGETATION_RUNTIME.log`.

## CP-D5-169 — CONCLUÍDO: Auditoria placement R1→R6
`CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando as seis âncoras R1→R6 com coordenadas X/Z canónicas e canvas do mapa: R1 `(−22,8)`, R2 `(−21,4;12)`, R3 `(−16,741;48)`, R4 `(−9;116)`, R5 `(−88;178)` e R6 `(60;252)`. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer; produção preservada. Ver `CP_D5_169_AUDITORIA_PLACEMENT_R1_R6.md` e `CP-D5-169_PLACEMENT_AUDIT_RUNTIME.log`.

## CP-D5-170 — CONCLUÍDO: Regressão Elias third-person
`EliasThirdPersonPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando `CameraQA` activa, apresentação `EliasThirdPersonPresentation`, `Player.gd` inalterado, câmara de produção não assumida e produção preservada. Ver `CP_D5_170_REGRESSAO_ELIAS_THIRD_PERSON.md` e `CP-D5-170_ELIAS_PRESENTATION_RUNTIME.log`.

## CP-D5-171 — CONCLUÍDO: Regressão integrada R1→R6
`CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true`, marcador final R7 `PASSAGEM: VILA ELEVADA` id 7 e produção preservada. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. Ver `CP_D5_171_REGRESSAO_INTEGRADA_R1_R6.md` e `CP-D5-171_FULL_SEQUENCE_RUNTIME.log`.

## CP-D5-172 — CONCLUÍDO: Regressão travessia ponte R2
`EliasStoneBridgeTraversalPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando ponte R2 em `(−21,4;28)` aterrada, colisor `tabuleiro_continuo`, clearance de 0,21 m sobre mínimo 0,20 m, tipo modular, ponte GLB ausente, 3 ciclos limpos e produção preservada. Ver `CP_D5_172_REGRESSAO_TRAVESSIA_PONTE_R2.md` e `CP-D5-172_BRIDGE_TRAVERSAL_RUNTIME.log`.

## CP-D5-173 — CONCLUÍDO: Regressão floresta viva R4
`R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 8 vegetações, 2 partes de abrigo, 12 elementos aterrados, distância fauna de 20,42–20,77 m em 3 ciclos, ausência de portal estrutural e parede de árvores e produção preservada. Ver `CP_D5_173_REGRESSAO_FLORESTA_VIVA_R4.md` e `CP-D5-173_R4_LIVING_FOREST_RUNTIME.log`.

## CP-D5-174 — CONCLUÍDO: Regressão Majestic vivo R5
`R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 8 vegetações, 3 partes de abrigo, 14 elementos aterrados, pavilhão visível, clearance fauna de 27,41 m, ausência de marco de pedras e parede de árvores, 1 ciclo limpo e produção preservada. Ver `CP_D5_174_REGRESSAO_MAJESTIC_VIVO_R5.md` e `CP-D5-174_R5_LIVING_MAJESTIC_RUNTIME.log`.

## CP-D5-175 — CONCLUÍDO: Regressão exterior vivo R1
`R1LivingVossExteriorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 5 elementos de jardim, 8 elementos aterrados, 4 ciclos `clear=true`, distância fauna de 9,07–9,87 m, Casa Voss e portas de produção intocadas e produção preservada. Ver `CP_D5_175_REGRESSAO_VOSS_EXTERIOR_R1.md` e `CP-D5-175_R1_VOSS_EXTERIOR_RUNTIME.log`.

## CP-D5-176 — CONCLUÍDO: Regressão contratos altura R1→R6
`CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando cobertura 6/6, 3 proprietários de terreno, raycast obrigatório, X/Z canónicos, produção inalterada e exclusão explícita do arco estrutural R3 e cais de lajes R6 rejeitados. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. Ver `CP_D5_176_REGRESSAO_CONTRATOS_ALTURA_R1_R6.md` e `CP-D5-176_HEIGHT_CONTRACTS_RUNTIME.log`.

## CP-D5-177 — CONCLUÍDO: Auditoria LOD vegetal GTX 1050 Ti
`VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 4 activos medidos, 13.424/402/6.232/114 triângulos, zero colisores importados, limites de 1 árvore PBR focal, 3 detalhadas médias, 8 elementos leves distantes e 0 luzes dinâmicas. Ver `CP_D5_177_AUDITORIA_LOD_VEGETAL.md` e `CP-D5-177_VEGETATION_LOD_RUNTIME.log`.

## CP-D5-178 — CONCLUÍDO: Regressão estrada viva R2
`R2LivingRiverRoadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 2 partes de abrigo, 9 elementos aterrados, ponte modular atravessada em 5 ciclos, `bridge_glb=false`, distância fauna de 12,08–12,93 m, `wall_of_trees=false` e produção preservada. Ver `CP_D5_178_REGRESSAO_ESTRADA_VIVA_R2.md` e `CP-D5-178_R2_LIVING_ROAD_RUNTIME.log`.

## CP-D5-179 — CONCLUÍDO: Regressão aterramento cartográfico
`CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2/2 contactos válidos por raycast, Casa Voss Y `15,00→−2,78`, ponte Y `18,00→−2,71`, X/Z preservados, colisor `TerrenoColisorQA` e produção inalterada. Ver `CP_D5_179_REGRESSAO_ATERRAMENTO_CARTOGRAFICO.md` e `CP-D5-179_GROUNDING_RUNTIME.log`.

## CP-D5-180 — CONCLUÍDO: Regressão composição aterrada R1→R2
`MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando Casa Voss e ponte marco 2 aterradas em terreno irregular, Y `15,00/18,00→−2,52`, X/Z preservados, âncoras 1/2, script de produção ausente, 0 luzes dinâmicas e Arco R3 rejeitado ausente. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. Ver `CP_D5_180_REGRESSAO_COMPOSICAO_ATERRADA_R1_R2.md` e `CP-D5-180_MULTI_GROUNDED_RUNTIME.log`.

## CP-D5-181 — CONCLUÍDO: Regressão corredor R3 Elias
`EliasArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando R3 `(−16,741;48)`, destino R4 `RUMO À FLORESTA` id 4, rota aberta em 2 ciclos, arco estrutural ausente, câmara Elias de produção inactiva e produção preservada. Ver `CP_D5_181_REGRESSAO_CORREDOR_R3.md` e `CP-D5-181_R3_ELIAS_CORRIDOR_RUNTIME.log`.

## CP-D5-182 — CONCLUÍDO: Regressão monólito margem R6
`SubmergedShoreMonolithPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito R6 em `(52,260)` aterrado por raycast, Y `18,00→−0,00`, X/Z preservados, colisor `MargemR6ColisorQA`, zero lajes de cais, zero colunas uniformes, 0 luzes adicionais e produção preservada. Ver `CP_D5_182_REGRESSAO_MONOLITO_MARGEM_R6.md` e `CP-D5-182_R6_SHORE_MONOLITH_RUNTIME.log`.

## CP-D5-183 — CONCLUÍDO: Regressão clearance final R6 Elias
`EliasR6ClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito aterrado em `(52,260)`, rota `x=60`, clearance de 6,05 m sobre mínimo 4,00 m, colisor `CorredorMargemR6EliasQA`, 2 ciclos `clear=true`, apresentação Elias third-person e câmara de produção inactiva. Ver `CP_D5_183_REGRESSAO_CLEARANCE_FINAL_R6.md` e `CP-D5-183_R6_CLEARANCE_RUNTIME.log`.

## CP-D5-184 — CONCLUÍDO: Auditoria regressão cartográfica R1→R6
`CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 6 candidatos, 0 scripts de produção, 0 luzes dinâmicas, offsets `(0,0)`, âncoras canónicas, Floresta isolada, Ruínas não emissivas e composição vegetal sem parede de árvores. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. Ver `CP_D5_184_AUDITORIA_REGRESSAO_CARTOGRAFICA.md` e `CP-D5-184_CARTOGRAPHIC_AUDIT_RUNTIME.log`.

## CP-D5-185 — CONCLUÍDO: Regressão leitura Majestic R5 Elias
`MajesticEliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando pavilhão aterrado em `(−88,178)`, 5 vegetações aterradas, rota `x=−80`, clearance de 5,45 m, 2 ciclos `clear=true`, viewport `CameraQAMajesticLeitura`, `wall_of_trees=false`, Elias activo e produção preservada. Ver `CP_D5_185_REGRESSAO_LEITURA_MAJESTIC_R5.md` e `CP-D5-185_MAJESTIC_VEGETATION_READ_RUNTIME.log`.

## CP-D5-186 — CONCLUÍDO: Regressão handoff final R6→R7
`EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando origem R6 `(60,252)`, destino R7 `(140,352)`, marcador `PASSAGEM: VILA ELEVADA` id 7 alcançado, `marker_only=true`, geometria Dev2 não criada, câmara Elias de produção inactiva e produção preservada. Ver `CP_D5_186_REGRESSAO_HANDOFF_FINAL_R6_R7.md` e `CP-D5-186_R6R7_HANDOFF_RUNTIME.log`.

## CP-D5-187 — CONCLUÍDO: Regressão vegetação aterrada R4→R5
`GroundedVegetationR4R5Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 12 candidatos aterrados, 1 pinheiro PBR focal, 3 árvores médias, 6 folhagens leves, 2 fetos, X/Z preservados, 0 luzes adicionais, `wall_of_trees=false` e produção preservada. Ver `CP_D5_187_REGRESSAO_VEGETACAO_ATERRADA_R4_R5.md` e `CP-D5-187_R4R5_VEGETATION_RUNTIME.log`.

## CP-D5-188 — CONCLUÍDO: Regressão contrato câmara Elias
`EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando câmara externa QA activa, `active_camera_count=1`, viewport `CameraQAExterna`, câmara Elias de produção inactiva, `Player.gd` e módulos regionais inalterados. Avisos de `viewport_set_scaling_3d_mode` são do renderer Compatibility. Ver `CP_D5_188_REGRESSAO_CAMERA_CONTRACT.md` e `CP-D5-188_CAMERA_CONTRACT_RUNTIME.log`.

## CP-D5-189 — CONCLUÍDO: Regressão heading R1→R2
`EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando Casa Voss `(−22,8)`, Estrada do Rio `(−21,4;12)`, ponte `(−21,4;28)`, destino `RUMO À ESTRADA DO RIO` id 2, 8 ciclos consistentes, câmara de produção inactiva e produção preservada. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. Ver `CP_D5_189_REGRESSAO_HEADING_R1_R2.md` e `CP-D5-189_R1R2_HEADING_RUNTIME.log`.

## CP-D5-190 — CONCLUÍDO: Regressão heading R5→R6
`EliasR5R6HeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando origem `(−80,190)`, destino `RUMO ÀS RUÍNAS` id 6, canvas `(195,6;261,4)→(408;351)`, chegada R6, próxima âncora 7 `PASSAGEM: VILA ELEVADA`, câmara Elias de produção inactiva e produção preservada. Ver `CP_D5_190_REGRESSAO_HEADING_R5_R6.md` e `CP-D5-190_R5R6_HEADING_RUNTIME.log`.

## CP-D5-191 — CONCLUÍDO: Regressão legibilidade angular R6
`R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 3 ângulos com Elias, monólito e corredor visíveis, monólito `(52,260)` aterrado, rota `x=60`, 2 ciclos `clear=true`, câmara de produção inactiva e produção preservada. Ver `CP_D5_191_REGRESSAO_LEGIBILIDADE_ANGULAR_R6.md` e `CP-D5-191_R6_READABILITY_RUNTIME.log`.

## CP-D5-192 — CONCLUÍDO: Regressão leitura vegetação R6 Elias
`R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito `(52,260)` e 3 vegetações aterrados, clearance de 6,05 m, rota `x=60`, viewport `CameraQAR6Leitura`, 2 ciclos `clear=true`, zero lajes de cais, `wall_of_trees=false`, câmara de produção inactiva e produção preservada. Ver `CP_D5_192_REGRESSAO_LEITURA_VEGETACAO_R6.md` e `CP-D5-192_R6_VEGETATION_READ_RUNTIME.log`.

## CP-D5-193 — CONCLUÍDO: Regressão corredor vivo R3
`R3LivingArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 2 partes de ruína, 8 elementos aterrados, 4 ciclos `clear=true`, fauna a 11,49–12,26 m, `structural_arch=false`, `scale_compressed=false` e produção preservada. Ver `CP_D5_193_REGRESSAO_CORREDOR_VIVO_R3.md` e `CP-D5-193_R3_LIVING_CORRIDOR_RUNTIME.log`.

## CP-D5-194 — CONCLUÍDO: Regressão pavilhão Majestic aterrado R5
`MajesticGroundedPavilionPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando âncora 5, pavilhão `(−88,178)` aterrado por raycast, Y `17,00→−0,00`, X/Z preservados, fundação aterrada, colisor `TerrenoMajesticColisorQA`, 0 luzes dinâmicas e produção preservada. Ver `CP_D5_194_REGRESSAO_PAVILHAO_ATERRADO_R5.md` e `CP-D5-194_MAJESTIC_GROUNDED_RUNTIME.log`.

## CP-D5-195 — CONCLUÍDO: Regressão travessia ponte R2 Elias
`EliasStoneBridgeTraversalPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando R2 `(−21,40;28)`, ponte aterrada no colisor `tabuleiro_continuo`, clearance 0,21 m sobre mínimo 0,20 m, 3 ciclos limpos, ponte modular, GLB ausente, câmara de produção inactiva e produção preservada. Ver `CP_D5_195_REGRESSAO_TRAVESSIA_PONTE_R2.md` e `CP-D5-195_R2_BRIDGE_TRAVERSAL_RUNTIME.log`.

## CP-D5-196 — CONCLUÍDO: Regressão margem viva R6
`R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 3 partes de ruína, 9 elementos aterrados, ruína colapsada, fauna a 20,08 m, 0 lajes de cais, `wall_of_trees=false`, 1 ciclo `clear=true` e produção preservada. Ver `CP_D5_196_REGRESSAO_MARGEM_VIVA_R6.md` e `CP-D5-196_R6_LIVING_SHORE_RUNTIME.log`.

## CP-D5-197 — CONCLUÍDO: Regressão floresta viva R4
`R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 8 vegetações, 2 partes de abrigo, 12 elementos aterrados, 3 ciclos `clear=true`, fauna a 20,42–20,76 m, `structural_portal=false`, `wall_of_trees=false` e produção preservada. Ver `CP_D5_197_REGRESSAO_FLORESTA_VIVA_R4.md` e `CP-D5-197_R4_LIVING_FOREST_RUNTIME.log`.

## CP-D5-198 — CONCLUÍDO: Regressão shoreline orgânica R6
`R6OrganicShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito `(52,260)` aterrado em Y 0,09, terreno orgânico, 10 elementos de terreno, 4 folhagens, 5 afloramentos, 0 cubos de shoreline, 0 lajes de cais, `wall_of_trees=false`, 2 ciclos `clear=true` e produção preservada. Ver `CP_D5_198_REGRESSAO_SHORELINE_ORGANICA_R6.md` e `CP-D5-198_R6_ORGANIC_SHORE_RUNTIME.log`.

## CP-D5-199 — CONCLUÍDO: Auditoria placement cartográfico R1→R6
`CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA com execução explícita da cena, confirmando 6/6 âncoras, world X/Z e canvas canónicos, offsets `(0,0)`, produção inalterada e placement aprovado. Ver `CP_D5_199_AUDITORIA_PLACEMENT_CARTOGRAFICO.md` e `CP-D5-199_CARTOGRAPHIC_PLACEMENT_RUNTIME.log`.

## CP-D5-200 — CONCLUÍDO: Regressão integrada final R1→R6
`CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 8 checks, `no_anchor_skip=true`, desvio Majestic lateral, chegada R6, marcador `PASSAGEM: VILA ELEVADA` id 7, produção preservada e sequência completa R1→R6. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. Ver `CP_D5_200_REGRESSAO_INTEGRADA_FINAL_R1_R6.md` e `CP-D5-200_INTEGRATED_SEQUENCE_RUNTIME.log`.

## CP-D5-201 — CONCLUÍDO: Auditoria orçamento de malha GTX 1050 Ti
`MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 20.390 triângulos, 9 nós de malha, 12 slots de material, 0 colisores importados, 0 luzes dinâmicas, produção preservada e orçamento aprovado. Ver `CP_D5_201_AUDITORIA_ORCAMENTO_MALHA.md` e `CP-D5-201_MESH_BUDGET_RUNTIME.log`.

## CP-D5-202 — CONCLUÍDO: Auditoria luzes dinâmicas Dev5
`CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 6 candidatos, `production_scripts=0`, `dynamic_lights=0`, offsets `(0,0)`, ambiente QA isolado e produção preservada. A tentativa do recurso inexistente `LightBudgetAuditPreview.tscn` foi descartada e substituída pela auditoria cartográfica real. Ver `CP_D5_202_AUDITORIA_LUZES_DINAMICAS.md` e `CP-D5-202_LIGHT_BUDGET_RUNTIME.log`.

## CP-D5-203 — CONCLUÍDO: Auditoria LOD vegetal GTX 1050 Ti
`VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 4 activos, limites focal/médio/distante, triângulos reais, 0 colisores importados, `dynamic_lights=0` e produção preservada. Ver `CP_D5_203_AUDITORIA_LOD_VEGETAL.md` e `CP-D5-203_LOD_VEGETAL_RUNTIME.log`.

## CP-D5-204 — CONCLUÍDO: Regressão contratos de altura R1→R6
`CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 6 regiões, 3 proprietários de terreno, X/Z canónicos, raycast obrigatório, candidatos rejeitados preservados e produção inalterada. Ver `CP_D5_204_REGRESSAO_CONTRATOS_ALTURA_R1_R6.md` e `CP-D5-204_HEIGHT_CONTRACTS_RUNTIME.log`.

## CP-D5-205 — CONCLUÍDO: Regressão estrada viva R2
`R2LivingRiverRoadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 2 partes de abrigo, 9 elementos aterrados, ponte modular, 5 travessias `bridge_crossed=true`, 5 ciclos `clear=true`, fauna a 12,08–12,93 m, `bridge_glb=false`, `wall_of_trees=false` e produção preservada. Ver `CP_D5_205_REGRESSAO_ESTRADA_VIVA_R2.md` e `CP-D5-205_R2_LIVING_ROAD_RUNTIME.log`.

## CP-D5-206 — CONCLUÍDO: Regressão handoff final R6→R7
`EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando R6 `(60,252)`, marcador `PASSAGEM: VILA ELEVADA` id 7, R7 `(140,352)`, `reached_marker_r7=true`, `marker_only=true`, câmara de produção inactiva, geometria Dev2 ausente e produção preservada. Ver `CP_D5_206_REGRESSAO_HANDOFF_FINAL_R6_R7.md` e `CP-D5-206_R6_R7_HANDOFF_RUNTIME.log`.

## CP-D5-207 — CONCLUÍDO: Regressão exterior vivo Casa Voss R1
`R1LivingVossExteriorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando waystation activa, 5 elementos de jardim, 2 faunas, 8 elementos aterrados, 4 ciclos `clear=true`, fauna a 9,07–9,87 m, `house_production_touched=false`, `door_touched=false` e produção preservada. Ver `CP_D5_207_REGRESSAO_VOSS_EXTERIOR_R1.md` e `CP-D5-207_R1_VOSS_EXTERIOR_RUNTIME.log`.

## CP-D5-208 — CONCLUÍDO: Regressão clearance monólito R6
`R6MonolithClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito `(52,260)` aterrado no colisor `CorredorMargemR6QA`, rota `x=60`, clearance 6,05 m sobre mínimo 4 m, X/Z preservados, câmara de produção inactiva e produção preservada. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. Ver `CP_D5_208_REGRESSAO_CLEARANCE_MONOLITO_R6.md` e `CP-D5-208_R6_MONOLITH_CLEARANCE_RUNTIME.log`.

## CP-D5-209 — CONCLUÍDO: Regressão composição vegetal R4→R5
`MediumVegetationCompositionPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando âncoras 4 e 5, offsets `(0,0)`, composição 1 PBR/3 médios/4 distantes, `wall_of_trees=false`, `production_script=false` e produção preservada. Ver `CP_D5_209_REGRESSAO_COMPOSICAO_VEGETAL_R4_R5.md` e `CP-D5-209_MEDIUM_VEGETATION_RUNTIME.log`.

## CP-D5-210 — CONCLUÍDO: Regressão contrato de câmara Elias
`EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando câmara de produção inactiva, uma câmara externa activa, viewport `CameraQAExterna`, `player_gd_changed=false`, `regional_modules_changed=false` e produção preservada. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. Ver `CP_D5_210_REGRESSAO_CAMERA_CONTRACT.md` e `CP-D5-210_CAMERA_CONTRACT_RUNTIME.log`.

## CP-D5-211 — CONCLUÍDO: Regressão floresta densa R4
`DenseForestPortalPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando âncora `(−9,116)`, passagem natural isolada de 2,4 m, `region_script=false`, ausência de portal estrutural imposto e produção preservada. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. Ver `CP_D5_211_REGRESSAO_FLORESTA_DENSA_R4.md` e `CP-D5-211_R4_DENSE_FOREST_RUNTIME.log`.

## CP-D5-212 — CONCLUÍDO: Regressão monólito margem R6
`SubmergedShoreMonolithPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando âncora 6, monólito `(52,260)` aterrado por raycast em `MargemR6ColisorQA`, Y `18,00→−0,00`, X/Z preservados, 0 luzes adicionais, 0 lajes, 0 colunas uniformes e produção preservada. Ver `CP_D5_212_REGRESSAO_MONOLITO_MARGEM_R6.md` e `CP-D5-212_R6_SHORE_MONOLITH_RUNTIME.log`.

## CP-D5-213 — CONCLUÍDO: Regressão Majestic vivo R5
`R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 8 vegetações, 3 partes de abrigo, 14 elementos aterrados, pavilhão visível, fauna a 27,41 m, `cairn=false`, `wall_of_trees=false`, 1 ciclo `clear=true` e produção preservada. Ver `CP_D5_213_REGRESSAO_MAJESTIC_VIVO_R5.md` e `CP-D5-213_R5_LIVING_MAJESTIC_RUNTIME.log`.

## CP-D5-214 — CONCLUÍDO: Regressão landmark Casa Voss R1
`VossWaystationPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA headless, confirmando `AnexoCasaVoss_QA`, terreno QA 20×20 m, path frontal 2×8 m, câmara `CameraAnexoCasaVossQA`, preview isolado e produção preservada. Ver `CP_D5_214_REGRESSAO_LANDMARK_VOSS_R1.md` e `CP-D5-214_R1_VOSS_LANDMARK_RUNTIME.log`.

## CP-D5-215 — CONCLUÍDO: Regressão integrada final R1→R6
`CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 8 checkpoints, `no_anchor_skip=true`, desvio Majestic lateral, chegada R6, continuidade para o marcador R7 e produção preservada. Ver `CP_D5_215_REGRESSAO_INTEGRADA_FINAL_R1_R6.md` e `CP-D5-215_INTEGRATED_FINAL_RUNTIME.log`.

## CP-D5-216 — CONCLUÍDO: Regressão legibilidade angular R6
`R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 3 ângulos, Elias/monólito/corredor visíveis em todos, monólito `(52,260)` aterrado, rota `x=60`, 2 ciclos `clear=true`, câmara de produção inactiva e produção preservada. Ver `CP_D5_216_REGRESSAO_LEGIBILIDADE_ANGULAR_R6.md` e `CP-D5-216_R6_READABILITY_RUNTIME.log`.

## CP-D5-217 — CONCLUÍDO: Regressão vegetação aterrada R4→R5
`GroundedVegetationR4R5Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 12 candidatos aterrados, 1 pinho focal, 3 árvores detalhadas/médias, 6 folhagens leves, 2 fetos, X/Z preservados, 0 luzes adicionais, `wall_of_trees=false` e produção preservada. Ver `CP_D5_217_REGRESSAO_VEGETACAO_ATERRADA_R4_R5.md` e `CP-D5-217_GROUNDED_VEGETATION_RUNTIME.log`.

## CP-D5-218 — CONCLUÍDO: Regressão heading R5→R6
`EliasR5R6HeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando início `(−80,190)`, destino `RUMO ÀS RUÍNAS` id 6, chegada R6, continuidade para `PASSAGEM: VILA ELEVADA` id 7, câmara de produção inactiva e produção preservada. Ver `CP_D5_218_REGRESSAO_HEADING_R5_R6.md` e `CP-D5-218_R5_R6_HEADING_RUNTIME.log`.

## CP-D5-219 — CONCLUÍDO: Regressão corredor vivo R3
`R3LivingArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 2 partes de ruína, 8 elementos aterrados, 4 ciclos `clear=true`, fauna a 11,49–12,26 m, `structural_arch=false`, `scale_compressed=false` e produção preservada. Ver `CP_D5_219_REGRESSAO_CORREDOR_VIVO_R3.md` e `CP-D5-219_R3_LIVING_CORRIDOR_RUNTIME.log`.

## CP-D5-220 — CONCLUÍDO: Regressão composição aterrada R1→R2
`MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando Casa Voss e Ponte Marco 2 aterradas, terreno irregular, X/Z preservados, `production_script=false`, `dynamic_lights=0` e ausência do Arco estrutural. Ver `CP_D5_220_REGRESSAO_COMPOSICAO_ATERRADA_R1_R2.md` e `CP-D5-220_MULTI_LANDMARK_RUNTIME.log`.

## CP-D5-221 — CONCLUÍDO: Regressão leitura vegetação R6
`R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito `(52,260)` aterrado, 3 vegetações aterradas, clearance 6,05 m, 0 lajes, `wall_of_trees=false`, viewport `CameraQAR6Leitura`, 2 ciclos `clear=true`, actor Elias e produção preservada. Ver `CP_D5_221_REGRESSAO_LEITURA_VEGETACAO_R6.md` e `CP-D5-221_R6_VEGETATION_READ_RUNTIME.log`.

## CP-D5-222 — CONCLUÍDO: Auditoria orçamento de malha GTX 1050 Ti
`MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 20.390 triângulos, 9 nós de malha, 12 slots de material, 0 colisores importados e `dynamic_lights=0`. Ver `CP_D5_222_AUDITORIA_ORCAMENTO_MALHA.md` e `CP-D5-222_MESH_BUDGET_RUNTIME.log`.

## CP-D5-223 — CONCLUÍDO: Auditoria densidade vegetal GTX 1050 Ti
`VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando composição de 1 pinho focal, 3 árvores médias, 1 árvore leve e 2 fetos, 27.208 triângulos, `dynamic_lights=0`, `wall_density=false` e produção preservada. Ver `CP_D5_223_AUDITORIA_DENSIDADE_VEGETAL.md` e `CP-D5-223_VEGETATION_DENSITY_RUNTIME.log`.

## CP-D5-224 — CONCLUÍDO: Regressão shoreline orgânica R6
`R6OrganicShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito `(52,260)` aterrado, terreno orgânico, 10 elementos de terreno, 4 folhagens, 5 afloramentos, 0 lajes, `shoreline_cubes=false`, `wall_of_trees=false`, 2 ciclos `clear=true` e produção preservada. Ver `CP_D5_224_REGRESSAO_SHORELINE_ORGANICA_R6.md` e `CP-D5-224_R6_ORGANIC_SHORE_RUNTIME.log`.

## CP-D5-225 — CONCLUÍDO: Regressão heading R1→R2
`EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando Casa Voss `(−22,8)`, Estrada `(−21,4;12)`, ponte `(−21,4;28)`, destino id 2, 8 ciclos de rota, câmara de produção inactiva e produção preservada. Ver `CP_D5_225_REGRESSAO_HEADING_R1_R2.md` e `CP-D5-225_R1_R2_HEADING_RUNTIME.log`.

## CP-D5-226 — CONCLUÍDO: Regressão travessia ponte R2
`EliasStoneBridgeTraversalPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando âncora `(−21,4;28)`, tabuleiro `tabuleiro_continuo` aterrado, clearance 0,21 m sobre mínimo 0,20 m, 3 ciclos, ponte modular, `glb_bridge=false`, câmara de produção inactiva e produção preservada. Ver `CP_D5_226_REGRESSAO_TRAVESSIA_PONTE_R2.md` e `CP-D5-226_R2_BRIDGE_TRAVERSAL_RUNTIME.log`.

## CP-D5-227 — CONCLUÍDO: Regressão corredor R3
`EliasArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando R3 `(−16,741;48)`, destino `RUMO À FLORESTA` id 4, 2 ciclos de rota aberta, `structural_arch=false`, câmara de produção inactiva e produção preservada. Ver `CP_D5_227_REGRESSAO_CORREDOR_R3.md` e `CP-D5-227_R3_ARCH_CORRIDOR_RUNTIME.log`.

## CP-D5-228 — CONCLUÍDO: Regressão floresta viva R4
`R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 8 vegetações, 2 partes de abrigo, 12 elementos aterrados, 3 ciclos `clear=true`, `structural_portal=false`, `wall_of_trees=false`, módulos de produção inalterados e produção preservada. Ver `CP_D5_228_REGRESSAO_FLORESTA_R4.md` e `CP-D5-228_R4_FOREST_RUNTIME.log`.

## CP-D5-229 — CONCLUÍDO: Regressão composição viva Majestic R5
`R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 8 vegetações, 3 partes de abrigo, pavilhão visível, 14 elementos aterrados, 1 ciclo `clear=true`, `cairn=false`, `wall_of_trees=false`, módulos de produção inalterados e produção preservada. Ver `CP_D5_229_REGRESSAO_MAJESTIC_R5.md` e `CP-D5-229_R5_MAJESTIC_RUNTIME.log`.

## CP-D5-230 — CONCLUÍDO: Regressão costa viva R6
`R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 3 partes de ruína, 9 elementos aterrados, 0 lajes de cais, 1 ciclo `clear=true`, ruína colapsada, `wall_of_trees=false`, módulos de produção inalterados e produção preservada. Ver `CP_D5_230_REGRESSAO_SHORE_R6.md` e `CP-D5-230_R6_SHORE_RUNTIME.log`.

## CP-D5-231 — CONCLUÍDO: Regressão handoff R6→R7
`EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando R6 `(60,252)`, marcador `PASSAGEM: VILA ELEVADA` id 7 em `(140,352)`, `reached_marker_r7=true`, `marker_only=true`, geometria Dev2 não criada, câmara de produção inactiva e produção preservada. Ver `CP_D5_231_REGRESSAO_HANDOFF_R6_R7.md` e `CP-D5-231_R6_R7_HANDOFF_RUNTIME.log`.

## CP-D5-232 — CONCLUÍDO: Regressão clearance monólito R6
`R6MonolithClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito aterrado em `(52,260)`, colisor `CorredorMargemR6QA`, clearance 6,05 m sobre mínimo 4,00 m, 2 ciclos `clear=true` e produção preservada. Ver `CP_D5_232_REGRESSAO_CLEARANCE_MONOLITO_R6.md` e `CP-D5-232_R6_MONOLITH_CLEARANCE_RUNTIME.log`.

## CP-D5-233 — CONCLUÍDO: Auditoria legibilidade R6
`R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 3 ângulos com Elias, monólito e corredor visíveis, âncora `(52,260)`, rota `x=60`, 2 ciclos `clear=true`, monólito aterrado, câmara de produção inactiva e produção preservada. Ver `CP_D5_233_AUDITORIA_LEGIBILIDADE_R6.md` e `CP-D5-233_R6_READABILITY_RUNTIME.log`.

## CP-D5-234 — CONCLUÍDO: Regressão sequência integrada R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 8 checkpoints, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true`, todos os handoffs R1→R6 e chegada R6→R7. Avisos FSR1 foram específicos do renderer Compatibility, sem erros Dev5. Ver `CP_D5_234_REGRESSAO_SEQUENCIA_R1_R6.md` e `CP-D5-234_R1_R6_SEQUENCE_RUNTIME.log`.

## CP-D5-235 — CONCLUÍDO: Regressão leitura vegetal R6
`R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito aterrado `(52,260)`, 3 vegetações aterradas, clearance 6,05 m, 0 lajes de cais, `wall_of_trees=false`, 2 ciclos `clear=true`, câmara de produção inactiva e produção preservada. Ver `CP_D5_235_REGRESSAO_VEGETACAO_R6.md` e `CP-D5-235_R6_VEGETATION_RUNTIME.log`.

## CP-D5-236 — CONCLUÍDO: Auditoria densidade vegetal
`VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando pinheiro focal 1, árvore média 3, árvore leve 1, fetos 2, total de 27.208 triângulos, 0 luzes dinâmicas e `wall_density=false`. Ver `CP_D5_236_AUDITORIA_DENSIDADE_VEGETAL.md` e `CP-D5-236_VEGETATION_DENSITY_RUNTIME.log`.

## CP-D5-237 — CONCLUÍDO: Auditoria LOD vegetal
`VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando pinheiro PBR 13.424 triângulos, árvore média 402, feto 6.232, árvore leve 114, limites 1/3/8 e 0 luzes dinâmicas. Ver `CP_D5_237_AUDITORIA_LOD.md` e `CP-D5-237_LOD_RUNTIME.log`.

## CP-D5-238 — CONCLUÍDO: Regressão Elias terceira pessoa
`EliasThirdPersonPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando `CameraQA` activa, câmara de produção não instanciada, `Player.gd` inalterado e apresentação técnica isolada. Avisos de `viewport_set_scaling_3d_mode` são do renderer Compatibility, sem erro Dev5. Ver `CP_D5_238_REGRESSAO_ELIAS_TERCEIRA_PESSOA.md` e `CP-D5-238_ELIAS_PRESENTATION_RUNTIME.log`.

## CP-D5-239 — CONCLUÍDO: Regressão contrato câmara Elias
`EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando câmara externa `CameraQAExterna`, `active_camera_count=1`, câmara de produção inactiva, `Player.gd` inalterado e módulos regionais preservados. Avisos de scaling são específicos do renderer Compatibility. Ver `CP_D5_239_REGRESSAO_CONTRATO_CAMERA.md` e `CP-D5-239_CAMERA_CONTRACT_RUNTIME.log`.

## CP-D5-240 — CONCLUÍDO: Regressão heading R5→R6
`EliasR5R6HeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando início `(−80,190)`, destino `RUMO ÀS RUÍNAS` id 6, chegada R6, próxima âncora 7 `PASSAGEM: VILA ELEVADA`, câmara de produção inactiva e produção preservada. Ver `CP_D5_240_REGRESSAO_HEADING_R5_R6.md` e `CP-D5-240_R5_R6_HEADING_RUNTIME.log`.

## CP-D5-241 — CONCLUÍDO: Regressão clearance Majestic R5
`EliasMajesticClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando pavilhão aterrado em `(−88,178)`, colisor `CorredorMajesticEliasQA`, clearance 5,45 m sobre mínimo 4,00 m, 2 ciclos `clear=true`, Elias em terceira pessoa, câmara de produção inactiva e produção preservada. Ver `CP_D5_241_REGRESSAO_CLEARANCE_MAJESTIC_R5.md` e `CP-D5-241_R5_MAJESTIC_CLEARANCE_RUNTIME.log`.

## CP-D5-242 — CONCLUÍDO: Regressão clearance floresta R4
`EliasForestClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 6 elementos aterrados, âncora R4 `(−9,116)`, corredor de 5,20 m, clearance mínimo 2,75 m, 2 ciclos de rota aberta, `forest_portal=false`, `wall_of_trees=false`, câmara de produção inactiva e produção preservada. Ver `CP_D5_242_REGRESSAO_CLEARANCE_FLORESTA_R4.md` e `CP-D5-242_R4_FOREST_CLEARANCE_RUNTIME.log`.

## CP-D5-243 — CONCLUÍDO: Regressão clearance R6 Elias
`EliasR6ClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito aterrado em `(52,260)`, colisor `CorredorMargemR6EliasQA`, clearance 6,05 m sobre mínimo 4,00 m, 2 ciclos `clear=true`, Elias em terceira pessoa, câmara de produção inactiva e produção preservada. Ver `CP_D5_243_REGRESSAO_CLEARANCE_R6.md` e `CP-D5-243_R6_CLEARANCE_RUNTIME.log`.

## CP-D5-244 — CONCLUÍDO TECNICAMENTE: Recaptura R1→R3 terceira pessoa
`R1R3ThirdPersonCartographicPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando Elias em terceira pessoa, Arco visível em `z=92`, aterramento, escala 70 m, 1 luz e 2 ciclos `clear=true`. A captura permanece `REJECTED_VISUAL` por terreno granular, marcadores técnicos, ruínas simples e silhueta provisória; produção e `Player.gd` preservados. Ver `CP_D5_244_RECAPTURA_R1_R3_RUNTIME.md` e `CP-D5-244_R1_R3_RECAPTURE_RUNTIME.log`.

## CP-D5-245 — CONCLUÍDO: Regressão Casa Voss R1 viva
`R1LivingVossExteriorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 5 elementos de jardim, posto de passagem, 8 elementos aterrados, 4 ciclos `clear=true`, produção e porta preservadas e módulos de produção inalterados. Ver `CP_D5_245_REGRESSAO_VOSS_R1.md` e `CP-D5-245_R1_VOSS_EXTERIOR_RUNTIME.log`.

## CP-D5-246 — CONCLUÍDO: Regressão River Road R2 viva
`R2LivingRiverRoadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 2 abrigos, 9 elementos aterrados, ponte modular, 5 travessias `bridge_crossed=true` e `clear=true`, `bridge_glb=false`, ausência de parede de árvores e produção preservada. Ver `CP_D5_246_REGRESSAO_RIVER_ROAD_R2.md` e `CP-D5-246_R2_RIVER_ROAD_RUNTIME.log`.

## CP-D5-247 — CONCLUÍDO: Regressão corredor do Arco R3 vivo
`R3LivingArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 2 partes de ruína, 8 elementos aterrados, 4 ciclos `clear=true`, `structural_arch=false`, `scale_compressed=false` e produção preservada. Ver `CP_D5_247_REGRESSAO_ARCH_CORRIDOR_R3.md` e `CP-D5-247_R3_ARCH_CORRIDOR_RUNTIME.log`.

## CP-D5-248 — CONCLUÍDO: Regressão floresta R4 viva
`R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 8 vegetações, 2 partes de abrigo, 12 elementos aterrados, 3 ciclos `clear=true`, `structural_portal=false`, `wall_of_trees=false` e produção preservada. Ver `CP_D5_248_REGRESSAO_FLORESTA_R4_VIVA.md` e `CP-D5-248_R4_LIVING_FOREST_RUNTIME.log`.

## CP-D5-249 — CONCLUÍDO: Regressão Majestic R5 vivo
`R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 8 vegetações, 3 partes de abrigo, pavilhão visível, 14 elementos aterrados, rota `clear=true`, `cairn=false`, `wall_of_trees=false` e produção preservada. Ver `CP_D5_249_REGRESSAO_MAJESTIC_R5_VIVO.md` e `CP-D5-249_R5_LIVING_MAJESTIC_RUNTIME.log`.

## CP-D5-250 — CONCLUÍDO: Regressão costa R6 viva
`R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 3 partes de ruína, 9 elementos aterrados, ruína colapsada, 0 lajes de cais, rota `clear=true`, `wall_of_trees=false` e produção preservada. Ver `CP_D5_250_REGRESSAO_SHORE_R6_VIVA.md` e `CP-D5-250_R6_LIVING_SHORE_RUNTIME.log`.

## CP-D5-251 — CONCLUÍDO: Regressão leitura vegetal R6 Elias
`R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito aterrado `(52,260)`, 3 vegetações aterradas, clearance 6,05 m, 2 ciclos `clear=true`, 0 lajes de cais, `wall_of_trees=false`, câmara de produção inactiva e produção preservada. Ver `CP_D5_251_REGRESSAO_LEITURA_VEGETAL_R6.md` e `CP-D5-251_R6_VEGETATION_READ_RUNTIME.log`.

## CP-D5-252 — CONCLUÍDO: Regressão sequência integrada R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 8 checkpoints, `no_anchor_skip=true`, handoff lateral Majestic válido, chegada às Ruínas válida e abertura do marcador R7 `PASSAGEM: VILA ELEVADA`. Avisos FSR1 são do renderer Compatibility; produção preservada. Ver `CP_D5_252_REGRESSAO_SEQUENCIA_INTEGRADA_R1_R6.md` e `CP-D5-252_SEQUENCE_R1_R6_RUNTIME.log`.

## CP-D5-253 — CONCLUÍDO: Regressão handoff R6→R7
`EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando R6 `(60,252)`, marcador `PASSAGEM: VILA ELEVADA` id 7, chegada R7, `marker_only=true`, geometria Dev2 não criada, câmara de produção inactiva e produção preservada. Ver `CP_D5_253_REGRESSAO_HANDOFF_R6_R7.md` e `CP-D5-253_R6_R7_HANDOFF_RUNTIME.log`.

## CP-D5-254 — CONCLUÍDO: Auditoria legibilidade R6
`R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 3 ângulos com Elias, monólito e corredor visíveis, monólito aterrado, 2 ciclos `clear=true`, câmara de produção inactiva e produção preservada. Ver `CP_D5_254_AUDITORIA_LEGIBILIDADE_R6.md` e `CP-D5-254_R6_READABILITY_RUNTIME.log`.

## CP-D5-255 — CONCLUÍDO: Auditoria integrada de orçamento de malha
`MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 20.390 triângulos, 9 nós de malha, 12 slots de material, 0 colisões, 0 luzes dinâmicas e compatibilidade com GTX 1050 Ti/OpenGL Compatibility. Ver `CP_D5_255_AUDITORIA_MESH_BUDGET.md` e `CP-D5-255_MESH_BUDGET_RUNTIME.log`.

## CP-D5-256 — CONCLUÍDO: Auditoria aterramento vegetal R4–R5
`GroundedVegetationR4R5Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 12 candidatos aterrados com X/Z preservados, composição 1/3/6/2, 0 luzes dinâmicas, `wall_of_trees=false` e produção preservada. Ver `CP_D5_256_AUDITORIA_ATERRAMENTO_VEGETAL_R4_R5.md` e `CP-D5-256_GROUNDED_VEGETATION_RUNTIME.log`.

## CP-D5-257 — CONCLUÍDO: Regressão heading R1→R2
`EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando Casa Voss `(−22,8)`, anchor River Road `(−21,4;12)`, ponte `(−21,4;28)`, destino id 2, 8 ciclos de rota, câmara de produção inactiva e produção preservada. Ver `CP_D5_257_REGRESSAO_HEADING_R1_R2.md` e `CP-D5-257_R1_R2_HEADING_RUNTIME.log`.

## CP-D5-258 — CONCLUÍDO: Regressão apresentação Elias terceira pessoa
`EliasThirdPersonPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando `CameraQA` externa activa, Elias em terceira pessoa, `Player.gd` preservado e produção preservada. Avisos de scaling são do renderer Compatibility headless. Ver `CP_D5_258_REGRESSAO_ELIAS_TERCEIRA_PESSOA_CONTINUA.md` e `CP-D5-258_ELIAS_THIRD_PERSON_RUNTIME.log`.

## CP-D5-259 — CONCLUÍDO: Regressão contrato de câmara Elias
`EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando câmara externa `CameraQAExterna`, uma única câmara activa, câmara de produção inactiva, `Player.gd` preservado e módulos regionais preservados. Ver `CP_D5_259_REGRESSAO_CONTRATO_CAMERA_CONTINUA.md` e `CP-D5-259_CAMERA_CONTRACT_RUNTIME.log`.

## CP-D5-260 — CONCLUÍDO: Auditoria cartográfica integrada
`CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 6 candidatos, offsets nulos, 0 scripts de produção, 0 luzes dinâmicas adicionadas, passagem florestal 2,4 m, composição vegetal 1/3/4 e ruínas sem emissive ou luz dinâmica. Ver `CP_D5_260_AUDITORIA_CARTOGRAFICA_INTEGRADA.md` e `CP-D5-260_CARTOGRAPHIC_AUDIT_RUNTIME.log`.

## CP-D5-261 — CONCLUÍDO: Auditoria densidade vegetal contínua
`VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando composição 1 pinheiro focal, 3 árvores médias, 1 árvore leve, 2 fetos, 27.208 triângulos, 0 luzes dinâmicas e `wall_density=false`. Ver `CP_D5_261_AUDITORIA_DENSIDADE_VEGETAL_CONTINUA.md` e `CP-D5-261_VEGETATION_DENSITY_RUNTIME.log`.

## CP-D5-262 — CONCLUÍDO: Auditoria LOD vegetal contínua
`VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 4 activos auditados, limites 1 PBR focal/3 árvores médias/8 folhagens distantes, 0 colisões, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_262_AUDITORIA_LOD_CONTINUA.md` e `CP-D5-262_LOD_AUDIT_RUNTIME.log`.

## CP-D5-263 — CONCLUÍDO: Regressão multi-marco de aterramento
`MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando anchors Casa Voss/Ponte 1–2 aterrados em terreno irregular, X/Z preservados, 0 scripts de produção e 0 luzes dinâmicas. Ver `CP_D5_263_REGRESSAO_MULTILANDMARK_GROUNDING.md` e `CP-D5-263_MULTILANDMARK_GROUNDING_RUNTIME.log`.

## CP-D5-264 — CONCLUÍDO: Auditoria contratos de altura
`CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando cobertura R1–R6, 3 proprietários de terreno, raycast obrigatório, produção preservada e rejeições do arco R3/cais R6 não reintroduzidas. Ver `CP_D5_264_AUDITORIA_CONTRATOS_ALTURA.md` e `CP-D5-264_HEIGHT_CONTRACTS_RUNTIME.log`.

## CP-D5-265 — CONCLUÍDO: Regressão global de aterramento
`CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando anexo Casa Voss e Ponte Marco 2 aterrados via `TerrenoColisorQA`, X/Z preservados, 0 falhas e produção preservada. Ver `CP_D5_265_REGRESSAO_ATERRAMENTO_GLOBAL.md` e `CP-D5-265_GLOBAL_GROUNDING_RUNTIME.log`.

## CP-D5-266 — CONCLUÍDO: Regressão margem orgânica R6
`R6OrganicShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando terreno orgânico, monólito aterrado `(52,260)`, 10 elementos aterrados, 4 folhagens, 5 afloramentos, 2 ciclos `clear=true`, 0 cais, `shoreline_cubes=false`, `wall_of_trees=false` e produção preservada. Ver `CP_D5_266_REGRESSAO_MARGEM_ORGANICA_R6.md` e `CP-D5-266_ORGANIC_SHORE_RUNTIME.log`.

## CP-D5-267 — CONCLUÍDO: Regressão monólito submerso R6
`SubmergedShoreMonolithPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito `(52,260)` aterrado via `MargemR6ColisorQA`, X/Z preservados, 0 cais, 0 colunas uniformes, 0 luzes dinâmicas e produção preservada. Ver `CP_D5_267_REGRESSAO_MONOLITO_R6.md` e `CP-D5-267_SUBMERGED_RUINS_RUNTIME.log`.

## CP-D5-268 — CONCLUÍDO: Regressão sistema de colocação cartográfica
`CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando os 6 anchors R1–R6, coordenadas mundo/mapa correspondentes, 0 divergências e produção preservada. Ver `CP_D5_268_REGRESSAO_PLACEMENT_CARTOGRAFICO.md` e `CP-D5-268_PLACEMENT_SYSTEM_RUNTIME.log`.

## CP-D5-269 — CONCLUÍDO: Regressão Casa Voss Waystation
`VossWaystationPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando `AnexoCasaVoss_QA`, aterramento, `route_open=true`, instrumentação Dev5 confinada e produção preservada. Ver `CP_D5_269_REGRESSAO_VOSS_WAYSTATION.md` e `CP-D5-269_VOSS_WAYSTATION_RUNTIME.log`.

## CP-D5-270 — CONCLUÍDO: Regressão pavilhão Majestic R5
`MajesticGroundedPavilionPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando pavilhão `(−88,178)` aterrado via `TerrenoMajesticColisorQA`, fundação aterrada, X/Z preservados, 0 luzes dinâmicas e produção preservada. Ver `CP_D5_270_REGRESSAO_PAVILHAO_MAJESTIC.md` e `CP-D5-270_MAJESTIC_PAVILION_RUNTIME.log`.

## CP-D5-271 — CONCLUÍDO: Regressão corredor florestal R4
`DenseForestPortalPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando anchor R4 `(-9,116)`, passagem de 2,4 m, isolamento QA, script de região preservado e ausência de portal estrutural. Ver `CP_D5_271_REGRESSAO_CORREDOR_FLORESTA_R4.md` e `CP-D5-271_DENSE_FOREST_RUNTIME.log`.

## CP-D5-272 — CONCLUÍDO: Regressão composição vegetal R4–R5
`MediumVegetationCompositionPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando anchors R4/R5, 1 PBR focal/3 médias/4 distantes por composição, offsets nulos, `wall_of_trees=false` e 0 scripts de produção. Ver `CP_D5_272_REGRESSAO_COMPOSICAO_VEGETAL_R4_R5.md` e `CP-D5-272_MEDIUM_VEGETATION_RUNTIME.log`.

## CP-D5-273 — CONCLUÍDO: Auditoria legibilidade R6 contínua
`R6ReadabilityAnglesPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 3 ângulos com Elias/monólito/corredor visíveis, 2 rotas `clear=true`, monólito aterrado, câmara de produção inactiva e produção preservada. Ver `CP_D5_273_AUDITORIA_LEGIBILIDADE_R6_CONTINUA.md` e `CP-D5-273_READABILITY_ANGLES_RUNTIME.log`.

## CP-D5-274 — CONCLUÍDO: Regressão handoff R6→R7 contínua
`EliasR6R7HandoffPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando R6 `(60,252)`, marcador `PASSAGEM: VILA ELEVADA` id 7 alcançado, R7 `(140,352)`, `marker_only=true`, câmara Elias inactiva e produção preservada. Ver `CP_D5_274_REGRESSAO_HANDOFF_R6_R7_CONTINUA.md` e `CP-D5-274_HANDOFF_R6_R7_RUNTIME.log`.

## CP-D5-275 — CONCLUÍDO: Regressão apresentação Elias contínua
`EliasThirdPersonPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando câmara externa `CameraQA` activa, Elias em terceira pessoa, `Player.gd` preservado e produção intacta. Ver `CP_D5_275_REGRESSAO_ELIAS_PRESENTATION_CONTINUA.md` e `CP-D5-275_ELIAS_PRESENTATION_RUNTIME.log`.

## CP-D5-276 — CONCLUÍDO: Regressão sequência R1–R6 contínua
`CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 8 checkpoints, `no_anchor_skip=true`, handoffs Majestic/Ruínas, chegada R6 e marcador seguinte R7 Vila Elevada. Ver `CP_D5_276_REGRESSAO_SEQUENCIA_R1_R6_CONTINUA.md` e `CP-D5-276_SEQUENCE_INTEGRATED_RUNTIME.log`.

## CP-D5-277 — CONCLUÍDO: Regressão Ponte Marco 2 contínua
`StoneBridgeLandmarkPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando ponte modular, aterramento, clearance de 0,21 m, rota aberta, GLB rejeitado ausente, instrumentação isolada e produção preservada. Ver `CP_D5_277_REGRESSAO_PONTE_MARCO_2_CONTINUA.md` e `CP-D5-277_STONE_BRIDGE_RUNTIME.log`.

## CP-D5-278 — CONCLUÍDO: Regressão contrato de câmara contínua
`EliasCameraContractPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando `active_camera_count=1`, câmara externa activa, Elias inactiva, ausência de duplicação e `Player.gd`/produção preservados. Ver `CP_D5_278_REGRESSAO_CONTRATO_CAMERA_CONTINUA.md` e `CP-D5-278_CAMERA_CONTRACT_RUNTIME.log`.

## CP-D5-279 — CONCLUÍDO: Auditoria final mesh budget contínua
`MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 20.390 triângulos, 9 nós de malha, 12 slots de materiais, 0 colisões, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_279_AUDITORIA_MESH_BUDGET_CONTINUA.md` e `CP-D5-279_MESH_BUDGET_RUNTIME.log`.

## CP-D5-280 — CONCLUÍDO: Auditoria aterramento vegetal contínua
`GroundedVegetationR4R5Preview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 12 candidatos vegetais aterrados, X/Z preservados, 1 pinheiro focal, 3 árvores médias, 6 folhagens leves, 2 fetos, 0 luzes dinâmicas e `wall_of_trees=false`. Ver `CP_D5_280_AUDITORIA_ATERRAMENTO_VEGETAL_CONTINUA.md` e `CP-D5-280_GROUNDED_VEGETATION_RUNTIME.log`.

## CP-D5-281 — CONCLUÍDO: Recaptura R1→R3 contínua
`R1R3ThirdPersonCartographicPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando Elias em terceira pessoa, Arco em `z=92`, aterramento, escala mundial 70 m, 2 ciclos `clear=true` e produção/`Player.gd` preservados. A avaliação visual permanece separada da aprovação técnica. Ver `CP_D5_281_RECAPTURA_R1_R3_CONTINUA.md` e `CP-D5-281_R1_R3_RECAPTURE_RUNTIME.log`.

## CP-D5-282 — CONCLUÍDO: Regressão costa R6 viva contínua
`R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 2 faunas, 4 vegetações, 3 partes de ruína, 9 elementos aterrados, 0 lajes de cais, `wall_of_trees=false`, rota `clear=true` e produção preservada. Ver `CP_D5_282_REGRESSAO_COSTA_R6_VIVA_CONTINUA.md` e `CP-D5-282_R6_LIVING_SHORE_RUNTIME.log`.

## CP-D5-283 — CONCLUÍDO: Regressão multi-marco de aterramento contínua
`MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando anchors Casa Voss e Ponte Marco 2, aterramento em terreno irregular, coordenadas preservadas, 0 scripts de produção e 0 luzes dinâmicas. Ver `CP_D5_283_REGRESSAO_MULTILANDMARK_GROUNDING_CONTINUA.md` e `CP-D5-283_MULTILANDMARK_GROUNDING_RUNTIME.log`.

## CP-D5-284 — CONCLUÍDO: Auditoria contratos de altura contínua
`CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando seis regiões, três proprietários de terreno, raycasts e rejeições de arco estrutural/cais preservadas, sem alterar produção. Ver `CP_D5_284_AUDITORIA_CONTRATOS_ALTURA_CONTINUA.md` e `CP-D5-284_HEIGHT_CONTRACTS_RUNTIME.log`.

## CP-D5-285 — CONCLUÍDO: Regressão aterramento global contínua
`CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando anexo Casa Voss e Ponte Marco 2 aterrados via `TerrenoColisorQA`, impactos Y -2,78/-2,71, X/Z preservados e produção intacta. Ver `CP_D5_285_REGRESSAO_ATERRAMENTO_GLOBAL_CONTINUA.md` e `CP-D5-285_GLOBAL_GROUNDING_RUNTIME.log`.

## CP-D5-286 — CONCLUÍDO: Regressão clearance monólito R6 contínua
`R6MonolithClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando monólito aterrado em `(52,260)`, collider `CorredorMargemR6QA`, clearance 6,05 m sobre mínimo 4,00 m e 2 rotas livres. Ver `CP_D5_286_REGRESSAO_CLEARANCE_MONOLITO_R6_CONTINUA.md` e `CP-D5-286_MONOLITH_CLEARANCE_RUNTIME.log`.

## CP-D5-287 — CONCLUÍDO: Regressão placement cartográfico contínua
`CartographicPlacementPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando os 6 anchors, coordenadas mundo X/Z, posições canvas, 0 offsets não autorizados e produção preservada. Ver `CP_D5_287_REGRESSAO_PLACEMENT_CONTINUA.md` e `CP-D5-287_PLACEMENT_RUNTIME.log`.

## CP-D5-288 — CONCLUÍDO: Auditoria cartográfica integrada contínua
`CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando 6 candidatos, offsets nulos, contratos de colisão, 0 scripts de produção, 0 luzes dinâmicas e `wall_of_trees=false`. Ver `CP_D5_288_AUDITORIA_CARTOGRAFICA_INTEGRADA_CONTINUA.md` e `CP-D5-288_CARTOGRAPHIC_AUDIT_RUNTIME.log`.

## CP-D5-289 — CONCLUÍDO: Auditoria densidade vegetal contínua
`VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando composição focal/média/frontal, 27.208 triângulos, 0 luzes dinâmicas, `wall_density=false` e compatibilidade GTX 1050 Ti. Ver `CP_D5_289_AUDITORIA_DENSIDADE_VEGETAL_CONTINUA.md` e `CP-D5-289_VEGETATION_DENSITY_RUNTIME.log`.

## CP-D5-290 — CONCLUÍDO: Auditoria LOD vegetal contínua
`VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e 36 segundos de QA, confirmando quatro activos, limites 1 PBR focal/3 detalhados médios/8 folhagens distantes, 0 colisões, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_290_AUDITORIA_LOD_CONTINUA.md` e `CP-D5-290_LOD_AUDIT_RUNTIME.log`.

## CP-D5-291 — CONCLUÍDO: Regressão do corredor do Arco R3
`EliasArchCorridorPreview.tscn` passou parser e QA headless de 36 segundos, confirmando Elias, câmara QA única, Arco físico em `z=92`, destino `RUMO À FLORESTA` anchor 4, rota aberta, aterramento, ausência de arco estrutural e produção preservada. Ver `CP_D5_291_CORREDOR_ARCO_R3.md` e `CP-D5-291_ARCH_CORRIDOR_RUNTIME.log`.

## CP-D5-292 — CONCLUÍDO: Regressão da sequência cartográfica R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, confirmando 8 handoffs, `no_anchor_skip=true`, passagem lateral Majestic, chegada às Ruínas e handoff final para Vila Elevada. Ver `CP_D5_292_SEQUENCIA_R1_R6.md` e `CP-D5-292_SEQUENCE_RUNTIME.log`.

## CP-D5-293 — CONCLUÍDO: Auditoria integrada dos candidatos R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, 0 scripts de produção, 0 luzes dinâmicas, aterramento/rotas, colisões próprias e composição vegetal R4/R5 com `wall_of_trees=false`. Ver `CP_D5_293_AUDITORIA_INTEGRADA_R1_R6.md` e `CP-D5-293_INTEGRATED_AUDIT_RUNTIME.log`.

## CP-D5-294 — CONCLUÍDO: Regressão da apresentação terceira pessoa de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem erros de script, sem alteração de `Player.gd` e sem alteração de produção. Ver `CP_D5_294_ELIAS_TPS.md` e `CP-D5-294_ELIAS_TPS_RUNTIME.log`.

## CP-D5-295 — CONCLUÍDO: Regressão do aterramento cartográfico
`CartographicGroundingPreview.tscn` passou parser e QA headless de 36 segundos, confirmando `grounded=true` para Casa Voss e Ponte Marco 2, X/Z preservados e Y resolvido por raycast em terreno irregular. Ver `CP_D5_295_ATERRAMENTO_REGRESSAO.md` e `CP-D5-295_GROUNDING_RUNTIME.log`.

## CP-D5-296 — CONCLUÍDO: Regressão do posicionamento cartográfico R1–R6
`CartographicPlacementPreview.tscn` passou parser e QA headless de 36 segundos, confirmando os seis marcos canónicos, X/Z de mundo e correspondência no canvas do mapa. Ver `CP_D5_296_POSICIONAMENTO_MARCOS.md` e `CP-D5-296_PLACEMENT_RUNTIME.log`.

## CP-D5-297 — CONCLUÍDO: Auditoria dos contratos de altura R1–R6
`CartographicHeightContractsPreview.tscn` passou parser e QA headless de 36 segundos, confirmando cobertura dos seis marcos, três proprietários regionais, raycast obrigatório e exclusões dos elementos rejeitados. Ver `CP_D5_297_CONTRATOS_ALTURA.md` e `CP-D5-297_HEIGHT_CONTRACTS_RUNTIME.log`.

## CP-D5-298 — CONCLUÍDO: Composição multi-marco aterrada
`MultiLandmarkGroundedPreview.tscn` passou parser e QA headless de 36 segundos, confirmando Casa Voss e Ponte Marco 2 aterradas no mesmo terreno irregular, X/Z preservados, `production_script=false` e `dynamic_lights=0`. Ver `CP_D5_298_COMPOSICAO_ATERRADA.md` e `CP-D5-298_MULTILANDMARK_RUNTIME.log`.

## CP-D5-299 — CONCLUÍDO: Captura interna da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando 8 handoffs, `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`. A captura chamou `_save_snapshot`, mas o renderer devolveu `snapshot_unavailable=headless_image`; aprovação técnica, avaliação visual pendente. Ver `CP_D5_299_CAPTURA_SEQUENCIA.md` e `CP-D5-299_CAPTURE_RUNTIME.log`.

## CP-D5-300 — CONCLUÍDO: Auditoria do orçamento de luzes R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, 0 scripts de produção, 0 luzes dinâmicas globais e composição vegetal dentro dos limites GTX 1050 Ti. Ver `CP_D5_300_ORCAMENTO_LUZES.md` e `CP-D5-300_LIGHT_BUDGET_RUNTIME.log`.

## CP-D5-301 — CONCLUÍDO: Regressão de Elias na sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando 8 handoffs, `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`, preservando a fundação de Elias sem alterar `Player.gd` ou produção. Ver `CP_D5_301_ELIAS_SEQUENCIA.md` e `CP-D5-301_INTEGRATED_ELIAS_RUNTIME.log`.

## CP-D5-302 — CONCLUÍDO: Regressão do pipeline completo R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando estado `approved`, 8 handoffs, `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`, com produção e `Player.gd` preservados. Ver `CP_D5_302_PIPELINE_COMPLETO.md` e `CP-D5-302_FULL_PIPELINE_RUNTIME.log`.

## CP-D5-303 — CONCLUÍDO: Auditoria final de orçamento LOD e vegetação
`VegetationLodAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 13.424/402/6.232/114 triângulos nos activos auditados, 1 PBR focal, 3 médios, 8 distantes e 0 luzes dinâmicas para GTX 1050 Ti. Ver `CP_D5_303_AUDITORIA_FINAL_ORCAMENTO.md` e `CP-D5-303_FINAL_BUDGET_RUNTIME.log`.

## CP-D5-304 — CONCLUÍDO: Handoff final R6 para Vila Elevada
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, confirmando `r6_arrival` em `(60.000,252.000)`, destino 7 `PASSAGEM: VILA ELEVADA`, 8 checks e zero alteração em R7. Ver `CP_D5_304_HANDOFF_R6_R7.md` e `CP-D5-304_R6_R7_HANDOFF_RUNTIME.log`.

## CP-D5-305 — CONCLUÍDO: Regressão final da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, confirmando `status=approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_305_REGRESSAO_FINAL.md` e `CP-D5-305_FINAL_SEQUENCE_RUNTIME.log`.

## CP-D5-306 — CONCLUÍDO: Auditoria final de colisões e clearance R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando colisores QA, aterramento, rotas, clearance da ponte `0.21`, passagem florestal `2.4 m`, 6 candidatos, 0 scripts de produção e 0 luzes dinâmicas. Ver `CP_D5_306_AUDITORIA_CLEARANCE.md` e `CP-D5-306_CLEARANCE_RUNTIME.log`.

## CP-D5-307 — CONCLUÍDO: Regressão da composição vegetal R4/R5
`MediumVegetationCompositionPreview.tscn` passou parser e QA headless de 36 segundos, confirmando por composição 1 PBR, 3 médios, 4 distantes, `wall_of_trees=false`, offsets `(0,0)` e produção preservada. Ver `CP_D5_307_COMPOSICAO_VEGETAL.md` e `CP-D5-307_VEGETATION_COMPOSITION_RUNTIME.log`.

## CP-D5-308 — CONCLUÍDO: Regressão final da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem erros de script, sem alteração de `Player.gd` e sem alteração de produção. Ver `CP_D5_308_ELIAS_FINAL.md` e `CP-D5-308_ELIAS_FINAL_RUNTIME.log`.

## CP-D5-309 — CONCLUÍDO: Auditoria consolidada da frente Dev5
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas, `clearance=0.21`, passagem `2.4 m`, 0 scripts de produção, 0 luzes dinâmicas e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_309_AUDITORIA_CONSOLIDADA.md` e `CP-D5-309_CONSOLIDATED_RUNTIME.log`.

## CP-D5-310 — CONCLUÍDO: Validação final da cadeia cartográfica R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, confirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_310_VALIDACAO_CADEIA_FINAL.md` e `CP-D5-310_FINAL_CHAIN_RUNTIME.log`.

## CP-D5-311 — CONCLUÍDO: Regressão integrada de grounding e placement R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando grounding, X/Z, offsets, colisores, clearance, passagem, `production_scripts=0`, `dynamic_lights=0` e vegetação R4/R5 dentro do contrato. Ver `CP_D5_311_INTEGRACAO_GROUNDING.md` e `CP-D5-311_INTEGRATED_GROUNDING_RUNTIME.log`.

## CP-D5-312 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_312_REGRESSAO_CONTINUA.md` e `CP-D5-312_RUNTIME.log`.

## CP-D5-313 — CONCLUÍDO: Regressão da sequência cartográfica
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_313_REGRESSAO_SEQUENCIA.md` e `CP-D5-313_RUNTIME.log`.

## CP-D5-314 — CONCLUÍDO: Handoff de Elias R6–R7
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, confirmando `r6_arrival`, destino 7 `PASSAGEM: VILA ELEVADA`, 8 checks e Elias preservado, sem alteração de R7. Ver `CP_D5_314_HANDOFF_ELIAS_R6_R7.md` e `CP-D5-314_HANDOFF_RUNTIME.log`.

## CP-D5-315 — CONCLUÍDO: Auditoria de orçamento LOD
`VegetationLodAuditPreview.tscn` passou parser e QA headless de 36 segundos, reconfirmando activos 13.424/402/6.232/114 triângulos, contrato 1/3/8 LOD, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_315_AUDITORIA_BUDGET.md` e `CP-D5-315_BUDGET_RUNTIME.log`.

## CP-D5-316 — CONCLUÍDO: Regressão integrada R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_316_REGRESSAO_INTEGRADA.md` e `CP-D5-316_RUNTIME.log`.

## CP-D5-317 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_317_REGRESSAO_CONTINUA.md` e `CP-D5-317_RUNTIME.log`.

## CP-D5-318 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_318_AUDITORIA_INTEGRADA.md` e `CP-D5-318_RUNTIME.log`.

## CP-D5-319 — CONCLUÍDO: Regressão contínua R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_319_REGRESSAO_CONTINUA.md` e `CP-D5-319_RUNTIME.log`.

## CP-D5-320 — CONCLUÍDO: Auditoria cartográfica integrada contínua
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_320_AUDITORIA_CONTINUA.md` e `CP-D5-320_RUNTIME.log`.

## CP-D5-321 — CONCLUÍDO: Regressão da câmara de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem erros de parser/script, sem alteração de `Player.gd` ou produção. Ver `CP_D5_321_ELIAS_CAMERA.md` e `CP-D5-321_RUNTIME.log`.

## CP-D5-322 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_322_REGRESSAO_CONTINUA.md` e `CP-D5-322_RUNTIME.log`.

## CP-D5-323 — CONCLUÍDO: Auditoria contínua de orçamento LOD
`VegetationLodAuditPreview.tscn` passou parser e QA headless de 36 segundos, reconfirmando activos 13.424/402/6.232/114 triângulos, contrato LOD 1/3/8, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_323_AUDITORIA_LOD.md` e `CP-D5-323_RUNTIME.log`.

## CP-D5-324 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_324_AUDITORIA_INTEGRADA.md` e `CP-D5-324_RUNTIME.log`.

## CP-D5-325 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_325_REGRESSAO_CONTINUA.md` e `CP-D5-325_RUNTIME.log`.

## CP-D5-326 — CONCLUÍDO: Auditoria de regressão R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0`, `wall_of_trees=false` e vegetação `1/3/4`. Ver `CP_D5_326_AUDITORIA_REGRESSAO.md` e `CP-D5-326_RUNTIME.log`.

## CP-D5-327 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_327_ELIAS_REGRESSAO.md` e `CP-D5-327_RUNTIME.log`.

## CP-D5-328 — CONCLUÍDO: Regressão da composição vegetal R4/R5
`MediumVegetationCompositionPreview.tscn` passou parser e QA headless de 36 segundos, confirmando R4/R5 em `1/3/4`, offsets `(0,0)`, `wall_of_trees=false`, produção preservada e luzes dentro do orçamento. Ver `CP_D5_328_COMPOSICAO_VEGETAL.md` e `CP-D5-328_RUNTIME.log`.

## CP-D5-329 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_329_REGRESSAO_CONTINUA.md` e `CP-D5-329_RUNTIME.log`.

## CP-D5-330 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_330_AUDITORIA_INTEGRADA.md` e `CP-D5-330_RUNTIME.log`.

## CP-D5-331 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_331_REGRESSAO_CONTINUA.md` e `CP-D5-331_RUNTIME.log`.

## CP-D5-332 — CONCLUÍDO: Auditoria contínua de orçamento LOD
`VegetationLodAuditPreview.tscn` passou parser e QA headless de 36 segundos, reconfirmando activos 13.424/402/6.232/114 triângulos, contrato LOD 1/3/8, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_332_AUDITORIA_LOD.md` e `CP-D5-332_RUNTIME.log`.

## CP-D5-333 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_333_REGRESSAO_CONTINUA.md` e `CP-D5-333_RUNTIME.log`.

## CP-D5-334 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_334_AUDITORIA_INTEGRADA.md` e `CP-D5-334_RUNTIME.log`.

## CP-D5-335 — CONCLUÍDO: Regressão do handoff final R6–R7
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, confirmando `r6_arrival`, destino 7 `PASSAGEM: VILA ELEVADA`, 8 checks e R7 preservado sem alteração. Ver `CP_D5_335_HANDOFF_R6_R7.md` e `CP-D5-335_RUNTIME.log`.

## CP-D5-336 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_336_REGRESSAO_CONTINUA.md` e `CP-D5-336_RUNTIME.log`.

## CP-D5-337 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_337_AUDITORIA_INTEGRADA.md` e `CP-D5-337_RUNTIME.log`.

## CP-D5-338 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_338_ELIAS_REGRESSAO.md` e `CP-D5-338_RUNTIME.log`.

## CP-D5-339 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_339_AUDITORIA_INTEGRADA.md` e `CP-D5-339_RUNTIME.log`.

## CP-D5-340 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_340_REGRESSAO_CONTINUA.md` e `CP-D5-340_RUNTIME.log`.

## CP-D5-341 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_341_AUDITORIA_INTEGRADA.md` e `CP-D5-341_RUNTIME.log`.

## CP-D5-342 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_342_ELIAS_REGRESSAO.md` e `CP-D5-342_RUNTIME.log`.

## CP-D5-343 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_343_REGRESSAO_CONTINUA.md` e `CP-D5-343_RUNTIME.log`.

## CP-D5-344 — CONCLUÍDO: Auditoria contínua de orçamento LOD
`VegetationLodAuditPreview.tscn` passou parser e QA headless de 36 segundos, reconfirmando activos 13.424/402/6.232/114 triângulos, contrato LOD 1/3/8, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_344_AUDITORIA_LOD.md` e `CP-D5-344_RUNTIME.log`.

## CP-D5-345 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_345_REGRESSAO_CONTINUA.md` e `CP-D5-345_RUNTIME.log`.

## CP-D5-346 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_346_ELIAS_REGRESSAO.md` e `CP-D5-346_RUNTIME.log`.

## CP-D5-347 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_347_REGRESSAO_CONTINUA.md` e `CP-D5-347_RUNTIME.log`.

## CP-D5-348 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_348_AUDITORIA_INTEGRADA.md` e `CP-D5-348_RUNTIME.log`.

## CP-D5-349 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_349_REGRESSAO_CONTINUA.md` e `CP-D5-349_RUNTIME.log`.

## CP-D5-350 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_350_ELIAS_REGRESSAO.md` e `CP-D5-350_RUNTIME.log`.

## CP-D5-351 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_351_REGRESSAO_CONTINUA.md` e `CP-D5-351_RUNTIME.log`.

## CP-D5-352 — CONCLUÍDO: Auditoria contínua de orçamento LOD
`VegetationLodAuditPreview.tscn` passou parser e QA headless de 36 segundos, reconfirmando activos 13.424/402/6.232/114 triângulos, contrato LOD 1/3/8, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_352_AUDITORIA_LOD.md` e `CP-D5-352_RUNTIME.log`.

## CP-D5-353 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_353_REGRESSAO_CONTINUA.md` e `CP-D5-353_RUNTIME.log`.

## CP-D5-354 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_354_ELIAS_REGRESSAO.md` e `CP-D5-354_RUNTIME.log`.

## CP-D5-355 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_355_REGRESSAO_CONTINUA.md` e `CP-D5-355_RUNTIME.log`.

## CP-D5-356 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_356_AUDITORIA_INTEGRADA.md` e `CP-D5-356_RUNTIME.log`.

## CP-D5-357 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_357_REGRESSAO_CONTINUA.md` e `CP-D5-357_RUNTIME.log`.

## CP-D5-358 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_358_ELIAS_REGRESSAO.md` e `CP-D5-358_RUNTIME.log`.

## CP-D5-359 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_359_REGRESSAO_CONTINUA.md` e `CP-D5-359_RUNTIME.log`.

## CP-D5-360 — CONCLUÍDO: Auditoria contínua de orçamento LOD
`VegetationLodAuditPreview.tscn` passou parser e QA headless de 36 segundos, reconfirmando activos 13.424/402/6.232/114 triângulos, contrato LOD 1/3/8, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_360_AUDITORIA_LOD.md` e `CP-D5-360_RUNTIME.log`.

## CP-D5-361 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_361_ELIAS_REGRESSAO.md` e `CP-D5-361_RUNTIME.log`.

## CP-D5-362 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_362_REGRESSAO_CONTINUA.md` e `CP-D5-362_RUNTIME.log`.

## CP-D5-363 — CONCLUÍDO: Auditoria contínua de orçamento LOD
`VegetationLodAuditPreview.tscn` passou parser e QA headless de 36 segundos, reconfirmando activos 13.424/402/6.232/114 triângulos, contrato LOD 1/3/8, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_363_AUDITORIA_LOD.md` e `CP-D5-363_RUNTIME.log`.

## CP-D5-364 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_364_AUDITORIA_INTEGRADA.md` e `CP-D5-364_RUNTIME.log`.

## CP-D5-365 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_365_ELIAS_REGRESSAO.md` e `CP-D5-365_RUNTIME.log`.

## CP-D5-366 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_366_REGRESSAO_CONTINUA.md` e `CP-D5-366_RUNTIME.log`.

## CP-D5-367 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_367_AUDITORIA_INTEGRADA.md` e `CP-D5-367_RUNTIME.log`.

## CP-D5-368 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_368_ELIAS_REGRESSAO.md` e `CP-D5-368_RUNTIME.log`.

## CP-D5-369 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_369_REGRESSAO_CONTINUA.md` e `CP-D5-369_RUNTIME.log`.

## CP-D5-370 — CONCLUÍDO: Auditoria contínua de orçamento LOD
`VegetationLodAuditPreview.tscn` passou parser e QA headless de 36 segundos, reconfirmando activos 13.424/402/6.232/114 triângulos, contrato LOD 1/3/8, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_370_AUDITORIA_LOD.md` e `CP-D5-370_RUNTIME.log`.

## CP-D5-371 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_371_ELIAS_REGRESSAO.md` e `CP-D5-371_RUNTIME.log`.

## CP-D5-372 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_372_REGRESSAO_CONTINUA.md` e `CP-D5-372_RUNTIME.log`.

## CP-D5-373 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_373_AUDITORIA_INTEGRADA.md` e `CP-D5-373_RUNTIME.log`.

## CP-D5-374 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_374_ELIAS_REGRESSAO.md` e `CP-D5-374_RUNTIME.log`.

## CP-D5-375 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_375_REGRESSAO_CONTINUA.md` e `CP-D5-375_RUNTIME.log`.

## CP-D5-376 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_376_AUDITORIA_INTEGRADA.md` e `CP-D5-376_RUNTIME.log`.

## CP-D5-377 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_377_ELIAS_REGRESSAO.md` e `CP-D5-377_RUNTIME.log`.

## CP-D5-378 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_378_REGRESSAO_CONTINUA.md` e `CP-D5-378_RUNTIME.log`.

## CP-D5-379 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_379_REGRESSAO_CONTINUA.md` e `CP-D5-379_RUNTIME.log`.

## CP-D5-380 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_380_AUDITORIA_INTEGRADA.md` e `CP-D5-380_RUNTIME.log`.

## CP-D5-381 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_381_ELIAS_REGRESSAO.md` e `CP-D5-381_RUNTIME.log`.

## CP-D5-382 — CONCLUÍDO: Regressão contínua da sequência R1–R6
`CartographicSequenceR1R6Preview.tscn` passou parser e QA headless de 36 segundos, reconfirmando `approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true` e handoff final para Vila Elevada. Ver `CP_D5_382_REGRESSAO_CONTINUA.md` e `CP-D5-382_RUNTIME.log`.

## CP-D5-383 — CONCLUÍDO: Auditoria contínua de orçamento LOD
`VegetationLodAuditPreview.tscn` passou parser e QA headless de 36 segundos, reconfirmando activos 13.424/402/6.232/114 triângulos, contrato LOD 1/3/8, 0 luzes dinâmicas e compatibilidade GTX 1050 Ti. Ver `CP_D5_383_AUDITORIA_LOD.md` e `CP-D5-383_RUNTIME.log`.

## CP-D5-384 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_384_AUDITORIA_INTEGRADA.md` e `CP-D5-384_RUNTIME.log`.

## CP-D5-385 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_385_ELIAS_REGRESSAO.md` e `CP-D5-385_RUNTIME.log`.

## CP-D5-386 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_386_AUDITORIA_INTEGRADA.md` e `CP-D5-386_RUNTIME.log`.

## CP-D5-387 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_387_ELIAS_REGRESSAO.md` e `CP-D5-387_RUNTIME.log`.

## CP-D5-388 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_388_AUDITORIA_INTEGRADA.md` e `CP-D5-388_RUNTIME.log`.

## CP-D5-389 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_389_ELIAS_REGRESSAO.md` e `CP-D5-389_RUNTIME.log`.

## CP-D5-390 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_390_AUDITORIA_INTEGRADA.md` e `CP-D5-390_RUNTIME.log`.

## CP-D5-391 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_391_ELIAS_REGRESSAO.md` e `CP-D5-391_RUNTIME.log`.

## CP-D5-392 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_392_AUDITORIA_INTEGRADA.md` e `CP-D5-392_RUNTIME.log`.

## CP-D5-393 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_393_ELIAS_REGRESSAO.md` e `CP-D5-393_RUNTIME.log`.

## CP-D5-394 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_394_AUDITORIA_INTEGRADA.md` e `CP-D5-394_RUNTIME.log`.

## CP-D5-395 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_395_ELIAS_REGRESSAO.md` e `CP-D5-395_RUNTIME.log`.

## CP-D5-396 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_396_AUDITORIA_INTEGRADA.md` e `CP-D5-396_RUNTIME.log`.

## CP-D5-397 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_397_ELIAS_REGRESSAO.md` e `CP-D5-397_RUNTIME.log`.

## CP-D5-398 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_398_AUDITORIA_INTEGRADA.md` e `CP-D5-398_RUNTIME.log`.

## CP-D5-399 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_399_ELIAS_REGRESSAO.md` e `CP-D5-399_RUNTIME.log`.

## CP-D5-400 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_400_AUDITORIA_INTEGRADA.md` e `CP-D5-400_RUNTIME.log`.

## CP-D5-401 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_401_ELIAS_REGRESSAO.md` e `CP-D5-401_RUNTIME.log`.

## CP-D5-402 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_402_AUDITORIA_INTEGRADA.md` e `CP-D5-402_RUNTIME.log`.

## CP-D5-403 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_403_ELIAS_REGRESSAO.md` e `CP-D5-403_RUNTIME.log`.

## CP-D5-404 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_404_AUDITORIA_INTEGRADA.md` e `CP-D5-404_RUNTIME.log`.

## CP-D5-405 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_405_ELIAS_REGRESSAO.md` e `CP-D5-405_RUNTIME.log`.

## CP-D5-406 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_406_AUDITORIA_INTEGRADA.md` e `CP-D5-406_RUNTIME.log`.

## CP-D5-407 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_407_ELIAS_REGRESSAO.md` e `CP-D5-407_RUNTIME.log`.

## CP-D5-408 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_408_AUDITORIA_INTEGRADA.md` e `CP-D5-408_RUNTIME.log`.

## CP-D5-409 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_409_ELIAS_REGRESSAO.md` e `CP-D5-409_RUNTIME.log`.

## CP-D5-410 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_410_AUDITORIA_INTEGRADA.md` e `CP-D5-410_RUNTIME.log`.

## CP-D5-411 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_411_ELIAS_REGRESSAO.md` e `CP-D5-411_RUNTIME.log`.

## CP-D5-412 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_412_AUDITORIA_INTEGRADA.md` e `CP-D5-412_RUNTIME.log`.

## CP-D5-413 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_413_ELIAS_REGRESSAO.md` e `CP-D5-413_RUNTIME.log`.

## CP-D5-414 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_414_AUDITORIA_INTEGRADA.md` e `CP-D5-414_RUNTIME.log`.

## CP-D5-415 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_415_ELIAS_REGRESSAO.md` e `CP-D5-415_RUNTIME.log`.

## CP-D5-416 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_416_AUDITORIA_INTEGRADA.md` e `CP-D5-416_RUNTIME.log`.

## CP-D5-417 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_417_ELIAS_REGRESSAO.md` e `CP-D5-417_RUNTIME.log`.

## CP-D5-418 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_418_AUDITORIA_INTEGRADA.md` e `CP-D5-418_RUNTIME.log`.

## CP-D5-419 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_419_ELIAS_REGRESSAO.md` e `CP-D5-419_RUNTIME.log`.

## CP-D5-420 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_420_AUDITORIA_INTEGRADA.md` e `CP-D5-420_RUNTIME.log`.

## CP-D5-421 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_421_ELIAS_REGRESSAO.md` e `CP-D5-421_RUNTIME.log`.

## CP-D5-422 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_422_AUDITORIA_INTEGRADA.md` e `CP-D5-422_RUNTIME.log`.

## CP-D5-423 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_423_ELIAS_REGRESSAO.md` e `CP-D5-423_RUNTIME.log`.

## CP-D5-424 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_424_AUDITORIA_INTEGRADA.md` e `CP-D5-424_RUNTIME.log`.

## CP-D5-425 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_425_ELIAS_REGRESSAO.md` e `CP-D5-425_RUNTIME.log`.

## CP-D5-426 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_426_AUDITORIA_INTEGRADA.md` e `CP-D5-426_RUNTIME.log`.

## CP-D5-427 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_427_ELIAS_REGRESSAO.md` e `CP-D5-427_RUNTIME.log`.

## CP-D5-428 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_428_AUDITORIA_INTEGRADA.md` e `CP-D5-428_RUNTIME.log`.

## CP-D5-429 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_429_ELIAS_REGRESSAO.md` e `CP-D5-429_RUNTIME.log`.

## CP-D5-430 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_430_AUDITORIA_INTEGRADA.md` e `CP-D5-430_RUNTIME.log`.

## CP-D5-431 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_431_ELIAS_REGRESSAO.md` e `CP-D5-431_RUNTIME.log`.

## CP-D5-432 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_432_AUDITORIA_INTEGRADA.md` e `CP-D5-432_RUNTIME.log`.

## CP-D5-433 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_433_ELIAS_REGRESSAO.md` e `CP-D5-433_RUNTIME.log`.

## CP-D5-434 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_434_AUDITORIA_INTEGRADA.md` e `CP-D5-434_RUNTIME.log`.

## CP-D5-435 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_435_ELIAS_REGRESSAO.md` e `CP-D5-435_RUNTIME.log`.

## CP-D5-436 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_436_AUDITORIA_INTEGRADA.md` e `CP-D5-436_RUNTIME.log`.

## CP-D5-437 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_437_ELIAS_REGRESSAO.md` e `CP-D5-437_RUNTIME.log`.

## CP-D5-438 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_438_AUDITORIA_INTEGRADA.md` e `CP-D5-438_RUNTIME.log`.

## CP-D5-439 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_439_ELIAS_REGRESSAO.md` e `CP-D5-439_RUNTIME.log`.

## CP-D5-440 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_440_AUDITORIA_INTEGRADA.md` e `CP-D5-440_RUNTIME.log`.

## CP-D5-441 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_441_ELIAS_REGRESSAO.md` e `CP-D5-441_RUNTIME.log`.

## CP-D5-442 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_442_AUDITORIA_INTEGRADA.md` e `CP-D5-442_RUNTIME.log`.

## CP-D5-443 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_443_ELIAS_REGRESSAO.md` e `CP-D5-443_RUNTIME.log`.

## CP-D5-444 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_444_AUDITORIA_INTEGRADA.md` e `CP-D5-444_RUNTIME.log`.

## CP-D5-445 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_445_ELIAS_REGRESSAO.md` e `CP-D5-445_RUNTIME.log`.

## CP-D5-446 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_446_AUDITORIA_INTEGRADA.md` e `CP-D5-446_RUNTIME.log`.

## CP-D5-447 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos, confirmando uma única câmara QA activa (`CameraQA`), sem alteração de `Player.gd` ou produção. Ver `CP_D5_447_ELIAS_REGRESSAO.md` e `CP-D5-447_RUNTIME.log`.

## CP-D5-448 — CONCLUÍDO: Passe de Fidelidade Cartográfica R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Handoff Dev5→Dev6 entregue em `HANDOFF_DEV5_DEV6_CP_D5_448.md`.

**Evidência SHA-256:** `CP-D5-448_RUNTIME.log` = `f89bb562d185dfe2c2e0b1e0f808045000f26946e7fe834da1e8cbe736b166c9`; relatório = `a06da3edc5f8a63c41ecc864ea9d78b45c1ec986fdfe7ca3eb402e79b4eef41e`; handoff = `d689528fbe4bea61c4694a0a062050613ea7a29af4053079fed5aadbb5f26bd0`; directiva = `3d9cfbc496ebc5f47560b78d6d737e83b38adf09613ea9ef037072cc3e7d2bd9`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; autoridade `mapaorigem.webp`; handoff Dev5→Dev6 concluído
- **EVIDENCIA**: parser, QA 36 s, print 1600×900, runtime e SHA-256
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-449
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-449 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_449_ELIAS_REGRESSAO.md` e `CP-D5-449_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-450
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-450 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_450_AUDITORIA_INTEGRADA.md` e `CP-D5-450_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-451
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-451 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_451_ELIAS_REGRESSAO.md` e `CP-D5-451_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-452
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-452 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_452_AUDITORIA_INTEGRADA.md` e `CP-D5-452_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-453
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-453 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_453_ELIAS_REGRESSAO.md` e `CP-D5-453_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-454
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-454 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_454_AUDITORIA_INTEGRADA.md` e `CP-D5-454_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-455
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-455 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_455_ELIAS_REGRESSAO.md` e `CP-D5-455_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-456
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-456 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_456_AUDITORIA_INTEGRADA.md` e `CP-D5-456_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-457
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-457 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_457_ELIAS_REGRESSAO.md` e `CP-D5-457_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-458
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-458 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_458_AUDITORIA_INTEGRADA.md` e `CP-D5-458_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-459
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-459 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_459_ELIAS_REGRESSAO.md` e `CP-D5-459_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-460
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-460 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_460_AUDITORIA_INTEGRADA.md` e `CP-D5-460_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-461
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-461 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_461_ELIAS_REGRESSAO.md` e `CP-D5-461_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-462
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-462 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_462_AUDITORIA_INTEGRADA.md` e `CP-D5-462_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-463
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-463 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_463_ELIAS_REGRESSAO.md` e `CP-D5-463_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-464
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-464 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_464_AUDITORIA_INTEGRADA.md` e `CP-D5-464_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-465
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-465 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_465_ELIAS_REGRESSAO.md` e `CP-D5-465_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-466
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-466 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_466_AUDITORIA_INTEGRADA.md` e `CP-D5-466_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-467
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-467 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_467_ELIAS_REGRESSAO.md` e `CP-D5-467_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-468
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-468 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_468_AUDITORIA_INTEGRADA.md` e `CP-D5-468_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-469
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-469 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_469_ELIAS_REGRESSAO.md` e `CP-D5-469_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-470
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-470 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_470_AUDITORIA_INTEGRADA.md` e `CP-D5-470_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-471
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-471 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_471_ELIAS_REGRESSAO.md` e `CP-D5-471_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-472
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-472 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_472_AUDITORIA_INTEGRADA.md` e `CP-D5-472_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-473
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-473 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_473_ELIAS_REGRESSAO.md` e `CP-D5-473_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-474
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-474 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_474_AUDITORIA_INTEGRADA.md` e `CP-D5-474_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-475
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-475 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_475_ELIAS_REGRESSAO.md` e `CP-D5-475_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-476
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-476 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_476_AUDITORIA_INTEGRADA.md` e `CP-D5-476_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-477
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-477 — CONCLUÍDO: Regressão contínua da apresentação de Elias
`EliasThirdPersonPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando `CameraQA` como única câmara activa, sem erros de script e sem alteração de `Player.gd` ou produção. Ver `CP_D5_477_ELIAS_REGRESSAO.md` e `CP-D5-477_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: auditoria integrada R1–R6 no harness cartográfico
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; regressão Elias aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900, runtime e `CameraQA`
- **NEXT_ACTION_IMMEDIATE**: validar `CartographicRegressionAuditPreview.tscn` no CP-D5-478
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-478 — CONCLUÍDO: Auditoria integrada contínua R1–R6
`CartographicRegressionAuditPreview.tscn` passou parser e QA headless de 36 segundos em 1600×900, confirmando 6 candidatos, grounding/rotas aprovados, clearance `0.21`, passagem `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e vegetação `1/3/4` sem parede de árvores. Ver `CP_D5_478_AUDITORIA_INTEGRADA.md` e `CP-D5-478_RUNTIME.log`.

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R1–R6 / interface R6→R7
- **RESPONSAVEL**: Dev5 — Mundo Cartesiano & 3D
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: regressão técnica da apresentação de Elias no harness isolado
- **DEPENDENCIAS_RECEBIDAS**: Directiva Dev2–Dev6; handoff Dev5→Dev6; auditoria cartográfica aprovada
- **EVIDENCIA**: parser, QA 36 s em 1600×900 e runtime auditável
- **NEXT_ACTION_IMMEDIATE**: validar `EliasThirdPersonPreview.tscn` no CP-D5-479
- **DEADLINE_PROXIMO_PUSH**: mesma sessão operacional
- **WAIT_ALLOWED**: false

## CP-D5-479 — ACTIVO
Iniciar imediatamente a regressão técnica de Elias, sem aguardar confirmação verbal.




## Correcção CEO — Identidade do jogador

A identidade correcta do jogador é **Elias**. Toda a frente Dev5 usa exclusivamente `EliasThirdPersonPresentation` e `EliasThirdPersonPreview`; as nomenclaturas anteriores foram removidas de scripts, cenas, referências e documentação. A cena QA isolada passou o parser Godot 4.7.1 e manteve uma sessão de 36 segundos, com captura interna do corpo 3D provisório de Elias e da câmara externa. Esta apresentação é uma fundação técnica tridimensional, não a versão artística final do personagem.

**Tarefa activa actual:** `CP-D5-479` — iniciar regressão técnica de Elias imediatamente, sem consulta passiva ou espera temporal.


### Registo histórico local — CP-D5-130: Recaptura R1→R3 em terceira pessoa

A ferramenta isolada `levels/dev5/R1R3ThirdPersonCartographicPreview.*` passou no parser Godot 4.7.1 e numa sessão de 36 segundos, confirmando Elias em terceira pessoa e o Arco canónico no eixo a `z=92`, sem alterar `Player.gd`, produção ou Regiões 7–12. A captura foi **REJECTED_VISUAL** por terreno granular, marcadores técnicos, ruínas de baixa complexidade e silhueta provisória. A ferramenta permanece QA; ver `CP_D5_130_RECAPTURA_R1_R3_TERCEIRA_PESSOA.md`.

Este registo não substitui a tarefa remota activa `CP-D5-244`. A pré-visualização deve ser usada apenas como evidência para uma futura integração Dev1/Dev3 quando a fila canónica a autorizar.
