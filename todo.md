# ORIGEM — Checklist da Diretiva Reforçada

- [ ] Auditar `ORIGEM_Base.zip` e a estrutura Godot do repositório.
- [ ] Ler a diretiva reforçada diretamente no GitHub e confirmar o escopo dos Takes 5–7.
- [ ] Verificar autenticação, permissões e estado do repositório remoto novamente após a conexão concedida.
- [ ] Confirmar localmente que a branch declarada `feature/dev2-mountain-canyon` corresponde ao estado remoto atualizado.
- [ ] Confirmar compatibilidade com Godot 4.7.1, Forward+ e configuração de desempenho para GTX 1050.
- [ ] Preparar `OrganicRuinKit.gd` e eliminar greybox/cubos como solução final.
- [ ] Implementar Take 5: interior da caverna e ressonância P-0.
- [ ] Implementar Take 6: desfiladeiro, vestígios históricos e ascensão.
- [ ] Implementar Take 7: câmara aberta, Cubo de Orion, braseiros azuis e Sentinela Kharu.
- [ ] Executar F5 após cada fatia relevante.
- [ ] Capturar ciclos curtos de gameplay de aproximadamente 1 minuto e print de alta resolução; manter o take de 30 segundos como validação formal quando aplicável.
- [ ] Comparar com a referência e repetir refinamento se houver aparência plana, quadrada ou amadora.
- [ ] Consolidar agora o ponto da situação em `diretor_orientacoes/` antes de qualquer interrupção e preparar commit remoto.
- [ ] Testar desempenho, confirmar o commit remoto e entregar a referência ao diretor para orientação da próxima ação.

## Diretiva contínua atual — Dev 2 / Região 12

- [ ] Consultar `diretor_orientacoes/ESTADO_ATUAL.md` e as orientações recentes antes do próximo passe.
- [ ] Refinar a continuidade jogável Hub Temporal → Cúpula Final na Região 12.
- [ ] Executar parser/runtime Godot 4.7.1 sem erros.
- [ ] Capturar gameplay de aproximadamente 30 segundos e print 1600×900.
- [ ] Registar o estado único com `Machine State` no fim do relatório.
- [ ] Commitar o código e as evidências em `feature/dev2-mountain-canyon`.
- [ ] Avançar automaticamente para o próximo passe dentro das Regiões 7–12.

**Limite de escopo:** não modificar Regiões 1–6.

## Correcção operacional obrigatória — não parar

- [ ] Após cada commit, relatório, captura ou validação, iniciar imediatamente a próxima alteração de código dentro das Regiões 7–12.
- [ ] Nunca tratar `PASSED`, `REJECTED_VISUAL` ou entrega de evidências como estado de espera.
- [ ] Manter sempre uma `NEXT_ACTION_IMMEDIATE` executável e começar a sua implementação no mesmo ciclo.

## Regra inegociável reforçada — continuidade sem encerramento

- [ ] Nunca terminar a execução após entregar um marco.
- [ ] Iniciar o próximo passe de código imediatamente após cada commit, relatório, gameplay ou print.
- [ ] Manter o estado `CONTINUOUS_IMPLEMENT_VALIDATE_COMMIT` activo e a próxima acção física já definida.
- [ ] Limitar o próximo passe às Regiões 7–12, sem modificar Regiões 1–6.

## R12_NEXT_CONTINUITY_PASS — início efectivo

- [ ] Alterar efectivamente a composição da Região 12 na mesma branch.
- [ ] Preservar a pulsação temporal existente no recessivo.
- [ ] Melhorar escala/silhueta do santuário, base pétrea, contraste do núcleo e navegação física.
- [ ] Validar parser/runtime Godot 4.7.1, desempenho e percurso de 30 segundos.
- [ ] Gerar gameplay e print 1600×900.
- [ ] Commitar o novo passe e iniciar a próxima acção no mesmo fluxo.

## Directiva de Alinhamento Dev2 — sincronização e Take 8

- [ ] Auditar todos os módulos de código das Regiões 7–12 existentes no ambiente local.
- [ ] Sincronizar os ficheiros `.gd` reais para `feature/dev2-mountain-canyon` e verificar a presença no repositório.
- [ ] Tentar sincronização remota GitHub e registar explicitamente qualquer bloqueio de credenciais.
- [ ] Criar roteiro QA integrado para Regiões 7–12: headless sem erros + gameplay de 30 segundos.
- [ ] Adoptar checkpoints paralelos `CP-D2-001`, `CP-D2-002`, etc., sem colidir com CP 119–193 do Dev1.
- [ ] Criar briefing do Take 8 / Região 8 com câmara, rochas orgânicas, névoa, trilho ascendente e referência visual.
- [ ] Verificar a entrada Take 6 no dicionário de `RegionalCinematicDirector.gd` e documentar a atribuição à Dev2 sem tocar nas Regiões 1–6.
- [ ] Executar o primeiro ciclo auditável do Take 8: implementar, validar, capturar, avaliar, empacotar ZIP, commitar e escrever `STATUS_CHECKPOINT_CP-D2-001.md`.
- [ ] Verificar a fronteira operacional em cada commit e confirmar que nenhum ficheiro das Regiões 1–6 foi alterado.

## Auditoria Dev2 — Regiões 7–12

- [x] Auditar os 24 ficheiros `.gd` e mapear cada módulo para as Regiões 7, 8, 9, 10, 11 e 12.
- [x] Executar validação headless e captura de gameplay/print para cada região.
- [x] Registar estado regional no formato de checkpoint do Dev1.
- [ ] Aplicar passes de polimento visual apenas onde a evidência indicar lacunas, sem reescrever a base.
- [x] Repetir headless, gameplay de 30 segundos e print 1600×900 após cada passe.
- [ ] Criar ZIP reproduzível, SHA-256, commit e sincronização remota para cada checkpoint regional.
- [x] Emitir relatório consolidado das Regiões 7–12 e iniciar a próxima acção sem aguardar autorização.


## Handoff Dev1 → Dev2 — Região 7 / Vila Elevada

- [ ] Confirmar o handoff `Region7TransitionGate` em z=285–348 e `SpawnRegiao7_Dev2_HandoffPoint` em Vector3(140, y, 352).
- [ ] Auditar a Vila Elevada existente no `HighlandRegion.gd` sem reescrever o módulo base.
- [ ] Aplicar aterramento físico dos terraços/casas e verificar navegação a partir do portão.
- [ ] Harmonizar iluminação de crepúsculo, ecologia lateral, fogueiras/lanternas e estela de chegada dentro do orçamento GTX 1050 Ti.
- [ ] Executar headless, captura, avaliação visual >=85%, gameplay 30s, ZIP, commit, push e STATUS_CHECKPOINT do primeiro incremento Região 7.
- [ ] Avançar automaticamente para a próxima prioridade Dev2 após o checkpoint.


## Delegação publicada — Dev2 / Takes 6–7

- [ ] Ler `EQUIPA_FUNCOES_E_DELEGACAO.md` e todas as orientações activas em `diretor_orientacoes/`.
- [ ] Confirmar a tarefa imediata publicada para Dev2 e a fronteira exclusiva Regiões 7–12.
- [ ] Auditar e sincronizar os módulos de código dos Takes 6 e 7 na branch `feature/dev2-mountain-canyon`.
- [ ] Executar QA headless, gameplay de 30 segundos e print 1600×900 para os Takes 6–7.
- [ ] Criar ZIP compacto, SHA-256, STATUS_CHECKPOINT e commit/publicação remota.
- [ ] Avançar para a próxima tarefa delegada sem tocar nas Regiões 1–6.


## Ciclo detalhado Dev2 — Região 7 — HEAD 413a259

- [ ] Ler `CICLO_DEV2_REGIAO7_DETALHADO.md` e confirmar os cinco checkpoints publicados.
- [ ] Verificar a presença real de rua, quatro casas, fonte e colisores da CP-D2-001.
- [ ] Verificar seis árvores e oito fetos da CP-D2-002.
- [ ] Verificar lua fria e horizonte quente da CP-D2-003.
- [ ] Verificar os dois NPCs placeholder da CP-D2-004.
- [ ] Verificar a integração da Vila no `TempleLevel.gd` da CP-D2-005.
- [ ] Executar QA headless, gameplay de 30 segundos e print 1600×900.
- [ ] Corrigir apenas lacunas comprovadas, empacotar, commitar e sincronizar o resultado.


## Correcção urgente — `trail_mat` em `TempleLevel.gd`

- [ ] Confirmar todas as referências a `trail_mat` e o bloco onde é declarado.
- [ ] Corrigir o escopo sem alterar a lógica regional ou reescrever o builder.
- [ ] Executar parser/headless e simular o arranque de Novo Jogo.
- [ ] Verificar que não existem outros erros de compilação encadeados.
- [ ] Documentar, commitar e sincronizar a correcção com evidência de validação.


## Pacote de download pós-correcção `7e904936`

- [ ] Confirmar o commit corrigido e a documentação de `trail_mat`.
- [ ] Construir ZIP do projecto sem `.git`, `.godot`, `.import` e caches temporários.
- [ ] Verificar conteúdo, tamanho e SHA-256 do pacote.
- [ ] Entregar o ZIP e o hash para download.


## Continuidade operacional — próximo incremento

- [ ] Consultar a delegação e as orientações activas na pasta `diretor_orientacoes/`.
- [ ] Confirmar branch, escopo exclusivo e próxima tarefa concreta.
- [ ] Implementar o incremento sem reescrever a base nem tocar em Regiões proibidas.
- [ ] Executar headless, gameplay de aproximadamente 30 segundos e print 1600×900.
- [ ] Avaliar visualmente, iterar se necessário, empacotar e sincronizar o checkpoint.


## Continuidade — polimento da Cúpula Final Região 12

- [ ] Consultar o estado CP-D2-CONTINUITY-R11-R12 e localizar a silhueta activa da Cúpula.
- [ ] Aplicar passe incremental de material, escala e contraste sem remover a base CC0.
- [ ] Executar headless, gameplay de aproximadamente 30 segundos e print 1600×900.
- [ ] Avaliar, documentar, empacotar, commitar e sincronizar o próximo checkpoint.


## Regra de continuidade reforçada — ciclo sem pausa

- [ ] Consultar a orientação activa antes de iniciar o próximo passe.
- [ ] Fazer alteração concreta no código antes de emitir relatório de checkpoint.
- [ ] Validar headless, gameplay de aproximadamente 30 segundos e print 1600×900.
- [ ] Publicar checkpoint e iniciar imediatamente a próxima tarefa concreta no mesmo fluxo.
- [ ] Nunca tratar o relatório ou o commit como encerramento da produção.


## Novo ciclo — Matriz de Espelho do Mapa / Regiões 7–12

- [x] Tratar `mapaorigem.webp`, `origem_vale_12_pontos_casa_voss.webp` e `pasted_content.txt` como autoridade espacial e visual do ciclo.
- [x] Confirmar a sequência exclusiva Dev2: Vila Elevada → Observatório → Trilha da Montanha → Caverna do Orion → Câmara do Orion Cube → Hub Temporal.
- [x] Auditar `CartographicAnchors` e a leitura relativa dos seis marcos Dev2 sem alterar Regiões 1–6.
- [x] Implementar o próximo passe cartográfico apenas em módulos Dev2, evitando paredes vegetais, planos de fundo, caixas e marcos flutuantes.
- [x] Validar os harnesses 16:9, parser, gameplay de 30 segundos e print 1600×900.
- [ ] Registar o estado cartográfico, empacotar ZIP + SHA-256 e iniciar a próxima acção no checkpoint regional correspondente.


## CP-D2-006 — Take Panorâmico Região 7→9

- [ ] Recuperar e auditar o commit local 8802585 sem reescrever histórico.
- [ ] Ler as orientações mais recentes de `diretor_orientacoes/` antes do novo commit.
- [ ] Criar tomada 16:9 de handoff com Vila Elevada, Observatório e início da Trilha da Montanha como volumes 3D alinhados às âncoras 7–9.
- [ ] Garantir ausência de planos publicitários, caixas alongadas e marcos flutuantes.
- [ ] Validar Godot 4.7.1, gameplay de 30 segundos e print 1600×900.
- [ ] Empacotar CP-D2-006 em ZIP com SHA-256 e registar STATUS_CHECKPOINT.
- [ ] Fazer commit local sem reescrever histórico e tentar sincronização remota.
- [ ] Iniciar comprovadamente CP-D2-007 — cadeia física Região 9→10→11.


## Estado Dev2 — CP-D2-006 fechado / CP-D2-007 activo

- [x] Recuperar e auditar o commit local `8802585` sem reescrever histórico.
- [x] Ler as orientações recentes e confirmar a fila Dev2.
- [x] Criar o harness `TakePanoramicoRegiao7a9Validation` e executar passes visuais.
- [x] Validar Godot 4.7.1, gameplay 30 segundos e print 1600×900.
- [x] Empacotar `CP-D2-006-local.zip` com SHA-256 `d4f910b3c4281d79fab3dfe99810bb13ac7c958a4cabc42c31f905ff84eaba8a`.
- [x] Commit local CP-D2-006: `6afcacf`.
- [x] Iniciar CP-D2-007 com âncoras e colliders físicos Região 9→10→11.
- [x] Validar Region10 e Region11; melhorar exposição da Região 11.
- [x] Empacotar `CP-D2-007-local.zip` com SHA-256 `409547c4bae37c1c662b63290842688d31b811605bed756a58e2224aee9faba4`.
- [x] Commit local CP-D2-007: `af22d4c`.
- [ ] Sincronizar sem reescrita: remoto `5b0d317` e local `af22d4c` divergem; requer integração não destrutiva.
- [ ] Próximo passe: contraste exterior/interior e validação integrada Caverna → Cube.

**Fronteira:** apenas Regiões 7–12; Regiões 1–6 permanecem bloqueadas.


## CP-D2-202 — auditoria independente e correcção obrigatória

- [ ] Auditar o commit `9846060` e localizar o checkout canónico completo das Regiões 7–12.
- [ ] Confirmar que o checkout Dev2 contém o projecto Godot completo, não apenas script e evidências.
- [ ] Reduzir as luzes dinâmicas da Região 12 para `omni_lights <= 16`.
- [ ] Criar uma única massa vertical de portal apoiada na plataforma R12.
- [ ] Preservar estritamente as Regiões 1–6 e validar o scope guard.
- [ ] Executar parser/headless, travessia, gameplay de 30 segundos e print 1600x900.
- [ ] Avaliar visualmente e repetir o ciclo se a composição continuar rejeitada.
- [ ] Criar ZIP do projecto completo R7–R12 e calcular SHA-256.
- [ ] Actualizar o relatório com estado único e próxima acção já iniciada.
- [ ] Sincronizar o resultado na branch Dev2 publicamente verificável.
