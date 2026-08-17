# CP-D2-069 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Continuar a auditoria de draw calls na Cúpula Final sem degradar a leitura do santuário.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após empacotamento e sincronização.

O CP-D2-069 reduziu, apenas durante `QA_VALIDATION_ROUTE=R10_CAVE_TO_R12_HUB_FULL`, a energia de `PreenchimentoAlpinoSemSombrasR12` de 0.24 para 0.12. O núcleo temporal, a caverna, a Câmara do Orion Cube, gateway, soleira, âncoras e colliders foram preservados. O inventário manteve `meshes=76`, `omni_lights=28`, `static_bodies=15`; `HubTemporal` ficou em 10 meshes e 0 OmniLights, e `CupulaFinal` em 7 meshes e 2 OmniLights.

Parser Godot 4.7.1, guard de escopo, autoridade `mapaorigem.webp`, contratos, gameplay de 30 segundos e print 1600×900 passaram. Os handoffs mantiveram Cube `171.12`, Soleira `170.38` e Hub `169.40`, com os três colliders presentes.

A alteração de energia não reduziu os draw calls nem resolveu o critério global: 20–21 FPS no início, 19 FPS na janela intermédia e 17 FPS no trecho final, com draw calls entre 320–340.

**Evidência:** gameplay `0aec5646988284763fe14e2965c25ff3b012b78c185cbb06649ea6872beb8991`; print `519fca47f32d087a8fa1098b49fae9ed7d5cd3baabe21b7efd9cdb8331c7d0a8`.

**NEXT_ACTION_IMMEDIATE:** localizar a origem dos draw calls no próprio harness de captura e distinguir custo de geometria, iluminação e pós-processamento; o próximo passe deve alterar apenas o componente decorativo identificado, preservando os marcos físicos e a leitura do gateway. Repetir parser, gameplay 30s, print 1600×900, ZIP, SHA-256 e sincronização.
