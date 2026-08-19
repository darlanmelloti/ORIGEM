# CP-D5-328 — Regressão da composição vegetal R4/R5

A cena `MediumVegetationCompositionPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A telemetria confirmou Floresta Densa e Acampamento Majestic com `pbr=1`, `medium=3`, `distant=4`, offsets `(0,0)`, `wall_of_trees=false`, `production_script=false` e orçamento de luz dinâmica zero.

Não foram observados erros de parser ou script. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-328_RUNTIME.log`.
