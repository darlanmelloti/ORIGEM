# CP-D5-311 — Regressão integrada de grounding e placement R1–R6

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A integração QA reconfirmou seis candidatos, `grounded=true` para Casa Voss e Ponte, X/Z canónicos, offsets `(0,0)`, colisores próprios, `clearance=0.21`, passagem florestal `2.4 m`, `production_scripts=0` e `dynamic_lights=0`.

A composição vegetal R4/R5 manteve `pbr=1`, `medium=3`, `distant=4` e `wall_of_trees=false`. Nenhum módulo de produção ou `Player.gd` foi alterado. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-311_INTEGRATED_GROUNDING_RUNTIME.log`.
