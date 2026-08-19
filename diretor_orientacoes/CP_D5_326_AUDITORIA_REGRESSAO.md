# CP-D5-326 — Auditoria de regressão R1–R6

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A evidência reconfirmou seis candidatos, Casa Voss e Ponte aterradas, clearance `0.21`, passagem florestal `2.4 m`, `production_scripts=0`, `dynamic_lights=0`, `wall_of_trees=false` e composição vegetal `1/3/4`.

Não foram observados erros de parser ou script. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-326_RUNTIME.log`.
