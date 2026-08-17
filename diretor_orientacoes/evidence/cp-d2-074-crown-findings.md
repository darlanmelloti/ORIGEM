# CP-D2-074 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: PASSED_WITH_CONTINUATION
- **TAREFA_EM_EXECUCAO_AGORA**: Consolidar o ganho de silhueta/culling e executar o próximo passe de validação de continuidade.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após empacotamento e sincronização.

O CP-D2-074 ocultou, apenas em `QA_VALIDATION_ROUTE=R10_CAVE_TO_R12_HUB_FULL`, o segundo conjunto `CoroaValidadaCupula_00..02`, que duplicava a coroa orgânica principal do proxy visível. A silhueta principal, arcos, lintel, gateway visual, soleira física, âncoras e colliders foram preservados.

Parser Godot 4.7.1, guard de escopo, autoridade `mapaorigem.webp`, contratos, gameplay de 30 segundos e print 1600×900 passaram. Os handoffs mantiveram Cube `171.12`, Soleira `170.38` e Hub `169.40`, com os três colliders presentes. O inventário reportado manteve `meshes=76`, `omni_lights=27`, `static_bodies=15`, enquanto o renderer medido na captura mostrou ganho directo.

O resultado visual/performance passou o limiar operacional deste passe: draw calls baixaram para 304 no trecho final e FPS subiu para 21, com 23–24 FPS no início e 22 FPS na janela intermédia. A composição mantém leitura clara da Cúpula, sem geometria flutuante ou alteração da rota física.

**Evidência:** gameplay `e80ce32e878efc209e81b69e5494a69b6e786b8101db3af5e269e56a52c046b3`; print `c29e0f83724ea84b3007934690b267ef16fe5ba74005dd6ecc4ef42e5c55e72e`.

**NEXT_ACTION_IMMEDIATE:** empacotar e sincronizar o CP-D2-074; iniciar de imediato o passe seguinte de continuidade R10→R12, preservando a coroa principal, os handoffs e o guard exclusivo das Regiões 7–12.
