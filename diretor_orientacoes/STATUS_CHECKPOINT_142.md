# ORIGEM — Checkpoint 142: Enquadramento do Acampamento Majestic

**Branch:** `feature/dev1-gameplay-core`
**Escopo:** Regiões 1–6; alteração limitada à câmara de QA do Acampamento Majestic, Região 5.
**Estado:** validado e preservado localmente; pronto para commit e sincronização futura.

## Incremento contínuo

O Take 10 recebeu um enquadramento mais próximo e uma distância focal de 40°. A câmara passa a privilegiar as tendas texturizadas, a fogueira e a área física do acampamento, mantendo o percurso em lajes e a silhueta das montanhas como contexto de fundo. A alteração só afeta o modo de captura de QA; não interfere na câmara do jogador nem no fluxo normal de gameplay.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado, sem `Parse Error`. |
| Take 10 | Captura 1600×900 concluída com foco mais próximo no Acampamento Majestic. |
| Gameplay normal | 30 segundos concluídos sem falha de script. |
| Fronteira regional | Sem alteração em módulos das Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase122_take10_majestic_physical.png` | Captura do Take 10 reenquadrado. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay de 30 segundos. |
| `ORIGEM_V2_RegionalWorld_Phase142_MajesticCamera_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase142_MajesticCamera_Validated.sha256` | SHA-256 `fbdda22d156a97c747bbe901f50b6fe45c55f6267ccf8c8b0525c01a25eab9af`. |

> O checkpoint é evidência de progresso e não encerra o desenvolvimento automático das Regiões 1–6.
