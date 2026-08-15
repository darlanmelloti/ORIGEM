# ORIGEM — Checkpoint 160: Enquadramento da Margem das Ruínas Submersas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `0381651` — `feat(lake): tighten submerged ruins framing`.

## Incremento aplicado

O Take 11 foi aproximado e baixado para priorizar a lâmina de água, as lajes rasas e os pilares emergentes das Ruínas Submersas. A câmara mantém a escala do vale no plano de fundo, mas coloca a margem arqueológica no primeiro plano da composição. Não houve alterações em regiões elevadas, módulos de montanha ou Takes 12–22.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 11 | Captura 1600×900 | Água, lajes rasas e pilares lidos como motivo dominante. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RegionalCinematicDirector.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase160_LakeMarginFraming_Validated.zip`

SHA-256:

`f2e4717701a66eb465bb82cc8e36a7da9709828bbd2a8800d8c64c2ea843c1c0`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase118_take11_majestic_lake_transition.png` | Evidência visual das Ruínas Submersas. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
