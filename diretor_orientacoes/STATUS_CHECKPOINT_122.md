# ORIGEM — Checkpoint 122: Acampamento Majestic Físico

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 4–6 / Takes 10–11 corrigidos.
**Estado:** validação concluída; alterações preservadas localmente e preparadas para sincronização quando a autenticação GitHub estiver disponível.

## Incremento contínuo

O Acampamento Majestic passou de uma composição apenas visual para uma estação de expedição física. As quatro tendas possuem `StaticBody3D` e `CollisionShape3D`, impedindo atravessamento através da lona enquanto preservam o anel central e o acesso exterior. Foram acrescentados anel de pedras no fogo, caixas de campo com colisores, três tochas de expedição e preenchimento de crepúsculo localizado.

A composição de QA do Take 10 foi aproximada para documentar o acampamento sem introduzir qualquer câmera, geometria ou activo das Regiões 7–12. A leitura da montanha continua distante, e a continuidade para o lago permanece no Take 11.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado, sem erro de GDScript. |
| Take 10 | Captura de 1600×900 concluída com câmara de QA ativa. |
| Gameplay | 30 segundos concluídos sem `Parse Error` ou falha de carregamento. |
| Colisão do acampamento | Quatro volumes de tenda e três caixas de campo acrescentados. |
| Fronteira das regiões | Nenhuma alteração em Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase122_take10_majestic_physical.png` | Evidência de alta resolução do Acampamento Majestic. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay estável. |
| `ORIGEM_V2_RegionalWorld_Phase122_MajesticPhysicalCamp_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase122_MajesticPhysicalCamp_Validated.sha256` | SHA-256 `098bb1f093a0fcd09030f17ab021ca13dc85bc04f4a75fa062422a6f2f1a42db`. |

> O commit é evidência de produção, não uma pausa. A continuação automática dentro das Regiões 1–6 permanece obrigatória.
