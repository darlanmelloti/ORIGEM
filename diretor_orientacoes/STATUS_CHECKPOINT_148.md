# ORIGEM — Checkpoint 148: Limiar do Arco das Ruínas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `9099d11` — `feat(arch): improve ruins threshold readability`.

## Incremento aplicado

O Arco das Ruínas recebeu um preenchimento neutro de alcance local, posicionado para reduzir o corte escuro do limiar sem iluminar toda a Estrada do Rio. O material de ruína ganhou uma resposta residual de luminância compatível com GL Compatibility para recuperar detalhes de musgo e alvenaria. As brasas litúrgicas continuam a ser os marcadores quentes do portal; as lajes e os colisores do percurso permaneceram inalterados.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Composição do arco | Take 2, 1280×720 | Portal, pilares e lajes permanecem identificáveis com transição de sombra mais controlada. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase148_RuinArchThreshold_Validated.zip`

SHA-256:

`a51a272d64f900a05f1ec9f40d84616377d54a866084e16de92d200c49ad11a9`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase117_take2_road_arch.png` | Evidência visual do Arco das Ruínas após o passe. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de chegada física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. A próxima melhoria continua nas Regiões 1–6 e mantém o corredor físico até às Ruínas Submersas como prioridade.
