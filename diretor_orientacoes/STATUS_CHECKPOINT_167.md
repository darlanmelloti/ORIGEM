# ORIGEM — Checkpoint 167: Água das Ruínas Submersas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `947b0b3` — `feat(lake): soften compatibility water highlights`.

## Incremento aplicado

O shader da lâmina das Ruínas Submersas foi recalibrado para responder melhor ao renderizador de compatibilidade. A rugosidade da água passou de `0.34` para `0.52`, enquanto a especularidade foi reduzida de `0.60` para `0.28`. As ondas, a variação azul-profunda, a emissão residual de leitura e a geometria elíptica foram preservadas. O resultado reduz reflexos rígidos e mantém a margem arqueológica, as lajes rasas e os pilares identificáveis.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 11 | Captura 1600×900 | Água com leitura mais difusa; pilares e lajes continuam legíveis. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase167_LakeMaterial_Validated.zip`

SHA-256:

`4f4bc429e301d7f977b63dc220ece10d9155669ea8b433d97c6375df347446e4`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase118_take11_majestic_lake_transition.png` | Evidência visual da água e das ruínas emergentes. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
