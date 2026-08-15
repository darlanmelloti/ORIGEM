# ORIGEM — Checkpoint 158: Estratificação de Copas da Floresta Densa

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `5f2b5ea` — `feat(forest): layer focal canopy clusters`.

## Incremento aplicado

A Floresta Densa passou a integrar sete copas focais adicionais, distribuídas em posições alternadas fora do eixo de lajes. As árvores PBR quebram a repetição das coníferas económicas e acrescentam estratificação de troncos e copas ao percurso. Apenas três troncos focais receberam colisão; o restante mantém-se visual para preservar custo e passagem. O corredor de navegação permanece aberto, evitando a leitura de muro vegetal.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 3 | Captura 1280×720 | Trilho, vegetação em camadas e abertura de navegação preservados. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase158_ForestCanopies_Validated.zip`

SHA-256:

`52683c1dd997320fd9b14bc1bd999400e1ed1f1ac3399aa0b0ac078779a437d4`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase116_take3_forest_wayfinding.png` | Evidência visual da Floresta Densa. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
