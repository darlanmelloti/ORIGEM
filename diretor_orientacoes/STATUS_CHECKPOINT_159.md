# ORIGEM — Checkpoint 159: Logística do Acampamento Majestic

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `4c49766` — `feat(camp): add expedition logistics props`.

## Incremento aplicado

O Acampamento Majestic ganhou uma mesa de cartografia, uma folha de mapa de expedição, rolos de campo e um suporte leve de campanha. Estes elementos transformam a área em estação logística legível, sem recorrer a painéis planos e sem criar colisores novos no anel central ou na saída para o lago. As caixas físicas, tendas, fogueira, estela e tochas existentes foram preservadas.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 10 | Captura 1600×900 | Tendas, suporte de expedição, fogueira e área operacional legíveis. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase159_MajesticLogistics_Validated.zip`

SHA-256:

`0487446d9767c1b1c2c9ee9d39bd097800c9b56abf97247c33e7e21cc43a886b`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase122_take10_majestic_physical.png` | Evidência visual do Acampamento Majestic. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
