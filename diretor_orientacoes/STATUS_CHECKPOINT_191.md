# ORIGEM — Checkpoint 191: Material de Pedra Molhada nas Lajes de Margem do Lago

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `377545e` — `feat(material): add wet-stone shore material for lake margin slabs`.

## Incremento aplicado

Foi criado um material dedicado `_create_shore_material()` para as lajes de margem do lago (`_build_lake_shore_path`) e para as lajes de chegada (`_build_shore_access_steps`). O material de pedra molhada tem cor mais escura e fria (`0.32, 0.36, 0.34`), rugosidade reduzida (`0.72` vs `0.92` do material de percurso) e um toque metálico subtil (`0.04`) para criar reflexo de superfície húmida. A variação de rotação das lajes de margem foi também ligeiramente ampliada de ±0.08 para ±0.10 rad.

| Parâmetro | Material de percurso | Material de margem (novo) |
|---|---|---|
| Cor albedo | `(0.43, 0.46, 0.38)` — pedra húmida | `(0.32, 0.36, 0.34)` — pedra molhada escura |
| Rugosidade | `0.92` | `0.72` |
| Metálico | `0.0` | `0.04` |
| Normal scale | `0.30` | `0.42` |
| UV scale | `0.34` | `0.30` |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 11 | `origem_v2_phase118_take11_majestic_lake_transition.png` | Lajes de margem com tom mais escuro e frio; contraste com a água melhorado; pilares emergentes legíveis; Acampamento Majestic visível ao fundo. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível: `/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase191_ShoreSlab_WetStone_Validated.zip`

SHA-256: `96fcf056b7eb5b6e4c5fe1f8e76d84e8ae3ab16a5737cc6412960c543618e71f`

## Próximas prioridades (por ordem de impacto visual)

1. **Nota de direção sobre o Take 6** — remover ou transferir para a branch `dev2` o take que aponta para z=462–535 (fora do escopo da branch dev1).
2. **Passe de micro-detalhes na Estrada do Rio** — adicionar 2–3 pedras emergentes no leito do rio para complementar as rochas submersas do CP 186.
3. **Auditoria final de Takes 1–11** — confirmar que todos os refinamentos dos CPs 182–191 são visíveis nos enquadramentos cinematográficos.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
