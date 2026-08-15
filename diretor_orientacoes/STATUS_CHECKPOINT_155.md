# ORIGEM — Checkpoint 155: Margens da Estrada do Rio

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `34c017f` — `feat(river): add physical rocky margins`.

## Incremento aplicado

A Estrada do Rio ganhou margens de água mais legíveis e exploráveis. A lâmina do rio foi elevada de modo contido para manter continuidade sobre o relevo, e vinte e oito grupos descontínuos de rochas húmidas e fetos foram distribuídos nas duas margens. Apenas uma seleção de rochas possui colisores, evitando transformar a margem numa barreira artificial e mantendo o caminho principal livre até ao Arco das Ruínas.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 2 | Captura 1280×720 | Arco, estrada de lajes e presença ribeirinha mantêm leitura conjunta. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase155_RiverMargins_Validated.zip`

SHA-256:

`9634082fba6008139e46ded661b3498fb3127815f7481734b979ac15505f6b56`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase117_take2_road_arch.png` | Evidência visual da Estrada do Rio e do Arco das Ruínas. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
