# ORIGEM — Checkpoint 126: Travessia Física Majestic–Lago

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 1–6, com validação focada nas Regiões 4–6.
**Estado:** validado localmente; pronto para commit e sincronização quando a autenticação GitHub estiver disponível.

## Resultado obrigatório comprovado

A validação deixou de depender apenas de uma câmara cinematográfica. Foi adicionado o modo isolado `ORIGEM_QA_ROUTE=majestic_to_lake`, que coloca Elias na entrada da ligação de lajes do Acampamento Majestic, suprime exclusivamente o prólogo e as cartelas narrativas durante QA, e preserva intacto o fluxo normal do jogo.

O roteiro de gameplay mantém corrida física durante aproximadamente 30 segundos: segue a ligação Majestic–Trilho em X, roda para o corredor florestal e alcança a bacia lacustre em Z. A captura final comprova que Elias está no setor do lago, com **stamina a 76/100**, confirmando movimento real sob custo de corrida e sem retorno à Casa Voss. A primeira execução revelou que o prólogo substituía o spawn; essa regressão foi corrigida antes da validação final.

| Verificação | Resultado |
|---|---|
| Spawn de QA | Elias iniciado em `(-77.4, 2.170144, 178.0)`. |
| Prólogo e cartelas de QA | Suprimidos apenas quando `ORIGEM_QA_ROUTE` está ativo. |
| Rota física | Atravessou ligação em lajes, corredor florestal e chegou à bacia. |
| Stamina | 76/100 no fotograma final; deslocação física confirmada. |
| Godot 4.7.1 | Validação headless aprovada. |
| Fronteira | Nenhuma alteração em Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `test_checkpoint126_majestic_to_lake_30s.sh` | Roteiro reproduzível da travessia real. |
| `origem_v2_phase126_majestic_to_lake_30s.png` | Fotograma final da chegada física ao setor lacustre. |
| `ORIGEM_V2_RegionalWorld_Phase126_MajesticToLakeRoute_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase126_MajesticToLakeRoute_Validated.sha256` | SHA-256 `9afc30fd5b5f5b40ed0bf0c0b7d9bc92a8572ff44e8dd03597e97f02416897f2`. |

> Este checkpoint é evidência de desenvolvimento contínuo, não uma pausa. A próxima auditoria permanece limitada às Regiões 1–6.
