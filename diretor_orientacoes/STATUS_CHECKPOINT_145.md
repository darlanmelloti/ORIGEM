# ORIGEM — Checkpoint 145: Leitura das Ruínas Submersas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `5efd14a` — `feat(lake): improve submerged ruins readability`.

## Incremento aplicado

O lago das Ruínas Submersas recebeu uma revisão de leitura compatível com o renderizador GL: a água passou a usar variação de cor, emissão baixa e especularidade mais definida, enquanto o material de ruína recebeu uma resposta residual de luminância para preservar musgo e silhuetas em crepúsculo. Três balizas arqueológicas de alcance reduzido passaram a acompanhar os marcos emergentes. O Take 11 foi reenquadrado para aproximar o olhar do lago e reduzir a dispersão visual do vale.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Composição lacustre | Take 11, 1600×900 | Água, lajes rasas e pilares emergentes mais reconhecíveis. |
| Gameplay base | Prólogo, porta `[E]` e exterior | 30 segundos concluídos. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | 30 segundos concluídos, sem bloqueio reportado. |
| Fronteira operacional | Alterações em `ForestLakeRegion.gd` e Take 11 | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase145_SubmergedRuins_Readability_Validated.zip`

SHA-256:

`f95de0fdc19e60b53a0b3f37f981050355197dd29be7650e3ed0976099f41352`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase118_take11_majestic_lake_transition.png` | Take 11 reenquadrado das Ruínas Submersas. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência do percurso físico de 30 segundos. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |

> O checkpoint é uma evidência, não uma pausa. O próximo passe permanece nas Regiões 1–6 e dará prioridade à interação da Estela de Memória do Acampamento Majestic e à continuidade visual Casa Voss → lago.
