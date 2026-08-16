# ORIGEM — Checkpoint 177: Sub-bosque Ribeirinho Reforçado

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `d3440b9` — `feat(river): strengthen roadside understory`.

## Incremento aplicado

Os fetos de margem do Rio e os fetos laterais da Estrada receberam escalas moderadamente maiores. Como permanecem fora do eixo de lajes e não criam colisores, o sub-bosque ganha presença visual sem reduzir a travessia física entre Casa Voss, Estrada do Rio, Arco das Ruínas e Floresta Densa.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 2 | Captura 1280×720 | Arco, estrada e margens permanecem legíveis. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase177_RiverUnderstory_Validated.zip`

SHA-256:

`0bce43cee78ce6cc64c1b6e032b989d250b8d012d003cec7053624e9aed00a79`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase117_take2_road_arch.png` | Evidência visual da Estrada do Rio e do Arco. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
