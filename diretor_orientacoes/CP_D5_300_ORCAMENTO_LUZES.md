# CP-D5-300 — Auditoria do orçamento de luzes e escopo R1–R6

A cena `CartographicRegressionAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). Os seis candidatos confirmaram `production_script=false`; a auditoria global registou `dynamic_lights=0`. As linhas individuais permanecem em `lights=1` por candidato, correspondendo à iluminação QA local, não a luzes dinâmicas de produção.

| Critério | Resultado |
|---|---|
| Candidatos | 6 |
| Scripts de produção | 0 |
| Luzes dinâmicas globais | 0 |
| Luzes QA locais | 1 por composição auditada |
| Vegetação | 1 PBR, 3 médios, 4 distantes por composição |
| Parede de árvores | `false` |
| Limite da plataforma | compatível com GTX 1050 Ti |

Não foram observados erros de parser ou script. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-300_LIGHT_BUDGET_RUNTIME.log`.
