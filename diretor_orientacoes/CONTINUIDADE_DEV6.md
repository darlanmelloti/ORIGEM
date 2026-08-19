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

## Tarefa activa — DEV6-029

Actualizar o protocolo Dev6 para exigir manifesto SHA-256 próprio por sessão de QA R2 e auditar a preparação da próxima recaptura. Não alterar câmara, jogador, rota ou geometria.

## Continuidade

Após concluir, esperar 10 segundos apenas para sincronizar Git e reler esta pasta. Se não existir tarefa nova, iniciar imediatamente: corrigir regressão, integrar candidato Dev5, refinar material/LOD, criar QA ou auditar orçamento. Nunca declarar espera ou parar.
