# ORIGEM — Checkpoint 205: Pedras de Topo no Arco das Ruínas

**Branch:** `feature/dev1-gameplay-core`
**Módulo:** `RiverRoadJourney.gd` — nova função `_build_arch_crown_stones()`

## Incremento Aplicado

5 fragmentos de pedra irregulares no topo e lados dos pilares do Arco das Ruínas (z≈48, x≈±4.5):
- Material: pedra escura envelhecida (albedo 0.16/0.135/0.09, roughness 0.93)
- Posições: topo dos pilares (y=5.6–5.8) e lados (y=4.0–4.2)
- Rotações aleatórias determinísticas (seed 50312) para leitura de colapso

## Verificações

| Verificação | Resultado |
|---|---|
| Sintaxe Godot (headless) | ✅ Aprovado |
| Gameplay integrado 30s | ✅ Aprovado |
| Fronteira operacional | ✅ Mantida |
