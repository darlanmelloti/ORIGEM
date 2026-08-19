# CP-D5-302 — Regressão do pipeline completo R1–R6

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). O pipeline reconfirmou oito handoffs cartográficos e o estado `approved`, com `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`.

A prova mantém-se limitada à camada QA Dev5: os módulos de produção permanecem intocados, a sequência preserva as âncoras canónicas e a apresentação de Elias continua separada da implementação de `Player.gd`. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless.

Evidência completa: `CP-D5-302_FULL_PIPELINE_RUNTIME.log`.
