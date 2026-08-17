# CP-D2-045 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Região 12
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Validação visual/runtime isolada do Hub Temporal e Cúpula Final.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

A execução isolada de R12 passou parser Godot 4.7.1, gameplay exactamente 30 segundos e print 1600×900. O inventário mantém 129 meshes, 40 OmniLights e 15 StaticBody3D, com grupos Caverna 18/3, Câmara 11/5, Hub 18/4 e Cúpula 45/7. Os colliders e marcadores Cube → soleira → Hub continuam presentes no runtime, confirmando que a instrumentação não removeu nem tornou intrusivo qualquer elemento físico. As métricas ficaram em aproximadamente 18–23 FPS e 320–347 draw calls.

**Evidência:** gameplay `640aa3fc956074ccc4c6430d1b441878b11fdf930674c58ccfad57c50055c1db`; print `63cc01d5ad62365fd72f04621a4663f93ebf0e42cea6f30dc84f9643ea183b66`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-045 e iniciar a regressão final R10 → R11 → R12, mantendo o escopo Dev2 nas Regiões 7–12.


A inspecção visual do print 1600×900 confirma que a base da Cúpula e a soleira permanecem legíveis, enquanto os colliders, marcadores e mensagens de inventário ficam exclusivamente no log runtime. Não há gizmos, texto ou overlays visíveis na composição. A leitura cromática azul/violeta continua consistente com o passe anterior.
