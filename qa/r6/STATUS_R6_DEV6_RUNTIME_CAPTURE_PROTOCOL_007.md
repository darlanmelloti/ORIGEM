# ORIGEM — DEV6-R6-RUNTIME-CAPTURE-PROTOCOL-007

**Estado:** concluída localmente
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas

## Entrega

Foram adicionados `tools/qa/capture_r6_arrival_runtime.sh` e `qa/r6/inspect_r6_runtime_composition.gd`. A sonda inicia `ruins_arrival`, aguarda explicitamente a telemetria de spawn, espera estabilização pós-carregamento, captura o viewport 1600×900 e emite o inventário dos elementos R6. O script resolve o binário Godot por `GODOT_BIN`, pelo `PATH` do workflow ou pelo binário local de desenvolvimento.

## Repetibilidade verificada

Duas execuções consecutivas produziram a mesma telemetria: água `(60.0, 0.82, 252.0)`, estela `(52.0, 2.27, 231.0)`, nove detritos, três vestígios de margem, domo, oito pilares submersos, três marcos emergentes, zero luzes e zero colisores no conjunto de margem. A captura pós-carregamento eliminou a tela de arranque observada na rotina anterior.

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | Aprovado |
| Spawn `ruins_arrival` | Aprovado |
| Captura pós-carregamento | 1600×900 aprovada em duas execuções |
| Inventário R6 | Aprovado com contagens esperadas |
| Orçamento R6 | Quatro luzes aprovado |
| Handoff R6→R7 | Aprovado |
| Rotas R6 | `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` aprovadas |

## Próxima tarefa ACTIVE

`DEV6-R6-CAPTURE-MATRIX-008`: estender a sonda somente para capturar, com o mesmo protocolo pós-carregamento, as três rotas R6 exigidas. A tarefa não pode alterar código de produção, câmera de produção, água, luzes, shaders, emissão, colisores, handoff ou R7.
