# ORIGEM — Checkpoint 157: Limiar Orgânico da Floresta Densa

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `dfbc8c3` — `feat(forest): add organic entry threshold`.

## Incremento aplicado

A entrada da Floresta Densa recebeu um limiar orgânico composto por duas raízes inclinadas, afloramentos de rocha húmida e um marco P-0 baixo. O conjunto enquadra o trilho de lajes e dá ao jogador uma transição física entre a Estrada do Rio e o sub-bosque, mantendo o eixo central superior a quatro metros desimpedido. Não foram acrescentados colisores ao limiar; assim, os detalhes não bloqueiam a travessia regional.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 3 | Captura 1280×720 | Limiar, trilho de lajes e marcos de orientação visíveis na entrada da floresta. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase157_ForestThreshold_Validated.zip`

SHA-256:

`3d70f925619542be48a5cfc3d70b2098fc7ad64ee59221a8a782056c10f014b9`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase116_take3_forest_wayfinding.png` | Evidência visual da entrada da Floresta Densa. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
