# CP-AAA-09 — Confirmação Final Condicionada AAA

## Estado confirmado

A branch local e remota foram confirmadas em `ce90099`, com divergência `0 0`. A consulta às orientações remotas não encontrou aprovação de owners nem pedido de alteração. O estado final é **AAA_CONDITIONAL_OWNER_APPROVAL_REQUIRED**.

A evidência acumulada confirma parser sem erros, runtime de 36 segundos, grounding isolado por raycast, telemetria representativa com `P05 FPS=144,00`, `P95 frame time=6,944 ms`, máximo de uma luz dinâmica e Forward+/Vulkan isolado sem aviso FSR1. O renderer de produção não foi alterado.

| Item | Resultado |
|---|---|
| Aprovação dos owners | Ausente |
| Pedido de alteração | Ausente |
| Produção alterada | Não |
| Promoção automática | Desactivada |
| Perfil recomendado isolado | Forward+/Vulkan |
| Perfil de produção | Compatibility, inalterado |
| FSR1 em Forward+ isolado | Sem aviso |
| P05 FPS | `144,00` |
| P95 frame time | `6,944 ms` |
| Luzes dinâmicas máximas | `1` |
| Parser errors | `0` |
| Rollback | Disponível por commit |
| Handoffs Dev3/Dev4/Dev6 | Prontos |

## Decisão operacional

A recomendação técnica isolada é Forward+/Vulkan quando FSR1 for requisito visual. Contudo, a recomendação **não é uma autorização de integração**. A confirmação final AAA depende de validação no hardware-alvo GTX 1050 Ti e aprovação explícita de Dev3, Dev4, Dev6 e owners regionais. Até lá, `project.godot`, `Player.gd`, `VossHouse.gd` e os módulos de produção permanecem sem alteração promovida.

**STATUS_CODE: CP-AAA-09 / AAA_CONDITIONAL / FORWARD_PLUS_VULKAN_PREFERRED_ISOLATED / OWNER_APPROVAL_REQUIRED / PRODUCTION_BOUNDARY_PRESERVED.**

## Referências

[1]: `diretor_orientacoes/CP-AAA-09_FINAL_CONFIRMATION.log` — confirmação final e sincronização.

[2]: `diretor_orientacoes/CP-AAA-08_RELATORIO_DECISAO_PERFIL_RENDERER.md` — matriz de decisão do renderer.

[3]: `diretor_orientacoes/CP-AAA-07_RELATORIO_FORWARD_PLUS_ISOLADO.md` — validação Forward+ Vulkan.
