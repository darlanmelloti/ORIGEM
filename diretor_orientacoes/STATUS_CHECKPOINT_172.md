# ORIGEM — Checkpoint 172: Pedra de Percurso Naturalizada

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `2ceb62c` — `feat(path): blend regional slabs with wet ground`.

## Incremento aplicado

O material de lajes compartilhado pela Floresta Densa, Acampamento Majestic e Ruínas Submersas recebeu um módulo de cor pedra húmida. A textura de flagstone, normal map e rugosidade elevada foram preservados; a nova modulação reduz destaques claros que destacavam o percurso de forma artificial contra a relva de crepúsculo.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 9 | Captura 1600×900 | Lajes com contraste mais natural e eixo de percurso ainda legível. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase172_PathMaterial_Validated.zip`

SHA-256:

`38ddefa166094c6717516f2894bcf29bbf6d789fe299ec957abc261f8ed98894`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase123_take9_majestic_connector.png` | Evidência visual do percurso naturalizado. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
