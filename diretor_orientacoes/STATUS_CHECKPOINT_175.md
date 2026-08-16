# ORIGEM — Checkpoint 175: Ecologia Ribeirinha Diversificada

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `8e2ad7e` — `feat(river): diversify roadside tree species`.

## Incremento aplicado

A faixa lateral da Estrada do Rio deixou de instanciar exclusivamente coníferas médias. Dez posições ecológicas existentes agora alternam coníferas, árvores escuras detalhadas e carvalhos CC0, mantendo os afastamentos laterais e o eixo físico das lajes inalterados. O resultado acrescenta profundidade de espécies nas margens sem formar uma parede vegetal.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 2 | Captura 1280×720 | Arco das Ruínas e Estrada do Rio legíveis com maior variação de margens. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase175_RiverEcology_Validated.zip`

SHA-256:

`55628946bffbda43ca1b1b93e563c71e45e944100767125e99bb593c38ecc369`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase117_take2_road_arch.png` | Evidência visual da Estrada do Rio, Arco e margens variadas. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
