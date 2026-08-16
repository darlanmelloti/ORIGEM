# ORIGEM — Checkpoint 209: Variação de Cor das Margens Ribeirinhas

**Branch:** `feature/dev1-gameplay-core`
**Módulo:** `RiverRoadJourney.gd` — nova função `_build_riparian_color_variation()`

## Incremento Aplicado

6 manchas de cor alternadas ao longo das margens (z=5–70):
- 3 manchas verde-musgo (albedo 0.07–0.09/0.11–0.14/0.04–0.05)
- 3 manchas castanho-seco (albedo 0.14–0.18/0.09–0.12/0.04–0.06)
- PlaneMesh com dimensões variáveis (1.8–3.2 × 1.4–2.6m), rotação aleatória

## Verificações

| Verificação | Resultado |
|---|---|
| Sintaxe Godot (headless) | ✅ Aprovado |
| Gameplay integrado 30s | ✅ Aprovado |
| Fronteira operacional | ✅ Mantida |
