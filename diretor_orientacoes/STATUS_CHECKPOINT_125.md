# ORIGEM — Checkpoint 125: Margens Rochosas Físicas

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 4–6 / Takes 9–11 corrigidos.
**Estado:** validado localmente; pronto para commit e publicação assim que a autenticação remota estiver disponível.

## Incremento contínuo

As margens das Ruínas Submersas receberam colisão seletiva. As rochas exteriores passam a possuir volumes físicos apenas a cada três instâncias, reduzindo a possibilidade de Elias atravessar geometria visual e preservando a composição natural e descontínua da margem. A entrada ocidental foi deliberadamente excluída desses volumes, mantendo aberto o corredor principal vindo da floresta e do Acampamento Majestic.

O aterramento dos fetos ribeirinhos passou a reutilizar a altura calculada da rocha correspondente, eliminando diferenças de altura entre vegetação e margem. A bacia, os pilares e a serra distante mantêm-se visíveis no Take 11, sem qualquer alteração nas Regiões 7–12.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado. |
| Take 11 | Captura de 1600×900 concluída; entrada ocidental visível. |
| Gameplay | 30 segundos concluídos sem `Parse Error` ou falha de carregamento. |
| Colisão | Rochas externas com colisores seletivos; corredor de chegada preservado. |
| Fronteira | Nenhuma alteração em Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase118_take11_majestic_lake_transition.png` | Evidência da bacia e da margem. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay estável. |
| `ORIGEM_V2_RegionalWorld_Phase125_RiparianPhysicalMargins_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase125_RiparianPhysicalMargins_Validated.sha256` | SHA-256 `50ffd196bfc5b2e8a467a0bca56556438571ad5f6958d5d2195a1e704e17965e`. |

> O checkpoint é um marco de evidência. O desenvolvimento contínuo dentro das Regiões 1–6 mantém-se ativo.
