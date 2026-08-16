# ORIGEM — Checkpoint 192: Pedras Emergentes no Leito do Rio

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `25bf63a` — `feat(river): add 3 emergent rocks above water surface for depth reading`.

## Incremento aplicado

Foram adicionadas 3 pedras emergentes ao array `bed_rock_data` do `_build_river()` no `RiverRoadJourney.gd`. Estas pedras têm escala ligeiramente maior que as rochas submersas do CP 186 (0.38–0.44 vs 0.28–0.36) e sobressaem acima da lâmina de água, criando leitura de profundidade adicional e naturalizando o curso do rio. Não têm colisores, pois o jogador não atravessa o rio.

| Posição Z | Offset X | Escala | Rotação Y |
|---|---|---|---|
| 38.0 | +0.6 | 0.44 | 1.22 rad |
| 64.0 | −1.0 | 0.38 | −0.55 rad |
| 88.0 | +1.5 | 0.42 | 2.80 rad |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível: `/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase192_RiverEmergentRocks_Validated.zip`

SHA-256: `cb42f4d701a644d0d75f9787dc496475e8a2d8fc585f66934c8018871b9868c9`

## Próximas prioridades (por ordem de impacto visual)

1. **Nota de direção sobre o Take 6** — remover ou transferir para a branch `dev2` o take que aponta para z=462–535.
2. **Passe de micro-detalhes no Arco das Ruínas** — adicionar 1–2 pedras de base ao arco para reforçar a leitura arqueológica.
3. **Auditoria final de Takes 1–11** — confirmar que todos os refinamentos dos CPs 182–192 são visíveis nos enquadramentos cinematográficos.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
