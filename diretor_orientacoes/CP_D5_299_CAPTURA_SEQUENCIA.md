# CP-D5-299 — Captura interna da sequência R1–R6

A sequência `CartographicSequenceR1R6Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). Foram confirmados novamente os oito handoffs, `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`, incluindo a passagem final para Vila Elevada.

A tentativa de captura interna chamou `_save_snapshot`, mas o renderer headless OpenGL Compatibility devolveu `snapshot_unavailable=headless_image`. Portanto, a evidência visual permanece indisponível neste ambiente; a aprovação deste checkpoint é **técnica**, não visual. Os avisos FSR1 são específicos do renderer não-Forward+.

Evidência completa: `CP-D5-299_CAPTURE_RUNTIME.log`.
