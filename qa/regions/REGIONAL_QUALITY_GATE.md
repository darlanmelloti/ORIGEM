# Porta de Qualidade Regional

A porta de qualidade deve ser executada por Dev3–Dev6 antes de pedir integração na branch `integration/r1-r6-sprint1`. O objetivo é impedir que uma entrega regional quebre os contratos, a rota jogável ou o parser Godot.

## Comando

```bash
export GODOT_BIN="/caminho/para/Godot_v4.x"
tools/qa/run_regional_gate.sh R3 origin/integration/r1-r6-sprint1
```

Substitua `R3` pela região entregue. Se a branch local já estiver atualizada contra a integração comum, o segundo argumento pode ser omitido.

| Região | Rotas verificadas |
|---|---|
| R3 — Arco das Ruínas | `road_to_arch`, `arch_to_forest` |
| R4 — Floresta Densa | `arch_to_forest`, `forest_to_majestic`, `forest_to_ruins` |
| R5 — Acampamento Majestic | `forest_to_majestic`, `majestic_to_lake` |
| R6 — Ruínas Submersas | `forest_to_ruins`, `majestic_to_lake`, `ruins_arrival` |

## O que a porta verifica

A execução falha se o diff tiver erros de espaços, se o módulo contratual regional não existir, se o parser Godot falhar, se os contratos R1–R6 deixarem de validar ou se alguma rota regional não iniciar. Alterações a `scripts/main.gd`, `entities/player/Player.gd`, `levels/CartographicAnchors.gd`, `core/timeline/TimelineManager.gd` ou `ui/menus/CartographicMapUI.gd` são apresentadas como aviso e exigem revisão de Dev1.

> Uma aprovação da porta confirma integridade técnica. A aprovação artística continua a exigir teste visual no computador com GPU, em especial no modo OpenGL Compatibility da GTX 1050 Ti.
