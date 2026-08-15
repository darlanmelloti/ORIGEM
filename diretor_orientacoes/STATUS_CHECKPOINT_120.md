# ORIGEM — Checkpoint 120: Guias de Margem e QA Estabilizado

**Branch:** `feature/dev1-gameplay-core`
**Escopo:** Regiões 4–6, dentro da fronteira exclusiva das Regiões 1–6.
**Estado técnico:** validado localmente e preservado; commit local será mantido pronto para sincronização assim que a autenticação GitHub estiver disponível.

## Incremento contínuo

A passagem física do Checkpoint 119 recebeu três guias de margem de baixa intensidade, colocadas alternadamente nas lajes de chegada. Elas reforçam a leitura da rota no crepúsculo sem criar uma cadeia de luzes moderna ou invadir a bacia. A permanência da câmara de QA foi ampliada para 70 segundos e a captura em 1600×900 foi deslocada para 42 segundos, impedindo que o screenshot seja registado durante o ecrã inicial ou após a câmara regressar ao jogador.

| Requisito | Resultado |
|---|---|
| Colliders no trecho final de chegada ao lago | Confirmados nas sete lajes de margem. |
| Leitura de percurso no crepúsculo | Reforçada por guias de luz quente de baixa intensidade. |
| Captura cinematográfica | Take 11 ativo em 1600×900 após carregamento completo. |
| Gameplay obrigatório | 30 segundos concluídos sem falha de carregamento ou `Parse Error`. |
| Limite Regiões 7–12 | Nenhum módulo externo à frente principal foi editado. |

## Artefactos preservados

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase118_take11_majestic_lake_transition.png` | Composição final de QA do corredor e bacia. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay de 30 segundos. |
| `ORIGEM_V2_RegionalWorld_Phase120_ShoreGuides_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase120_ShoreGuides_Validated.sha256` | SHA-256 `1ff4dd8d0536b21addf7c3206e747df0fe81a5d3cd0cae72a48b0cae87ca7077`. |

> O desenvolvimento não aguarda a auditoria do diretor: a publicação é evidência e o próximo passe prossegue automaticamente no âmbito permitido.
