# ORIGEM — Checkpoint 174: Estrada do Rio Harmonizada

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `c963dfd` — `feat(river): blend road slabs with wet ground`.

## Incremento aplicado

As lajes físicas da Estrada do Rio receberam a mesma modulação de pedra húmida já usada no corredor Floresta–Acampamento–lago. A textura de flagstone, normal map e roughness map foram mantidos; a modulação reduz o contraste claro das lajes e preserva a leitura de rota para o Arco das Ruínas.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 2 | Captura 1280×720 | Estrada do Rio integrada à paleta regional e Arco das Ruínas legível. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase174_RiverPathMaterial_Validated.zip`

SHA-256:

`a627b9c5497e4cbbd7348b0cd38a86ae9596584691925aa8d071fd21304fb033`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase117_take2_road_arch.png` | Evidência visual da Estrada do Rio e Arco das Ruínas. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
