# ORIGEM — Checkpoint 173: Marcos Chronos Discretos

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `22f8a74` — `feat(lake): soften chronos shore markers`.

## Incremento aplicado

Os marcos Chronos que acompanham a margem entre o Acampamento Majestic e as Ruínas Submersas foram recalibrados para reduzir a aparência de esferas azuis artificiais. A emissão, o raio do globo e a luz local foram reduzidos, preservando a assinatura temporal dos pilares sem competir com a paisagem, a água e o percurso físico.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 9 | Captura 1600×900 | Marcos da margem mais discretos; leitura do corredor preservada. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase173_SubtleChronos_Validated.zip`

SHA-256:

`c71283e02a4ea5b57f8ff5d53e4e8783826a16fa43aa9309ff4acccffb0b41cb`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase123_take9_majestic_connector.png` | Evidência visual do corredor e da orientação Chronos. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
