# ORIGEM — Checkpoint 162: Imersão Cinematográfica da Floresta Densa

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `e9e8087` — `feat(forest): improve immersive trail framing`.

## Incremento aplicado e reversão controlada

O Take 3 foi baixado e aproximado para observar o trilho, as árvores focais e a margem ribeirinha em escala de exploração. Durante a comparação visual, o limiar de raízes procedurais introduzido anteriormente foi identificado como geometria artificial de leitura inadequada. Esse elemento foi removido integralmente antes da preservação do checkpoint. A floresta mantém as copas focais, os troncos físicos seletivos, os fetos, as pedras húmidas e os sinais P-0 existentes, sem a silhueta de vigas inclinadas.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 3 | Captura 1280×720 | Trilho e vegetação lidos em escala de exploração, sem limiar artificial. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiros alterados: `ForestLakeRegion.gd`, `RegionalCinematicDirector.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase162_ForestCinematic_Validated.zip`

SHA-256:

`b7c6919604358145a1536228bd8d0a56a39283cc7fffd88b4edf893b523a3814`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase116_take3_forest_wayfinding.png` | Evidência visual do Take 3 refinado. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
