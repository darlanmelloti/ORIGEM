# CP-D5-139 — Regressão integrada do Corredor do Arco R3

## Resultado

A cena `R3LivingArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição confirmou 2 elementos de fauna, 4 vegetações, 2 partes de ruína e 8 instâncias aterradas.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Ciclos de rota | 4, todos `clear=true` |
| Distância fauna mínima | 11,49 m |
| Grounding | 8 |
| Arco estrutural | Ausente (`structural_arch=false`) |
| Compressão de escala | Ausente (`scale_compressed=false`) |
| Produção | Inalterada |

A regressão confirma a transição R2→R3→R4 sem reintroduzir o arco estrutural rejeitado em CP-D5-010. O log está em `CP-D5-139_R3_ARCH_RUNTIME.log`.
