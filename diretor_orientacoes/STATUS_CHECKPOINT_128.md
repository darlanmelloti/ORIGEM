# ORIGEM — Checkpoint 128: Interação da Estela Lacustre

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 1–6; ajuste focado na chegada às Ruínas Submersas.
**Estado:** validado e preservado localmente; commits aguardam autenticação GitHub disponível.

## Correção de jogabilidade

A auditoria do raycast revelou que a `InteractRay` de Elias usa `collision_mask = 4`, enquanto a Estela da Chegada tinha sido criada na camada física padrão. A estela foi corrigida para `collision_layer = 4`, alinhando o `StaticBody3D` com o sistema de interação `[E]` já usado pelos objetos do vale.

O modo de QA foi separado do jogo normal. `ORIGEM_QA_ROUTE` e `ORIGEM_QA_INTERACT` suprimem apenas prólogo e cartelas narrativas no contexto de teste, preservando a abertura normal da Casa Voss. Um primeiro ensaio de interação revelou um atraso de carregamento no renderizador de compatibilidade; a validação normal de 30 segundos foi repetida depois da correção, sem `Parse Error` nem falha de carregamento.

| Verificação | Resultado |
|---|---|
| Camada da estela | `collision_layer = 4`, compatível com a `InteractRay`. |
| Godot 4.7.1 headless | Aprovado. |
| Gameplay normal | 30 segundos estáveis após o ajuste de QA. |
| Fronteira | Nenhuma alteração em Regiões 7–12. |
| GitHub | Push pendente; a reativação do conector foi recusada na sessão, portanto não houve reescrita ou perda de histórico local. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase113_twilight_stable_30s.png` | Gameplay normal estável após o ajuste. |
| `origem_v2_phase128_lake_stela_interaction.png` | Diagnóstico de carregamento da prova de interação. |
| `ORIGEM_V2_RegionalWorld_Phase128_LakeInteractionLayer_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase128_LakeInteractionLayer_Validated.sha256` | SHA-256 `104e8eab7a30d4180351c8d7cf36137fc3a9736b37d54e2d3689c9c95c031cf4`. |

> O desenvolvimento continua dentro das Regiões 1–6. A sincronização remota será retomada sem reescrever o histórico quando a autenticação estiver disponível.
