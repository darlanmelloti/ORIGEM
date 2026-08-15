# ORIGEM — Checkpoint 163: Orientação Diegética da Floresta Densa

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `7594c10` — `feat(forest): soften trail wayfinding`.

## Incremento aplicado

As balizas de orientação da Floresta Densa foram recalibradas como pedras baixas com braseiros discretos. A revisão reduziu de cinco para quatro pontos, aumentou o espaçamento, afastou-os do eixo de passagem, baixou as pedras e diminuiu tamanho, emissão, alcance e energia das brasas. O trilho de lajes continua a guiar Elias, enquanto os sinais P-0 permanecem como leitura narrativa temporal distinta.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 3 | Captura 1280×720 | Trilho legível; balizas quentes menos intrusivas e sem aparência de depuração. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase163_DiegeticWayfinding_Validated.zip`

SHA-256:

`5ce782d02177abdd249eeddc2c99904b360c7364b7cc8fcd376f40dfee8fabaf`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase116_take3_forest_wayfinding.png` | Evidência visual da orientação da Floresta Densa. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
