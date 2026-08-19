# CP-D5-101 — Validação da ficha de integração R3

## Resultado

O candidato `R3LivingArchCorridorPreview.tscn` foi validado em Godot headless Compatibility. O parser terminou com `PARSER_EXIT=0`; a sessão QA atingiu 36 segundos pelo timeout controlado e confirmou quatro ciclos de travessia R3→R4 sem bloqueio.

| Verificação | Resultado |
|---|---|
| Parser | Aprovado (`PARSER_EXIT=0`) |
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| Grounding | 8 instâncias |
| Fauna | 2 cervos |
| Vegetação | 4 elementos |
| Ruínas laterais | 2 partes |
| Ciclos de rota | 4, todos `clear=true` |
| Distância mínima registada | 11,49 m |
| Arco estrutural | Ausente (`structural_arch=false`) |
| Escala comprimida | Não (`scale_compressed=false`) |
| Produção | 0 módulos alterados |

A validação confirma a travessia aberta, preserva a rejeição do arco estrutural e mantém a fauna fora do corredor com margem superior a 5 m. O log completo está em `CP-D5-101_R3_INTEGRATION_RUNTIME.log`.
