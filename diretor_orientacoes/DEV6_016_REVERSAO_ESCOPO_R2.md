# DEV6-016 — Reversão e Escopo R2

A auditoria confirmou que a integração R2 está concentrada em funções e grupos nomeados `dev6_r2_*` dentro de `levels/RiverRoadJourney.gd`. A rota QA `road_to_arch` permanece implementada em `TempleLevel.gd` e limita a prova às Regiões 1–6.

| Critério | Resultado |
|---|---:|
| Bloco de integração | PASS — `_build_dev6_r2_living_integration()` isolado |
| Grounding | PASS — grupo `dev6_r2_grounding` dedicado |
| Material e escala | PASS — funções `dev6_r2_*` separadas |
| Luzes do incremento | PASS — declaração `dynamic_lights=0` |
| Rota QA | PASS — `road_to_arch` disponível e limitada a R1–R6 |
| Regiões 7–12 no diff Dev6 | PASS — nenhuma referência encontrada |
| Reversão | PASS — remoção limitada ao bloco e documentos Dev6 |

A integração mantém a fronteira operacional definida: Dev6 trabalha sobre R1–R6, e não modifica nenhum módulo das Regiões 7–12. A próxima auditoria deve verificar regressão do parser depois de qualquer integração externa de câmara.
