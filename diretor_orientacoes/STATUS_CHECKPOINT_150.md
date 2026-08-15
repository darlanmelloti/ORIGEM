# ORIGEM — Checkpoint 150: Solo do Acampamento Majestic

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `1779a00` — `feat(camp): add shallow fireground slabs`.

## Incremento aplicado

O núcleo da estação Majestic ganhou doze lajes rasas, irregulares e sem colisor, distribuídas em torno da fogueira. Elas clarificam a área de uso da expedição, reforçam a leitura de solo entre tendas e não criam degraus nem obstáculos no percurso de Elias. A iluminação recalibrada do Checkpoint 149 permite agora distinguir o anel de pedra, a lona e uma parte das novas lajes mesmo em GL Compatibility.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Acampamento Majestic | Take 10, 1600×900 | Tendas, fogueira e lajes rasas reconhecíveis. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase150_MajesticGround_Validated.zip`

SHA-256:

`b9ef84d49aaf2a99c643f0f36134532f5bcc7098be4d69e271d6a981b507e823`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase122_take10_majestic_physical.png` | Evidência visual do Acampamento Majestic. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência da chegada física ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
