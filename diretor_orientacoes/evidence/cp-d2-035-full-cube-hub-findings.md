# CP-D2-035 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 11–12
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Validação integrada completa Cube → soleira → Hub Temporal.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

A rota completa foi executada sem `ORIGEM_VALIDATION_REGION`, mantendo a construção integral de R10–R12. O runtime confirmou `129` meshes, `40` OmniLights e `15` StaticBody3D, com parser/headless Godot 4.7.1 limpo, gameplay de 30 segundos e print 1600×900. A leitura física do Cube, soleira e Hub permanece contínua; a segmentação introduzida no CP-D2-034 continua limitada ao QA diagnóstico e não altera a cena completa.

As métricas desta vista completa ficaram aproximadamente em 18–22 FPS e 320–347 draw calls. O custo está documentado, mas não houve regressão de composição, colisão ou wayfinding nesta validação.

**Evidência:** gameplay `ec5e34af0d2deb581036c0dc3a8d185b2f88893b3e9698743857123ecc42254d`; print `ab1345e97e198199167878d55c355798cd1d87255f9cc4727a64f4a2e24509f3`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-035 e iniciar o passe de validação de continuidade física no percurso completo, verificando transições e colliders entre R11 e R12 sem nova geometria intrusiva.
