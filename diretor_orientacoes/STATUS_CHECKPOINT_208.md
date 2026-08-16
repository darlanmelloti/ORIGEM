# ORIGEM — Checkpoint 208: Luz de Pórtico na Casa Voss

**Branch:** `feature/dev1-gameplay-core`
**Módulo:** `VossHouse.gd` — nova função `_build_exterior_porch_light()`

## Incremento Aplicado

OmniLight3D âmbar sobre a entrada da Casa Voss:
- Posição: Vector3(-22.0, 3.2, 10.5) — sobre o limiar da porta
- Cor: âmbar quente (0.92/0.72/0.38)
- Energia: 0.85, alcance 7.5m, sem sombras
- Função: guiar o jogador à porta e criar contraste quente/frio com o crepúsculo

## Verificações

| Verificação | Resultado |
|---|---|
| Sintaxe Godot (headless) | ✅ Aprovado |
| Gameplay integrado 30s | ✅ Aprovado |
| Fronteira operacional | ✅ Mantida |
