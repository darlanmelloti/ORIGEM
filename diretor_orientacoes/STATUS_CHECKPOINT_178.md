# ORIGEM — Checkpoint 178: Inicialização Robusta de Rotas QA

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `97d228d` — `fix(qa): initialize route spawns in restored world`.

## Incremento aplicado

O orquestrador regional passou a enfileirar os modos de rota QA mesmo quando o `TerrainPatch` já existe na cena restaurada. O fluxo também constrói o mundo regional antecipadamente em `ORIGEM_QA_ROUTE`, alinhando o comportamento das rotas de teste com os modos de captura e interação já validados. A alteração não muda o spawn normal nem módulos das Regiões 7–12.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Rota de ponte | `ORIGEM_QA_ROUTE=bridge_crossing` | Spawn técnico confirmado no acesso físico da Ponte de Pedra. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `TempleLevel.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase178_QARouteInitialization_Validated.zip`

SHA-256:

`4ef83531713e1465190116f5a74eb469c5ad2e69eb3c7897ade5b9bb67e0ab69`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase178_bridge_crossing_30s.png` | Evidência de execução da prova automatizada da Ponte de Pedra. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
