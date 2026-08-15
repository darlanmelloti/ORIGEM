# ORIGEM — Checkpoint 151: Composição das Ruínas Submersas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `66f3eef` — `feat(lake): improve submerged ruins composition`.

## Incremento aplicado

A bacia das Ruínas Submersas foi refinada para que água e vestígios arqueológicos sejam lidos como um destino regional, não como uma pequena depressão escura. A cota da água foi elevada de forma moderada, cobrindo a margem interna fragmentada e revelando com mais clareza a forma elíptica do lago. Os três marcos emergentes receberam altura, escala e balizas discretamente reforçadas. A câmara do Take 11 foi aproximada e estreitada para priorizar a água, as lajes rasas e os pilares sem reduzir a sensação de vale ao fundo.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 11 | Captura 1600×900 | Água, lajes rasas e marcos emergentes constituem o motivo dominante. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiros alterados: `ForestLakeRegion.gd`, `RegionalCinematicDirector.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase151_SubmergedRuinsLegibility_Validated.zip`

SHA-256:

`acd780a31c0330f7dd4b503b462519695a4b39ea836a319b9d641c6c7542d4f0`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase118_take11_majestic_lake_transition.png` | Evidência visual do lago e das Ruínas Submersas. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência da chegada física à margem lacustre. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
