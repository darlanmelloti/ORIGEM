# CP-D5-116 — Auditoria de luzes dinâmicas R4/R5

## Resultado

A primeira tentativa detectou que `LightBudgetAuditPreview.tscn` não existe no projecto (`QA_EXIT=1` por recurso ausente). A orientação foi revalidada usando a cena existente `GroundedVegetationR4R5Preview.tscn`, que contém a contagem efectiva de luzes dinâmicas.

A execução corrigida passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Foram confirmados 12 candidatos aterrados, 1 pinheiro focal, 3 árvores médias, 6 elementos leves e 2 fetos. A cena registou `dynamic_lights_added=0`, `wall_of_trees=false` e produção inalterada.

| Verificação | Resultado |
|---|---|
| Cena validada | `GroundedVegetationR4R5Preview.tscn` |
| Parser | Aprovado |
| QA | 36 segundos |
| Candidatos | 12 |
| Luzes dinâmicas adicionadas | 0 |
| Limite Dev5 | Respeitado |
| Produção | Inalterada |

O log da tentativa inválida permanece em `CP-D5-116_LIGHT_BUDGET_RUNTIME.log`; a validação efectiva está em `CP-D5-116_LIGHT_BUDGET_RUNTIME_FIXED.log`.
