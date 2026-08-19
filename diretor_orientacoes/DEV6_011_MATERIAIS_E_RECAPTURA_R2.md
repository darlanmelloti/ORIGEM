# DEV6-011 — Materiais Distintos e Protocolo de Recaptura R2

A camada Dev6 R2 acrescenta apenas dois materiais próprios: o material rugoso de fauna e o material de solo lateral. Pedras, ponte modular, vestígios e afloramentos reutilizam o material de ruína PBR existente. O terreno regional continua a usar um único shader com albedo, roughness e normal já presentes no projecto.

| Grupo | Material | Estado |
|---|---|---:|
| Fauna CC0 | `fauna_material` — metálico 0, rugosidade 0,96 | PASS |
| Ponte, rochas e vestígios | `ruin_material` PBR existente | PASS |
| Faixas laterais | Material de solo sem colisão nem sombra | PASS |
| Terreno regional | Shader `TerrainPatch` com albedo, roughness e normal | PASS |
| Luzes incrementais | Nenhuma | PASS |

## Protocolo de recaptura imediato

Quando Dev1/Dev3 publicar a câmara de terceira pessoa, executar sem nova orientação:

1. Verificar parser Godot e confirmar que a prova continua limitada às Regiões 1–6.
2. Iniciar `ORIGEM_QA_ROUTE=road_to_arch` com a câmara proprietária e entrada contínua durante 36 segundos.
3. Verificar `grounding=9`, `dynamic_lights=0`, corredor livre e a presença dos marcos R2.
4. Avaliar visualmente se Elias, estrada, Arco e planos laterais se encontram na mesma leitura. Só então reavaliar a aceitação visual R2.

Enquanto a câmara não chega, a frente Dev6 prossegue por auditorias técnicas reversíveis, sem inventar alterações de câmara ou jogador.
