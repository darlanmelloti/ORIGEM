# CP-D2-030 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: PASSED_TECHNICAL / INVENTORY_CAPTURED
- **TAREFA_EM_EXECUCAO_AGORA**: Instrumentação do inventário de render das Regiões 10–12.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

A instrumentação da `OrionDestinationRegion` reportou `meshes=129`, `omni_lights=40` e `static_bodies=15` no runtime. O parser/headless Godot 4.7.1 passou, o gameplay tem 30 segundos e o print tem 1600×900. As métricas mantiveram-se aproximadamente entre 19–23 FPS e 320–347 draw calls. O inventário confirma que o próximo passe deve separar o custo de geometria repetida por sub-região, não continuar a remover luzes de forma indiscriminada.

**Evidência:** gameplay `e78c57253f020e412f8aca1211ddeb8c8e6a1ed2d23855d30e29c3ac219e2280`; print `d24440051def34b948ef99f3936207beebb4149b0591b7a33bb2b34035af75ba`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-030 e iniciar contagem discriminada por grupos Caverna, Câmara do Cube e Hub/Cúpula, preservando a geometria orgânica validada.
