# ORIGEM — Checkpoint 127: Estela da Chegada às Ruínas Submersas

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 1–6; implementação focada na Região 6.
**Estado:** validado localmente e pronto para commit/sincronização futura.

## Incremento contínuo

A margem ocidental da bacia ganhou a **Estela da Chegada**, uma coluna antiga com colisão, brilho azul contido e grupo `interactable`. Ela fica na aproximação física das Ruínas Submersas e reutiliza o identificador narrativo `RuneP0_02`, produzindo a mensagem de lore já prevista no orquestrador principal quando Elias a examina com `[E]`.

A função da estela é substituir a chegada silenciosa por um primeiro ponto explorável: ela confirma a descoberta da bacia, orienta o olhar para os pilares e mantém a progressão inteiramente dentro da Floresta Densa, Acampamento Majestic e Ruínas Submersas. Nenhum módulo das Regiões 7–12 foi carregado ou modificado.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado. |
| Take 11 | Captura de 1600×900 com bacia e estela ativa. |
| Travessia real | Roteiro Majestic–lago concluído em 30 segundos; stamina final 76/100. |
| Estela | `StaticBody3D`, colisão, brilho e grupo `interactable` presentes. |
| Fronteira | Nenhuma alteração em Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase118_take11_majestic_lake_transition.png` | Take de alta resolução da margem e da bacia. |
| `origem_v2_phase126_majestic_to_lake_30s.png` | Gameplay real da chegada ao lago. |
| `ORIGEM_V2_RegionalWorld_Phase127_LakeArrivalStela_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase127_LakeArrivalStela_Validated.sha256` | SHA-256 `00a7004c814cadb948cf9d9729445d3be83204c1bf65f95f0eae0263393e8354`. |

> A documentação é evidência de avanço. O ciclo dentro das Regiões 1–6 continua sem aguardar nova autorização.
