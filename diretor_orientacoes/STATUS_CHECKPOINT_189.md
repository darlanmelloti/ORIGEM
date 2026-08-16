# ORIGEM — Checkpoint 189: Lajes de Percurso Naturalizadas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `0ba428a` — `feat(path): widen slab rotation variance to 0.18 rad for organic look`.

## Incremento aplicado

A variação de rotação Y das lajes de percurso da Floresta Densa foi ampliada de ±0.12 rad para ±0.18 rad. O cálculo base de alinhamento ao trilho (`atan2(...)`) foi preservado; apenas o ruído aleatório foi aumentado. A aparência de corredor artificial é reduzida sem comprometer a navegabilidade física, pois os colisores mantêm a mesma forma e posição.

| Parâmetro | Antes | Depois |
|---|---|---|
| Variação de rotação Y | ±0.12 rad | ±0.18 rad |
| Alinhamento base ao trilho | Preservado | Preservado |
| Colisores | Inalterados | Inalterados |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 3 | `origem_v2_phase116_take3_forest_wayfinding.png` | Lajes com variação angular mais natural; trilho desobstruído. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase189_SlabRotationNaturalized_Validated.zip`

SHA-256:

`fbe52bd0a97b5010ae159d769e647f0b7c6ec0000786ed5940e7e4db8bd1ef27`

## Próximas prioridades (por ordem de impacto visual)

1. **Preenchimento de luz do Take 9** — o conector Majestic–lago tem boa composição mas o solo frontal está muito escuro; uma OmniLight3D de preenchimento baixo melhoraria a leitura.
2. **Nota de direção sobre o Take 6** — remover ou transferir para a branch `dev2` o take que aponta para z=462–535.
3. **Segundo passe de auditoria de Takes 1–11** — confirmar que os refinamentos dos CPs 182–189 são visíveis em todos os enquadramentos.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
