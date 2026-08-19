# CP-D5-323 — Auditoria contínua de orçamento LOD

A cena `VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). Foram reconfirmados os activos com 13.424, 402, 6.232 e 114 triângulos, além do contrato de 1 árvore PBR focal, 3 árvores médias, 8 elementos distantes e 0 luzes dinâmicas.

A composição permanece compatível com GTX 1050 Ti. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-323_RUNTIME.log`.
