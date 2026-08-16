# ORIGEM — Checkpoint 207: Fetos na Base dos Pilares do Arco das Ruínas

**Branch:** `feature/dev1-gameplay-core`
**Módulo:** `RiverRoadJourney.gd` — nova função `_build_arch_base_ferns()`

## Incremento Aplicado

4 fetos baixos (cone CylinderMesh) na base dos pilares do Arco das Ruínas:
- 2 por pilar, alternados em x e z para leitura orgânica
- Material: verde escuro (albedo 0.09/0.13/0.06, roughness 0.88)
- Altura 0.55–0.85m, raio 0.28–0.42m, rotação aleatória

## Verificações

| Verificação | Resultado |
|---|---|
| Sintaxe Godot (headless) | ✅ Aprovado |
| Gameplay integrado 30s | ✅ Aprovado |
| Fronteira operacional | ✅ Mantida |
