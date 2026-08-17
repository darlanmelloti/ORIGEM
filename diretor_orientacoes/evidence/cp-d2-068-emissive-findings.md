# CP-D2-068 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Continuar o passe de desempenho sobre efeitos remotos, sem reduzir a leitura dos marcos de R10→R12.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após empacotamento e sincronização.

O CP-D2-068 removeu, apenas durante `QA_VALIDATION_ROUTE=R10_CAVE_TO_R12_HUB_FULL`, os núcleos emissivos e luzes de rim decorativas dos oito monólitos temporais. O núcleo temporal, a caverna, a Câmara do Orion Cube, gateway, soleira, âncoras e colliders foram preservados. O inventário caiu para `meshes=76`, `omni_lights=28`, `static_bodies=15`; `HubTemporal` ficou em 10 meshes e 0 OmniLights, enquanto `CupulaFinal` permaneceu em 7 meshes e 2 OmniLights.

Parser Godot 4.7.1, guard de escopo, autoridade `mapaorigem.webp`, contratos, gameplay de 30 segundos e print 1600×900 passaram. Os handoffs mantiveram Cube `171.12`, Soleira `170.38` e Hub `169.40`, com os três colliders presentes.

A redução de inventário é mensurável, mas o desempenho global continua rejeitado: 21 FPS no início, 18 FPS na janela intermédia e 17 FPS no trecho final, com draw calls entre 320–340.

**Evidência:** gameplay `a686a36da0fb0185690603532158522f7dfd9737abaa52a556bf9e3bdbfb3c84`; print `b599c25cc6c86139ff54a6eadda3775afcb8a253c73a0337ae8ab438bbe74b39`.

**NEXT_ACTION_IMMEDIATE:** auditar o pico final de draw calls na composição da Cúpula e no preenchimento direccional, reduzindo apenas efeitos sem função de wayfinding; preservar núcleo temporal, gateway, soleira, âncoras e colliders. Repetir parser, gameplay 30s, print 1600×900, ZIP, SHA-256 e sincronização.
