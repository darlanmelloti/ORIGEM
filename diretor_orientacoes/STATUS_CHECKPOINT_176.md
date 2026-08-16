# ORIGEM — Checkpoint 176: Leitura de Solo Regional

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `1a55ed8` — `feat(river): improve compacted roadbed readability`.

## Incremento aplicado

O solo compactado que liga as lajes da Estrada do Rio foi recalibrado para um castanho húmido mais legível. A mudança mantém a rugosidade e o normal map existentes, recuperando o relevo imediato no crepúsculo e evitando que o leito físico desapareça em preto, sem converter a estrada num trilho luminoso.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 2 | Captura 1280×720 | Solo compactado, lajes e Arco das Ruínas mantêm leitura coerente. |
| Take 3 | Captura 1280×720 | Transição Estrada do Rio → Floresta Densa mantida. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase176_GroundReadability_Validated.zip`

SHA-256:

`348ee855164bf0a6f7a8da6b2c17cdb84fc726c51d238403a0313b29df190d8b`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase117_take2_road_arch.png` | Evidência visual do solo e Arco das Ruínas. |
| `/home/ubuntu/origem_v2_phase116_take3_forest_wayfinding.png` | Evidência da transição para a Floresta Densa. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
