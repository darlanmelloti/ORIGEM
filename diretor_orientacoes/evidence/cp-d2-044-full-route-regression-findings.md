# CP-D2-044 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 11–12
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Regressão completa Cube → soleira → Hub.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

A captura fresca confirmou a continuidade integral da rota. Os colliders `ColisaoHandoffCubeR11`, `ColisaoHandoffSoleiraR12` e `ColisaoHandoffHubR12` surgem no runtime com `present=true`; os marcadores `HandoffCubeR11`, `HandoffSoleiraR12` e `HandoffHubR12` mantêm `sequence=1/2/3` e as posições cartográficas auditadas. Parser Godot 4.7.1, gameplay exactamente 30 segundos e print 1600×900 passaram. As métricas ficaram em aproximadamente 19–23 FPS e 320–347 draw calls, sem regressão.

**Evidência:** gameplay `028e58e0891c477486c915dd89af0728c567664bd86f0f49fa5e66e39a28f13b`; print `425851b182a995c046b2291629cc9a6b9255011a399645a3efeedbaaa9c0dd7f`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-044 e iniciar o próximo passe visual controlado da soleira/santuário, mantendo os contratos físicos invisíveis e o escopo exclusivo das Regiões 7–12.
