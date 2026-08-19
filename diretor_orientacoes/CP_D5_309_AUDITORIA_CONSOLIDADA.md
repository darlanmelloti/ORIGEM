# CP-D5-309 — Auditoria consolidada da frente Dev5

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). O resultado consolidado confirmou seis candidatos, todos com `production_script=false`, aterramento e rotas QA válidas; `dynamic_lights=0` no agregado.

A Ponte Marco 2 manteve `clearance=0.21`, a Floresta Densa passagem de `2.4 m`, as Ruínas Submersas permaneceram não emissivas e a composição vegetal R4/R5 preservou `pbr=1`, `medium=3`, `distant=4`, `wall_of_trees=false`. Os seis marcos continuam dentro da fronteira Dev5, sem alteração dos módulos de produção ou `Player.gd`.

Evidência completa: `CP-D5-309_CONSOLIDATED_RUNTIME.log`.
