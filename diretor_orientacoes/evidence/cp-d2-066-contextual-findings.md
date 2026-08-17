# CP-D2-066 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Afinar a visibilidade contextual da decoração da aproximação e da Cúpula Final.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após o empacotamento e sincronização deste passe.

O passe CP-D2-066 aplicou culling contextual apenas quando `QA_VALIDATION_ROUTE=R10_CAVE_TO_R12_HUB_FULL`. A caverna, a Câmara do Orion Cube, o Hub Temporal, a soleira, o núcleo temporal, gateway, âncoras e colliders foram preservados. O inventário reduziu-se para `meshes=105`, `omni_lights=30`, `static_bodies=15`; `CupulaFinal` ficou em 28 meshes e 2 OmniLights. Parser Godot 4.7.1, guard, autoridade `mapaorigem.webp`, contratos, gameplay de 30 segundos e print 1600×900 passaram.

O ganho é mensurável, mas o critério de desempenho global continua rejeitado: o percurso registou 21–22 FPS no início e 18 FPS no trecho final, com draw calls entre 320–340.

**Evidência:** gameplay `645a886bb8684de4bfb6b9158a0ebe829ef43f19f9a22d6b6e7016717f8b06f8`; print `9c0b29bd2af0673011bc489ca2500cc03c5e22ff0bf7e6f5024932b8537006b1`.

**NEXT_ACTION_IMMEDIATE:** investigar o pico final de draw calls sem remover os três handoffs ou a leitura do santuário; o próximo passe deve limitar somente materiais/efeitos decorativos remotos ainda visíveis, repetindo parser, gameplay 30s, print 1600×900, ZIP, SHA-256 e sincronização.
