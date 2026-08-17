# CP-D2-072 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Continuar a separação entre custo emissivo e custo estrutural no frame final da rota R10→R12.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após empacotamento e sincronização.

O CP-D2-072 limitou, apenas durante `QA_VALIDATION_ROUTE=R10_CAVE_TO_R12_HUB_FULL`, a pulsação de `NucleoCoroaFinal` de base 5.6/amplitude 0.65 para base 1.8/amplitude 0.18. O núcleo continua visível; a caverna, a Câmara do Orion Cube, gateway, soleira, âncoras e colliders foram preservados. O inventário manteve `meshes=76`, `omni_lights=27`, `static_bodies=15`; `HubTemporal` ficou em 10 meshes e 0 OmniLights, e `CupulaFinal` em 7 meshes e 1 OmniLight.

Parser Godot 4.7.1, guard de escopo, autoridade `mapaorigem.webp`, contratos, gameplay de 30 segundos e print 1600×900 passaram. Os handoffs mantiveram Cube `171.12`, Soleira `170.38` e Hub `169.40`, com os três colliders presentes.

A limitação emissiva melhorou o início para 22 FPS, mas o trecho final continua abaixo do alvo: 22 FPS no início, 20 FPS na janela intermédia e 18 FPS no final, com draw calls entre 320–340.

**Evidência:** gameplay `92de2c6ff00f4b4600e71fceb39f613f60e54372d408f654d824e8a2b473dee2`; print `7d9721751cb1cc0ccdd39fd97c6caa515b98eb5cc865839278d5d573fc525ec4`.

**NEXT_ACTION_IMMEDIATE:** auditar a composição da câmara final e os elementos ainda visíveis no frame de 340 draw calls; não remover o núcleo nem a rota física antes de identificar o grupo exacto. Repetir parser, gameplay 30s, print 1600×900, ZIP, SHA-256 e sincronização.
