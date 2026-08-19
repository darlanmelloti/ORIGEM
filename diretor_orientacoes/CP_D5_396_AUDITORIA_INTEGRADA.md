# CP-D5-396 — Auditoria integrada contínua R1–R6

A cena `CartographicRegressionAuditPreview.tscn` passou o parser Godot (`PARSER_EXIT=0`) e a sessão QA headless de 36 segundos (`QA_EXIT=124`, término por timeout controlado). A telemetria confirmou seis candidatos, grounding e rotas aprovados, clearance `0.21`, passagem florestal `2.4 m`, `production_scripts=0`, `dynamic_lights=0` e composição vegetal R4/R5 em `1/3/4`, sem parede de árvores.

Não foram observados `SCRIPT ERROR` ou `Parse Error`. Os avisos FSR1 registados são específicos da execução headless com renderer OpenGL Compatibility e não constituem regressão Dev5. O candidato mantém-se isolado dos módulos de produção, respeitando o escopo em `levels/dev5/`, `assets/models_dev5/` e `entities/player/third_person/`.

A evidência bruta está em `CP-D5-396_RUNTIME.log`.
