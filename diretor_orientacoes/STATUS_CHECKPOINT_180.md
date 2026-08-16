# ORIGEM — Checkpoint 180: Silhuetas Irregulares das Ruínas Submersas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `61e26c4` — `feat(lake): vary submerged ruins pillar silhouettes`.

## Incremento aplicado

Os oito pilares submersos receberam cotas, escalas, afastamentos e inclinações irregulares. Os três marcos emergentes foram também inclinados de forma mais assimétrica. O conjunto passa a sugerir colapso progressivo da arquitetura no lago, evitando uma disposição circular excessivamente regular, sem alterar as lajes rasas, a Estela de Chegada ou a passagem física do jogador.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 11 | `origem_v2_phase118_take11_majestic_lake_transition.png` | Leitura de pilares irregulares e margem lacustre preservada. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase180_IrregularLakePillars_Validated.zip`

SHA-256:

`c4177598f2676c0d5defd7e950fd63500ad117a7415df811407f6c5b48a40705`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase118_take11_majestic_lake_transition.png` | Captura das Ruínas Submersas após variar os pilares. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de travessia física até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior estáveis. |

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
