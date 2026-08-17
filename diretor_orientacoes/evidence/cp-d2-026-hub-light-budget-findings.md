# CP-D2-026 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Região 12
- **STATUS_CODE**: PASSED_VISUAL_WITH_PERFORMANCE_FOLLOWUP
- **TAREFA_EM_EXECUCAO_AGORA**: Redução controlada do orçamento de luzes de rim dos monólitos do Hub Temporal.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

O passe reduziu a energia das luzes de rim de `1.8` para `1.55` e o alcance de `8.0` para `6.5`. O parser/runtime Godot 4.7.1 passou e o gameplay tem 30 segundos. A comparação visual mantém a base, os monólitos e o núcleo temporal legíveis, sem perda de enquadramento nem clipping. Contudo, o log continua a oscilar aproximadamente entre 18–23 FPS e 320–347 draw calls; portanto, este ajuste de luz isolado não é suficiente para fechar o objectivo de desempenho GTX 1050.

**Evidência:** gameplay `e2d9651820c671ada7b75ef77f4b8234ff995d230b32c2ea2bba07a027bd45eb`; print `f15c68692d815b440d8a95844da25b26792817ff99804c544082587a6b18ee5e`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-026 e iniciar um passe de culling de distância apenas em elementos decorativos remotos de R12, preservando colliders, wayfinding e silhueta do santuário.
