# CP-D5-335 — Regressão do handoff final R6–R7

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). O percurso confirmou `r6_arrival`, `next=7`, rótulo `PASSAGEM: VILA ELEVADA`, `status=approved`, 8 checks, `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`.

O marcador de Vila Elevada foi validado sem modificar R7 ou qualquer módulo de produção. Não foram observados erros de parser ou script. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-335_RUNTIME.log`.
