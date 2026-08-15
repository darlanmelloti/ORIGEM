# ORIGEM — Checkpoint 123: Ligação Majestic–Trilho–Lago

**Branch:** `feature/dev1-gameplay-core`
**Escopo:** Regiões 4–6, Takes 9–11 corrigidos.
**Estado:** validado localmente; commit preparado para sincronização assim que a autenticação GitHub esteja disponível.

## Continuidade entregue

Foi criada uma ligação de expedição com 29 lajes entre o Acampamento Majestic e o trilho da Floresta Densa em `z≈178`. Quatorze lajes possuem colisores próprios e três sinais de expedição de baixa intensidade. A ligação termina no trilho florestal existente, que continua em direção ao corredor ribeirinho e às Ruínas Submersas. Assim, o acampamento deixou de ser um cenário separado e passou a integrar a rota física das Regiões 4–6.

O Take 9 de QA foi adicionado para mostrar a relação espacial entre o acampamento, a ligação em lajes, a floresta e a serra distante. O Take 10 mantém a verificação próxima das colisões das tendas, e o Take 11 mantém a chegada à bacia lacustre.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado. |
| Take 9 | Captura de 1600×900 concluída; ligação visível. |
| Gameplay | 30 segundos concluídos sem `Parse Error` ou falha de carregamento. |
| Colisão | Conector com 14 volumes físicos; acampamento mantém tendas e caixas físicas. |
| Fronteira | Nenhuma alteração nas Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase123_take9_majestic_connector.png` | Evidência de alta resolução da rota física. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay estável. |
| `ORIGEM_V2_RegionalWorld_Phase123_MajesticConnector_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase123_MajesticConnector_Validated.sha256` | SHA-256 `474847b5c280116e78f8cafa6e29ed9e3a8aca1e068685e17b81772e230aa4b1`. |

> O ciclo continua automaticamente nas Regiões 1–6; este registo não representa uma pausa de desenvolvimento.
