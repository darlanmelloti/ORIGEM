# CP-D5-430 — Auditoria integrada contínua R1–R6

A cena `CartographicRegressionAuditPreview.tscn` passou o parser Godot (`PARSER_EXIT=0`) e a sessão QA headless de 36 segundos (`QA_EXIT=124`, término por timeout controlado). A telemetria confirmou seis candidatos, grounding e rotas aprovados, clearance `0.21`, passagem florestal `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e composição vegetal R4/R5 em `1/3/4`, sem parede de árvores.

Não foram observados `SCRIPT ERROR` ou `Parse Error`. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-430_RUNTIME.log`.
