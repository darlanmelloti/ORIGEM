# CP-D2-061 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Passe de desempenho da silhueta final e das transições R9→R10/R11→R12, com visibilidade limitada apenas em geometria decorativa distante.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

A optimização foi aplicada exclusivamente em `levels/OrionDestinationRegion.gd`: degraus decorativos das transições receberam `visibility_range_end=72.0`; pilares decorativos da Cúpula receberam `visibility_range_end=52.0`, mantendo colliders, marcadores, materiais, iluminação próxima e a autoridade `mapaorigem.webp`. O guard `REGIONS_7_12_ONLY`, a autoridade cartográfica, `HANDOFF_CONTRACT`, `HANDOFF_ORDER` e `FULL_HANDOFF_CONTRACT` passaram. Godot 4.7.1 confirmou parser/headless limpo, gameplay exactamente 30 segundos e print 1600×900.

A captura mostrou melhoria inicial para 23 FPS e 20 FPS no meio do percurso; o trecho final mantém 19 FPS, sem perda do handoff físico ou dos marcos legíveis. Draw calls permaneceram entre 320–347.

**Evidência:** gameplay `1648bf9b30ca5aca71b91d0e901a123c8ed66b7cb5f624daee3549c812cd1af6`; print `2015ce76ca573c7d38158041d740fd56759f4732cfb2a6d218dd72ce88a3b6e3`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-061; em seguida iniciar a auditoria visual contínua da silhueta Hub/Cúpula com o mesmo contrato R10→R12.
