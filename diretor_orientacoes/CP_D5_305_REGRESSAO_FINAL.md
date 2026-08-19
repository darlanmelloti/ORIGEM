# CP-D5-305 — Regressão final da sequência cartográfica R1–R6

A cena `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). O resultado mantém `status=approved`, `checks=8`, `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`, incluindo o handoff final para Vila Elevada.

A regressão confirma a estabilidade da apresentação de Elias, das âncoras cartográficas, dos handoffs e do orçamento técnico compatível com GTX 1050 Ti. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-305_FINAL_SEQUENCE_RUNTIME.log`.
