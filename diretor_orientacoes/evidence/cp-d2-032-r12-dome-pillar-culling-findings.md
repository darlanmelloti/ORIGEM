# CP-D2-032 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Região 12
- **STATUS_CODE**: PASSED_VISUAL_TECHNICAL / PERFORMANCE_UNCHANGED
- **TAREFA_EM_EXECUCAO_AGORA**: Culling de distância selectivo nas colunas orgânicas da Cúpula Final.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

As dez colunas orgânicas da `CupulaFinal` passaram a aplicar `visibility_range_end = 46.0` apenas às suas instâncias geométricas descendentes. O parser/runtime Godot 4.7.1 passou, o gameplay tem 30 segundos e o print tem 1600×900. O inventário permanece em `129` meshes, `40` OmniLights e `15` StaticBody3D, enquanto o harness continua aproximadamente em 18–22 FPS e 320–347 draw calls. A silhueta do santuário e o percurso permanecem preservados; o culling não produziu ganho mensurável na câmara actual.

**Evidência:** gameplay `38f07a9e92b27ef2eaf711e72bbd76945d082a8f1411f33420d67e786ed4d415`; print `87da8c9080eb973bbae74b234c506842154d085a51199030f78946f5b841825b`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-032 e iniciar a validação de qualidade dos materiais/instancing da Cúpula, sem remover geometria orgânica validada.
