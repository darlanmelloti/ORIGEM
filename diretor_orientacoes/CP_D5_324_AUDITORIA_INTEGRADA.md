# CP-D5-324 — Auditoria integrada contínua R1–R6

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A telemetria confirmou seis candidatos, grounding aprovado, clearance `0.21`, passagem florestal `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e composição vegetal R4/R5 em `1/3/4` sem parede de árvores.

Não foram observados erros de parser ou script. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-324_RUNTIME.log`.
