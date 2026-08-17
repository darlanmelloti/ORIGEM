# CP-D2-008 — Findings do Hub Temporal

O passe de continuidade da Região 12 corrigiu três causas concretas da leitura visual fraca. A fundação orgânica foi alinhada de `z=186.0` para `z=173.8`, coincidente com a cota real da soleira da Cúpula. Foram acrescentados cinco contrafortes verticais CC0 e uma massa de vale orgânica ampla sob o conjunto. Por fim, a câmara foi baixada de aproximadamente `y=5.8` para `y=4.7`, com alvo reduzido para `y=2.35`, dando maior peso à base no enquadramento 16:9.

O QA Godot 4.7.1 passou em todos os passes com parser/headless limpo, gameplay de 30 segundos e print 1600×900. O pass7 apresenta melhor leitura da fundação e dos suportes, embora a composição continue deliberadamente estilizada e exija um futuro passe de materiais/escala para aproximar a silhueta do santuário ao padrão alpino do mapa.

**Estado:** `PASSED_TECHNICAL / VISUAL_ADVANCE_WITH_POLISH_PENDING`.

Hash pass7: gameplay `7f11b25ccde6934554a8f12a17a0915a822c5f5766770290da05d124600e34db`; print `e52ec0df046fce0658c20968243e71b7a6dad86cc1e98ac4f41468f10f2eb03e`.

**Próxima acção imediata:** empacotar o CP-D2-008 local, sincronizar código e relatório leve para a branch Dev2 e iniciar o próximo passe de silhueta/material da Cúpula Final sem tocar nas Regiões 1–6.
