# ORIGEM — Checkpoint 124: Leitura da Bacia das Ruínas Submersas

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 4–6 / Takes 9–11 corrigidos.
**Estado:** validado localmente; commit preparado para futura sincronização quando a autenticação GitHub estiver disponível.

## Incremento contínuo

A superfície de água das Ruínas Submersas foi recalibrada para responder melhor ao crepúsculo no renderizador de compatibilidade. O albedo frio, as ondas amplas e a emissão de baixa intensidade foram ajustados de forma conjunta para separar a bacia do terreno escuro e aumentar a leitura dos pilares, sem converter o lago numa superfície ciano artificial ou luminosa.

A chegada física permanece suportada por lajes com colisores próprios, pela rota Acampamento Majestic–Trilho Florestal e pelo corredor de margem. A captura do Take 11 mantém a bacia e a serra distante no mesmo enquadramento, enquanto o gameplay de 30 segundos confirma que o passe visual não introduziu regressões técnicas.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado. |
| Take 11 | Captura de 1600×900 concluída com água recalibrada. |
| Gameplay | 30 segundos concluídos sem `Parse Error` ou falha de carregamento. |
| Fronteira | Nenhuma alteração em Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase118_take11_majestic_lake_transition.png` | Evidência visual de alta resolução da bacia. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay estável. |
| `ORIGEM_V2_RegionalWorld_Phase124_LakeReadability_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase124_LakeReadability_Validated.sha256` | SHA-256 `ae045ad6e4f09de87ebd594848ca0cb973acf5920b1f9c277ad3a259bcc9b449`. |

> O checkpoint é uma evidência de execução; o desenvolvimento nas Regiões 1–6 permanece contínuo.
