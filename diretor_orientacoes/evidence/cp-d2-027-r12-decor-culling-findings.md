# CP-D2-027 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Região 12
- **STATUS_CODE**: PASSED_VISUAL_TECHNICAL / PERFORMANCE_UNCHANGED
- **TAREFA_EM_EXECUCAO_AGORA**: Culling de distância controlado na decoração dos monólitos temporais.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

Foi aplicado `visibility_range_end = 48.0` apenas às instâncias geométricas descendentes dos monólitos temporais. O parser/runtime Godot 4.7.1 passou, o gameplay tem 30 segundos e o print tem 1600×900. A imagem conserva a silhueta violeta e a composição do Hub sem clipping ou perda visual. No harness actual, as métricas permaneceram aproximadamente em 18–23 FPS e 320–347 draw calls, pelo que o culling não demonstrou ganho mensurável nesta câmara; não será considerado encerramento do problema de desempenho.

**Evidência:** gameplay `ce0d3a8ad0e3555c9611c687daba6fcca2a34e9299a48dafbda154e8e0e4a016`; print `2a650cc6d5289585c62028e6d3f695c0e1794bcfa476884881213bd38e6a74ec`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-027 e iniciar diagnóstico do custo de malhas repetidas do anel R12, sem remover a leitura monumental nem tocar nas Regiões 1–6.
