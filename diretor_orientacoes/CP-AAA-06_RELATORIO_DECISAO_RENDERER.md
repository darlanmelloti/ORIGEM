# CP-AAA-06 — Decisão de Renderer e Validação Final Condicionada

## Resultado

O CP-AAA-06 repetiu a referência Compatibility/OpenGL3 na cena representativa R1/Casa Voss. A sessão produziu 36 samples medidos após excluir o primeiro frame, com `P05 FPS=144,00`, `P95 frame time=6,944 ms` e `max_dynamic_lights=1`. Não foram observados erros de parser.

A comparação Forward+ não foi executada na configuração de produção; o ensaio permaneceu em Compatibility para não alterar `project.godot` nem promover uma decisão não aprovada. O aviso `FSR1 is only available when using the Forward+ renderer` continua presente. Assim, o CP-AAA-06 não resolve ainda a escolha de renderer.

| Critério | Resultado |
|---|---:|
| Runtime representativo | Passou |
| Samples medidos | `36` |
| P05 FPS | `144,00` |
| P95 frame time | `6,944 ms` |
| Luzes dinâmicas máximas | `1` |
| Parser errors | `0` |
| Forward+ comparativo | Não executado |
| Aviso FSR1 | Mantido |
| `project.godot` alterado | Não |
| Produção alterada | Não |
| Promoção automática | Bloqueada |

## Decisão

O estado correto é **AAA_CONDITIONAL / COMPATIBILITY_REFERENCE_PASS / FORWARD_PLUS_PENDING / FSR_WARNING_OPEN**. Não há autorização para alterar o renderer de produção ou integrar alterações AAA. A próxima tarefa deve executar uma comparação Forward+ estritamente isolada, medir o mesmo cenário e preservar a possibilidade de rollback.

**STATUS_CODE: CP-AAA-06 / RENDERER_DECISION_PENDING / PRODUCTION_BOUNDARY_PRESERVED.**

## Referências

[1]: `diretor_orientacoes/CP-AAA-06_FORWARD_PLUS.log` — comparação condicionada e referência Compatibility.

[2]: `diretor_orientacoes/CP-AAA-05_RELATORIO_TELEMETRIA_REPRESENTATIVA.md` — telemetria representativa anterior.
