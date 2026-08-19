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

## CP-D5-027 — ACTIVO
Executar a próxima auditoria/ficha QA não concorrente autorizada pelo protocolo, preservando a pendência de captura visual dos candidatos R4/R6.



## Correcção CEO — Identidade do jogador

A identidade correcta do jogador é **Elias**. Toda a frente Dev5 usa exclusivamente `EliasThirdPersonPresentation` e `EliasThirdPersonPreview`; as nomenclaturas anteriores foram removidas de scripts, cenas, referências e documentação. A cena QA isolada passou o parser Godot 4.7.1 e manteve uma sessão de 36 segundos, com captura interna do corpo 3D provisório de Elias e da câmara externa. Esta apresentação é uma fundação técnica tridimensional, não a versão artística final do personagem.

**Tarefa activa actual:** `CP-D5-027` — executar a próxima auditoria/ficha QA não concorrente, mantendo R4/R6 pendentes de captura visual válida.
