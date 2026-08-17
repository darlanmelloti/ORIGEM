# CP-D2-070 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Continuar a investigação do pico de draw calls na composição da Cúpula Final.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após empacotamento e sincronização.

O CP-D2-070 removeu, apenas durante `QA_VALIDATION_ROUTE=R10_CAVE_TO_R12_HUB_FULL`, a luz decorativa `RessonanciaRecessivoCupulaR12`. O núcleo temporal, a caverna, a Câmara do Orion Cube, gateway, soleira, âncoras e colliders foram preservados. O inventário passou para `meshes=76`, `omni_lights=27`, `static_bodies=15`; `HubTemporal` ficou em 10 meshes e 0 OmniLights, e `CupulaFinal` em 7 meshes e 1 OmniLight.

Parser Godot 4.7.1, guard de escopo, autoridade `mapaorigem.webp`, contratos, gameplay de 30 segundos e print 1600×900 passaram. Os handoffs mantiveram Cube `171.12`, Soleira `170.38` e Hub `169.40`, com os três colliders presentes.

A redução de uma luz não reduziu os draw calls nem resolveu o critério global: 21 FPS no início, 18–19 FPS na janela intermédia e 17 FPS no trecho final, com draw calls entre 320–340.

**Evidência:** gameplay `dc4d87592fa6dcdc47305101de81f611841e764dcd34755010d7b44d79ed5447`; print `51ed7ea7efe7e720f4ca6015aa84e51cee12e9b5affdb7f0856410f9a94eec0a`.

**NEXT_ACTION_IMMEDIATE:** investigar o custo de renderização da cena/harness no instante final e separar o que é draw call da geometria de R10/R11 que permanece carregada, sem remover rota física ou marcos cartográficos. Repetir parser, gameplay 30s, print 1600×900, ZIP, SHA-256 e sincronização.
