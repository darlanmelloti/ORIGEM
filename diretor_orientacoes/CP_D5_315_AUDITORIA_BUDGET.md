# CP-D5-315 — Auditoria de orçamento LOD

A cena `VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). Foram reconfirmados os activos: pinheiro PBR 13.424 triângulos, árvore detalhada 402, feto 6.232 e alternativa leve 114; sem colisões importadas.

O contrato permanece em 1 PBR focal, 3 árvores médias, 8 folhagens distantes e 0 luzes dinâmicas, compatível com GTX 1050 Ti. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-315_BUDGET_RUNTIME.log`.
