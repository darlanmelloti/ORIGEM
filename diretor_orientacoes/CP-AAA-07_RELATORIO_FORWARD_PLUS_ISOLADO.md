# CP-AAA-07 — Comparação Forward+ Isolada

## Resultado executivo

A comparação Forward+ foi executada corretamente com Vulkan, em ambiente isolado, sem modificar `project.godot` ou qualquer módulo de produção. A sessão da cena representativa R1/Casa Voss completou aproximadamente 36 segundos, com `37` samples, `36` medidos após exclusão do primeiro frame, `P05 FPS=144,00`, `P95 frame time=6,944 ms` e `max_dynamic_lights=1`.

O ensaio Forward+ terminou com `FORWARD_PLUS_EXIT=0`, `PARSER_ERRORS=0` e `FSR_WARNING_COUNT=0`. O erro anterior foi diagnosticado como combinação inválida entre `forward_plus` e `opengl3`; Forward+ requer o driver Vulkan. A configuração de produção não foi alterada.

| Critério | Resultado | Classificação |
|---|---:|---|
| Renderer isolado | Forward+ | Passou |
| Driver | Vulkan | Passou |
| Runtime | Aproximadamente 36 s | Passou |
| Samples medidos | `36` | Primeiro frame excluído |
| P05 FPS | `144,00` | Sinal positivo no headless |
| P95 frame time | `6,944 ms` | Sinal positivo no headless |
| Luzes dinâmicas máximas | `1` | Dentro do limite 16 |
| FSR1 warning | `0` | Resolvido no Forward+ |
| Parser errors | `0` | Passou |
| Produção alterada | Não | Preservada |

## Decisão

O Forward+ com Vulkan elimina o aviso FSR1 no ensaio isolado e mantém telemetria equivalente à referência Compatibility. A decisão é tecnicamente favorável para um perfil isolado, mas não constitui autorização para alterar o renderer do projecto, porque a medição ainda é headless e não foi realizada no hardware GTX 1050 Ti. A aprovação formal dos owners continua necessária.

**STATUS_CODE: CP-AAA-07 / FORWARD_PLUS_VULKAN_PASS / FSR_WARNING_RESOLVED_ISOLATED / LIGHT_BUDGET_PASS / PRODUCTION_BOUNDARY_PRESERVED.**

## Referências

[1]: `diretor_orientacoes/CP-AAA-07_FORWARD_PLUS_VULKAN.log` — ensaio Forward+ Vulkan.

[2]: `diretor_orientacoes/CP-AAA-07_FORWARD_PLUS_ISOLATED.log` — diagnóstico da combinação inválida Forward+/OpenGL3.

[3]: `tools_dev5_aaa_telemetry.gd` — ferramenta isolada de telemetria.
