# Continuidade Dev6 — Arte Técnica de Ambiente

- Git: `https://github.com/darlanmelloti/ORIGEM.git`
- Branch: `feature/dev6-environment-art`
- Orientações: `diretor_orientacoes/ONBOARDING_DEV6_ARTE_TECNICA_AMBIENTE.md`

## DEV6-001 — CONCLUÍDO

A Estrada do Rio viva R2 foi integrada de forma reversível em `RiverRoadJourney.gd`. O parser Godot 4.7.1, o grounding de 9 activos, o orçamento adicional de 0 luzes e `road_to_arch` por 36 segundos passaram. Registo: `DEV6_001_ESTRADA_RIO_R2_VALIDADA.md`.

## DEV6-002 — CONCLUÍDO COM REJEIÇÃO VISUAL DOCUMENTADA

O passe de materiais e LOD passou tecnicamente — parser, rota de 36 segundos, 9/9 aterramentos e zero luzes adicionais — mas a captura ainda revela limitações de solo e enquadramento que impedem aceitação visual. Registo: `DEV6_002_AUDITORIA_MATERIAIS_LOD_R2.md`.

## DEV6-003 — CONCLUÍDO COM REJEIÇÃO VISUAL DOCUMENTADA

Foram aplicadas seis faixas laterais de material de solo sem colisores ou luzes. Parser, rota de 36 segundos, X/Z e 9/9 aterramentos passaram, mas a leitura visual global mantém-se abaixo do padrão. Registo: `DEV6_003_TRATAMENTO_SOLO_R2.md`.

## DEV6-004 — CONCLUÍDO COM REJEIÇÃO VISUAL DOCUMENTADA

A compatibilidade `gl_compatibility` foi auditada e o shader recebeu uma máscara lateral R2 reversível. Parser, rota de 36 segundos, grounding 9/9 e zero luzes adicionais passaram. A melhoria de granulação foi moderada e não autoriza aceitação visual final. Registo: `DEV6_004_COMPATIBILIDADE_GL_R2.md`.

## DEV6-005 — CONCLUÍDO COM REJEIÇÃO VISUAL DOCUMENTADA

O passe atmosférico preservou parser, rota de 36 segundos, 9/9 aterramentos, X/Z e zero luzes novas, mas a melhoria visual foi marginal. Não repetir ajustes de neblina. Registo: `DEV6_005_LEITURA_AMBIENTAL_R2.md`.

## DEV6-006 — CONCLUÍDO COM REJEIÇÃO VISUAL DOCUMENTADA

Quatro afloramentos e três vestígios laterais foram inseridos sem colisores, luzes, emissões ou invasão da rota. A validação técnica passou, mas o ganho visual foi discreto. Registo: `DEV6_006_ESCALA_AMBIENTAL_R2.md`.

## DEV6-007 — CONCLUÍDO

A leitura de câmara foi auditada sem tocar no jogador nem na câmara de produção. A proposta de terceira pessoa cartográfica para Dev1/Dev3 está em `DEV6_007_PROPOSTA_CAMARA_CARTOGRAFICA_R2.md`.

## DEV6-008 — CONCLUÍDO

A ficha de transferência e proposta de recaptura foram publicadas para Dev1/Dev3. Dev6 não aguarda a resposta externa: a integração futura será apenas uma entrada adicional de regressão.

## DEV6-009 — CONCLUÍDO

A baseline de regressão R2 confirmou ponte modular, 2 cervos, 4 elementos vegetais, 2 vestígios, 9/9 grounding, 0 luzes incrementais e `road_to_arch` por 36 segundos. Registo: `DEV6_009_BASELINE_REGRESSAO_R2.md`.

## DEV6-010 — CONCLUÍDO

O orçamento R2 confirmou 0 luzes incrementais, dois materiais adicionais e LOD limitado para fauna/vegetação. Registo: `DEV6_010_ORCAMENTO_R2.md`.

## DEV6-011 — CONCLUÍDO

A auditoria confirmou dois materiais próprios Dev6, reutilização do material PBR de ruína e o protocolo de recaptura de terceira pessoa. Registo: `DEV6_011_MATERIAIS_E_RECAPTURA_R2.md`.

## DEV6-012 — CONCLUÍDO

A cobertura documental foi confirmada na branch e a evidência binária de gameplay foi identificada no diretório QA externo, sem duplicação desnecessária em Git. Registo: `DEV6_012_COBERTURA_EVIDENCIA_R2.md`.

## DEV6-013 — CONCLUÍDO

A integridade, dimensões e hashes da evidência QA R2 foram verificados localmente e documentados. Registo: `DEV6_013_INTEGRIDADE_EVIDENCIA_R2.md`.

## DEV6-014 — CONCLUÍDO

A matriz de aceitação para a recaptura de terceira pessoa foi publicada. Registo: `DEV6_014_MATRIZ_ACEITACAO_RECAPTURA_R2.md`.

## DEV6-015 — CONCLUÍDO

A prontidão de integração foi confirmada: branch sincronizada, árvore limpa e documentação DEV6-001/009/011/013/014 presente. Registo: `DEV6_015_PRONTIDAO_INTEGRACAO_R2.md`.

## DEV6-016 — CONCLUÍDO

A auditoria confirmou que a integração R2 e os grupos de grounding permanecem isolados, sem referências às Regiões 7–12 e com reversão limitada ao bloco Dev6. Registo: `DEV6_016_REVERSAO_ESCOPO_R2.md`.

## DEV6-017 — CONCLUÍDO

A baseline de parser e rota foi executada: Godot 4.7.1, `road_to_arch` por 36 segundos, R1–R6, 9/9 grounding e zero luzes incrementais passaram. Registo: `DEV6_017_BASELINE_PARSER_ROTA_R2.md`.

## DEV6-018 — CONCLUÍDO

A ficha de retorno para Dev1/Dev3 documenta os únicos critérios visuais pendentes — terceira pessoa e composição cartográfica — mantendo todos os contratos Dev6 como PASS. Registo: `DEV6_018_RETORNO_VISUAL_R2_DEV1_DEV3.md`.

## DEV6-019 — CONCLUÍDO

A baseline, matriz e ficha de retorno foram comparadas e não apresentam divergências. A rejeição visual mantém-se limitada à perspectiva e composição da recaptura. Registo: `DEV6_019_COHERENCIA_DOCUMENTAL_R2.md`.

## DEV6-020 — CONCLUÍDO

A rastreabilidade do candidato R2 foi correlacionada entre commits, documentos e evidência QA externa. Registo: `DEV6_020_RASTREABILIDADE_CANDIDATO_R2.md`.

## DEV6-021 — CONCLUÍDO

A auditoria confirmou que nenhum passe técnico foi promovido indevidamente: a aceitação visual continua bloqueada apenas pelos critérios de terceira pessoa e composição cartográfica. Registo: `DEV6_021_CRITERIOS_PROMOCAO_R2.md`.

## DEV6-022 — CONCLUÍDO

A verificação remota encontrou apenas o contrato documental Dev5 `c15a4a0`; não houve código de câmara nem recaptura R2 válida. A matriz e baseline não foram indevidamente aplicadas. Registo: `DEV6_022_VERIFICACAO_REMOTA_RECAPTURA_R2.md`.

## DEV6-023 — CONCLUÍDO

A regressão contínua voltou a passar parser, rota de 36 segundos, R1–R6, 9/9 grounding e zero luzes incrementais. Sem recaptura válida, a decisão visual mantém-se rejeitada. Registo: `DEV6_023_REGRESSAO_CONTINUA_R2.md`.

## DEV6-024 — CONCLUÍDO

A matriz, baseline, regressão e telemetria actual não apresentam divergências: 36 s, R1–R6, 9/9 grounding, zero luzes e rejeição visual condicionada à recaptura permanecem coerentes. Registo: `DEV6_024_DIVERGENCIAS_CONTRATOS_R2.md`.

## DEV6-025 — CONCLUÍDO

O editor e a rota de 36 segundos carregaram os activos R2 sem erros de recurso, parser ou ficheiro. Registo: `DEV6_025_ESTABILIDADE_ACTIVOS_R2.md`.

## DEV6-026 — CONCLUÍDO

Os preloads R2 foram verificados: todos usam caminhos `res://` e os activos existem no clone Dev6, sem dependências externas ou referências quebradas. Registo: `DEV6_026_REFERENCIAS_ACTIVOS_R2.md`.

## DEV6-027 — CONCLUÍDO

A branch não rastreia `.uid` nem binários QA Dev6; os três caminhos absolutos documentam apenas evidência externa, sem dependência de runtime. Registo: `DEV6_027_LIMPEZA_DEPENDENCIAS_R2.md`.

## DEV6-028 — CONCLUÍDO

O manifesto DEV6-013 foi identificado como histórico após novas capturas de regressão. Foi gerado um manifesto QA externo actualizado, verificado para log e PNGs actuais. Registo: `DEV6_028_MANIFESTO_QA_R2.md`.

## DEV6-029 — CONCLUÍDO

O protocolo de manifesto por sessão foi documentado e passa a substituir a reutilização de hashes históricos depois de novas capturas. Registo: `DEV6_029_PROTOCOLO_MANIFESTO_SESSAO_R2.md`.

## DEV6-030 — CONCLUÍDO

A preparação da recaptura foi confirmada: script, pasta QA, matriz, baseline, protocolo e sincronização Git estão disponíveis. Registo: `DEV6_030_PRONTIDAO_RECAPTURA_R2.md`.

## DEV6-031 — CONCLUÍDO

O harness QA mantém entradas, capturas e telemetria determinísticas. A actualização Dev5 de composição aterrada não constitui recaptura de terceira pessoa; a aceitação visual permanece rejeitada. Registo: `DEV6_031_ESTABILIDADE_HARNESS_R2.md`.

## DEV6-032 — CONCLUÍDO

Script, telemetria, manifesto e matriz descrevem a mesma sessão R2 e não apresentam divergências. Registo: `DEV6_032_CONSISTENCIA_PROTOCOLO_QA_R2.md`.

## DEV6-033 — CONCLUÍDO

A auditoria confirmou parser, rota, grounding e luzes como PASS, enquanto terceira pessoa e composição permanecem pendentes dos respectivos proprietários. A promoção visual continua correctamente bloqueada. Registo: `DEV6_033_PRONTIDAO_PROMOCAO_R2.md`.

## DEV6-034 — CONCLUÍDO

A verificação remota encontrou trabalho Dev5 de R3, mas nenhuma câmara ou recaptura válida para R2. A decisão visual mantém-se rejeitada e a regressão técnica continua. Registo: `DEV6_034_VERIFICACAO_REMOTA_R2.md`.

## DEV6-035 — CONCLUÍDO

A regressão técnica passou parser, rota de 36 segundos, R1–R6, 9/9 grounding, zero luzes e manifesto de sessão validado. Sem recaptura válida, a aceitação visual mantém-se rejeitada. Registo: `DEV6_035_REGRESSAO_MANIFESTO_R2.md`.

## DEV6-036 — CONCLUÍDO

Log, PNGs e manifesto DEV6-035 correspondem à mesma execução e passaram verificação de integridade. A matriz continua pendente apenas de terceira pessoa e composição. Registo: `DEV6_036_RASTREABILIDADE_SESSAO_R2.md`.

## DEV6-037 — CONCLUÍDO

A verificação remota não encontrou câmara ou recaptura válida de terceira pessoa para R2. A matriz DEV6-014 não foi aplicada prematuramente; a branch Dev6 mantém-se sincronizada. Registo: `DEV6_037_VERIFICACAO_REMOTA_R2.md`.

## DEV6-038 — CONCLUÍDO

A regressão R2 passou parser, rota de 36 segundos, R1–R6, 9/9 grounding, zero luzes e manifesto de sessão. Sem recaptura válida, a aceitação visual mantém-se rejeitada. Registo: `DEV6_038_REGRESSAO_MANIFESTO_R2.md`.

## DEV6-039 — CONCLUÍDO

A sessão DEV6-038 mantém integridade e telemetria válidas; a verificação remota não encontrou recaptura de terceira pessoa R2. Registo: `DEV6_039_RASTREABILIDADE_REMOTA_R2.md`.

## DEV6-040 — CONCLUÍDO

A regressão R2 passou parser, rota de 36 segundos, R1–R6, 9/9 grounding, zero luzes e manifesto de sessão. Sem recaptura válida, a aceitação visual mantém-se rejeitada. Registo: `DEV6_040_REGRESSAO_MANIFESTO_R2.md`.

## DEV6-041 — CONCLUÍDO

A sessão DEV6-040 mantém integridade e telemetria válidas. O commit Dev5 `8357f72` é apenas documental e não contém câmara, jogador ou recaptura R2; a matriz DEV6-014 não foi aplicada. Registo: `DEV6_041_RASTREABILIDADE_REMOTA_R2.md`.

## DEV6-042 — CONCLUÍDO

A regressão R2 passou parser, rota de 36 segundos, R1–R6, 9/9 grounding, zero luzes e manifesto de sessão. Sem recaptura válida, a aceitação visual mantém-se rejeitada. Registo: `DEV6_042_REGRESSAO_MANIFESTO_R2.md`.

## DEV6-043 — CONCLUÍDO

A sessão DEV6-042 mantém integridade e telemetria válidas; a actualização Dev5 não contém terceira pessoa R2 nem evidência `road_to_arch` válida. Registo: `DEV6_043_RASTREABILIDADE_REMOTA_R2.md`.

## DEV6-044 — CONCLUÍDO

A regressão R2 passou parser, rota de 36 segundos, R1–R6, 9/9 grounding, zero luzes e manifesto de sessão. Sem recaptura válida, a aceitação visual mantém-se rejeitada. Registo: `DEV6_044_REGRESSAO_MANIFESTO_R2.md`.

## DEV6-045 — CONCLUÍDO

A sessão DEV6-044 mantém integridade e telemetria válidas; a ponta Dev5 não contém recaptura de terceira pessoa R2. Registo: `DEV6_045_RASTREABILIDADE_REMOTA_R2.md`.

## DEV6-046 — CONCLUÍDO

A regressão R2 passou parser, rota de 36 segundos, R1–R6, 9/9 grounding, zero luzes e manifesto de sessão. Sem recaptura válida, a aceitação visual mantém-se rejeitada. Registo: `DEV6_046_REGRESSAO_MANIFESTO_R2.md`.

## DEV6-047 — CONCLUÍDO

A sessão DEV6-046 mantém integridade e telemetria válidas; a ponta Dev5 não contém recaptura de terceira pessoa R2. Registo: `DEV6_047_RASTREABILIDADE_REMOTA_R2.md`.

## DEV6-048 — CONCLUÍDO

A regressão R2 passou parser, rota de 36 segundos, R1–R6, 9/9 grounding, zero luzes e manifesto de sessão. Sem recaptura válida, a aceitação visual mantém-se rejeitada. Registo: `DEV6_048_REGRESSAO_MANIFESTO_R2.md`.

## DEV6-047 a DEV6-048 — CONCLUÍDOS

O corredor vivo R3 foi integrado com 2 faunas, 4 vegetações e 2 vestígios laterais, sem arco estrutural nem luzes adicionais. Parser, rota Arco–Floresta por 36 s e grounding 8/8 passaram. Os passes materiais GL melhoraram as sombras, mas a leitura final mantém `REJECTED_VISUAL` por câmara de primeira pessoa, taludes técnicos e activos ainda provisórios. Registos: `DEV6_047_INTEGRACAO_R3_ESTADO_PARCIAL.md` e `DEV6_048_MATERIAIS_R3_E_DECISAO.md`.

## DEV6-049 — CONCLUÍDO

A vegetação lateral R4 foi integrada sem portal, fauna ou luzes. Parser, rota Floresta–Majestic de 36 s, clearing e grounding 6/6 passaram. A leitura visual mantém `REJECTED_VISUAL` por câmara de primeira pessoa, taludes provisórios e vegetação ainda técnica. Registo: `DEV6_049_VEGETACAO_R4_ESTADO_PARCIAL.md`.

## DEV6-050 — CONCLUÍDO

A margem R6 recebeu monólito, três afloramentos e dois fetos laterais sem cais de lajes nem luzes. Parser, rota Majestic–Ruínas de 36 s e grounding 6/6 passaram. A leitura visual mantém `REJECTED_VISUAL` por arma em primeira pessoa, taludes provisórios e vegetação técnica. Registo: `DEV6_050_MARGEM_R6_ESTADO_PARCIAL.md`.

## DEV6-051 — CONCLUÍDO

A regressão R2, R3, R4 e R6 confirmou parser, quatro percursos de 36 s, grounding X/Z e zero luzes adicionadas pelos blocos Dev6. Todas as decisões visuais permanecem `REJECTED_VISUAL` até recaptura de terceira pessoa Dev1/Dev3. Registo: `DEV6_051_REGRESSAO_INTEGRADA_R2_R6.md`.

## DEV6-052 — CONCLUÍDO

O exterior R1 recebeu cinco elementos de horta e dois cervos laterais sem alterar Casa Voss, porta, Elias, câmara ou rota. Parser, saída de 36 s e grounding 7/7 passaram; a recaptura estável eliminou a evidência sob o terreno. A decisão visual permanece `REJECTED_VISUAL` até recaptura de terceira pessoa. Registo: `DEV6_052_EXTERIOR_R1_ESTADO_PARCIAL.md`.

## DEV6-053 — CONCLUÍDO

O passe LOD aplicou visibilidade conservadora aos activos R1 e R6; R2, R3 e R4 já tinham LOD por activo. Parser e sessões R1/R6 de 36 s mantiveram grounding e rota. Registo: `DEV6_053_AUDITORIA_LOD_ORCAMENTO.md`.

## DEV6-054 — CONCLUÍDO

A auditoria GL unificou o material idêntico da fauna R2/R3 num recurso partilhado e preservou o aspecto, grounding e rotas de 36 s. Não foram encontradas outras unificações locais de baixo risco. Registo: `DEV6_054_MATERIAIS_GL_COMPATIBILITY.md`.

## DEV6-055 — CONCLUÍDO

A evidência remota publicada não mostra Elias em terceira pessoa nem os candidatos Dev6 R1–R6; todas as decisões continuam `REJECTED_VISUAL`. A matriz de retorno para Dev1/Dev3 está em `DEV6_055_RETORNO_RECAPTURA_REMOTA.md`.

## DEV6-056 — CONCLUÍDO

A regressão integrada R1, R2, R3, R4 e R6 passou parser e cinco sessões de 36 s. Os contratos de grounding, rota, X/Z e proibições estruturais mantiveram-se. Manifesto e decisão técnica: `DEV6_056_REGRESSAO_TECNICA_R1_R6.md`.

## DEV6-057 — CONCLUÍDO

A auditoria contabilizou 36 activos Dev6, 36 adaptadores de grounding e 0 luzes dinâmicas nas cinco regiões; LOD está activo em todos os candidatos. Não há excedente local comprovado que justifique remover activos. Registo: `DEV6_057_ORCAMENTO_INSTANCIAS_R1_R6.md`.

## DEV6-058 — CONCLUÍDO

Amostragem runtime confirmou grounding R1 7/7, R2 9/9, R3 8/8, R4 6/6 e R6 6/6 nas sessões de 36 s, sem erro de parser ou assert. Registo: `DEV6_058_INTEGRIDADE_GROUNDING_R1_R6.md`.

## DEV6-059 — CONCLUÍDO

A verificação remota posterior não encontrou recapturas de terceira pessoa para R1, R2, R3, R4 ou R6. Os bloqueios visuais permanecem explícitos; registo: `DEV6_059_DISPONIBILIDADE_RECAPTURA_R1_R6.md`.

## Tarefa activa — DEV6-060

Executar a regressão GL Compatibility das integrações Dev6 sem alterar cena: parser, contagem de referências `Light3D` dentro dos blocos Dev6, e uma sessão R2 de 36 segundos. Se passar, documentar a baseline; se falhar, abrir correcção mínima e reversível.

## Continuidade

Após concluir, esperar 10 segundos apenas para sincronizar Git e reler esta pasta. Se não existir tarefa nova, iniciar imediatamente: corrigir regressão, integrar candidato Dev5, refinar material/LOD, criar QA ou auditar orçamento. Nunca declarar espera ou parar.
