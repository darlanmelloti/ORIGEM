# ORIGEM — Checkpoint 131: Ponte de Pedra Física do Vale

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 1–6; implementação focada na Região 2 — ponte sobre o rio do vale inicial.
**Estado:** validado e preservado localmente; pronto para commit e sincronização quando a autenticação GitHub estiver disponível.

## Incremento contínuo

A Ponte de Pedra do Vale deixou de depender exclusivamente da malha CC0 para a travessia. Foi introduzida uma plataforma estática baixa, rotacionada com o ativo e dimensionada para o tabuleiro, permitindo atravessar o rio sem cair através da geometria visual. A intervenção mantém a água, a vegetação de margem e as Regiões 7–12 inalteradas.

Foi acrescentado um spawn técnico `bridge_crossing`, ativado apenas por `ORIGEM_QA_ROUTE=bridge_crossing`, para permitir futuras provas automáticas de travessia sem alterar o spawn normal de Elias.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado. |
| Roteiro QA | Sessão de 30 segundos executada no modo de travessia da ponte, sem erro de carregamento. |
| Gameplay normal | 30 segundos estáveis após a alteração. |
| Colisão | Plataforma física alinhada à ponte; o rio permanece visualmente inalterado. |
| Fronteira | Nenhuma alteração nas Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase131_bridge_crossing_30s.png` | Evidência da sessão de travessia QA. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay normal estável. |
| `ORIGEM_V2_RegionalWorld_Phase131_ValleyBridgePhysical_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase131_ValleyBridgePhysical_Validated.sha256` | SHA-256 `c3d125645705985fba1adc65fe9afff933b6b48c40d3b334fddb356655a9a591`. |

> O checkpoint é apenas evidência. A consolidação automática das Regiões 1–6 continua ativa.
