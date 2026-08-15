# ORIGEM — Checkpoint 149: Legibilidade do Crepúsculo Litúrgico

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `ae508d9` — `feat(lighting): rebalance twilight regional readability`.

## Incremento aplicado

O perfil de crepúsculo recebeu um preenchimento global moderado compatível com GL Compatibility: luz ambiente azul fria mais presente, neblina ligeiramente mais luminosa e menos densa, brilho de ajuste elevado e contraste reduzido. A energia solar foi ajustada de forma contida para preservar as sombras litúrgicas. O resultado melhora a leitura de solo, pedra, vegetação e lona sem introduzir SDFGI, SSR ou efeitos incompatíveis com o orçamento da GTX 1050.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Arco das Ruínas | Take 2, 1280×720 | Pilar, lajes e vale recuperaram detalhe em sombra. |
| Acampamento Majestic | Take 10, 1600×900 | Quatro tendas, lona, mastros e horizonte regional legíveis. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `LevelEnvironment.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase149_TwilightLegibility_Validated.zip`

SHA-256:

`d59389db02a0b766c6495cf6662ba5488722e4dfa3ca17258f601fca4e935126`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase117_take2_road_arch.png` | Arco das Ruínas após a recalibração de luz. |
| `/home/ubuntu/origem_v2_phase122_take10_majestic_physical.png` | Acampamento Majestic após a recalibração de luz. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência da chegada física ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento continua exclusivamente nas Regiões 1–6.
