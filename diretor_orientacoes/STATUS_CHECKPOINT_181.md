# ORIGEM — Checkpoint 181: Sub-bosque Navegável da Floresta Densa

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `0717f79` — `feat(forest): deepen navigable fern understory`.

## Incremento aplicado

Os fetos da Floresta Densa foram ampliados e afastados moderadamente do eixo das lajes. A nova distribuição aumenta a presença de sub-bosque nos dois lados do percurso, mas mantém uma abertura física superior a cinco metros a partir do centro do trilho. Não foram adicionados colisores a esses elementos.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 3 | `origem_v2_phase116_take3_forest_wayfinding.png` | Sub-bosque mais presente; orientação do trilho preservada. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase181_ForestUnderstory_Validated.zip`

SHA-256:

`bb7ef133f4a98fa24d924b80ebe6763a583e3d48bbff4c6c821509708e54ca6d`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase116_take3_forest_wayfinding.png` | Captura da Floresta Densa após o passe de sub-bosque. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de travessia física até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior estáveis. |

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
