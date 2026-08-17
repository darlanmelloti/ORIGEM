# CP-D2-073 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Consolidar o ganho do culling do proxy da Cúpula e continuar a optimização sem degradar a silhueta do santuário.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após empacotamento e sincronização.

O CP-D2-073 identificou e ocultou, apenas em `QA_VALIDATION_ROUTE=R10_CAVE_TO_R12_HUB_FULL`, massas decorativas redundantes do proxy visível `CupulaFinalTraversalOrganicReveal`: suportes, ombros, conectores, jambas, monólitos, fundo recuado e borda base. Arcos, lintel, coroa visual, gateway da tomada, soleira física, âncoras e colliders foram preservados.

Parser Godot 4.7.1, guard de escopo, autoridade `mapaorigem.webp`, contratos, gameplay de 30 segundos e print 1600×900 passaram. Os handoffs mantiveram Cube `171.12`, Soleira `170.38` e Hub `169.40`, com os três colliders presentes. O inventário reportado manteve `meshes=76`, `omni_lights=27`, `static_bodies=15`, pois o relatório é emitido pelo destino oculto; a captura registou o efeito real no renderer.

O ganho visualmente auditável foi mensurável: draw calls passaram de 340 para 328 no trecho final, com FPS a subir de 17–18 para 19; a janela inicial ficou em 22 FPS e a intermédia em 21 FPS. O critério global ainda não passa de forma consistente.

**Evidência:** gameplay `37d63bfb218734a2a39083f1e4dca4adede5dedd8dd4baa8574d6c5807f4eee9`; print `b6bcf61dd76334748aac5c5b1d47bd435ee0b9c587d59e88efbeaba022f2277c`.

**NEXT_ACTION_IMMEDIATE:** consolidar o culling do proxy e auditar os restantes elementos visíveis da tomada final, preservando arcos, lintel, coroa, gateway e soleira. Repetir parser, gameplay 30s, print 1600×900, ZIP, SHA-256 e sincronização.
