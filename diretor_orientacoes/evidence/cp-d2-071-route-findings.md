# CP-D2-071 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Continuar a optimização da composição da rota R10→R12 após validar o encaminhamento correcto da variável `QA_VALIDATION_ROUTE`.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após empacotamento e sincronização.

O CP-D2-071 corrigiu o harness `test_checkpoint_cp_d2_regions7to12_continuity.sh` para encaminhar `QA_VALIDATION_ROUTE` ao processo Godot. A captura exerceu efectivamente o culling contextual das Regiões 10–12. O inventário permaneceu em `meshes=76`, `omni_lights=27`, `static_bodies=15`; `HubTemporal` ficou em 10 meshes e 0 OmniLights, e `CupulaFinal` em 7 meshes e 1 OmniLight.

Parser Godot 4.7.1, guard de escopo, autoridade `mapaorigem.webp`, contratos, gameplay de 30 segundos e print 1600×900 passaram. Os handoffs mantiveram Cube `171.12`, Soleira `170.38` e Hub `169.40`, com os três colliders presentes.

A medição real após corrigir o harness continua abaixo do alvo: 20–21 FPS no início, 19 FPS na janela intermédia e 18–19 FPS no trecho final, com draw calls entre 320–340. O culling está a ser exercido correctamente, mas não reduz o pico de draw calls observado pelo monitor actual.

**Evidência:** gameplay `4de7aecffadf0cb3fea4f073716c47c1e23de452c6aae1d279d55f7ed9f5b397`; print `859023de82307fa613fe261367a65b53f24a9a8f1e63f982716cfce41650ae97`.

**NEXT_ACTION_IMMEDIATE:** auditar o monitor de métricas e separar o custo de renderização do jogo do custo do ambiente de captura; não remover mais geometria estrutural antes dessa distinção. Repetir parser, gameplay 30s, print 1600×900, ZIP, SHA-256 e sincronização.
