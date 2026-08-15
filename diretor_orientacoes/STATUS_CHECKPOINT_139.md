# ORIGEM — Checkpoint 139: Acampamento Majestic Vivo

**Branch:** `feature/dev1-gameplay-core`
**Escopo:** Regiões 1–6 apenas. O passe foi limitado ao Acampamento Majestic, dentro da Região 5.
**Estado:** validado, preservado localmente e pronto para commit.

## Incremento contínuo

O Acampamento Majestic passou a ter animação subtil e determinística na fogueira central e nas três tochas de expedição. A luz oscila entre 76% e 100% da energia base, em frequências ligeiramente diferentes, enquanto a malha da chama recebe uma variação vertical discreta. A solução mantém todas as sombras dinâmicas desativadas e não usa partículas, preservando o orçamento da GTX 1050 Ti.

A lona de expedição texturizada e a estação física criadas no checkpoint anterior permanecem ativas. Este passe acrescenta vida ambiental sem expandir o mundo, alterar a rota ou tocar nos módulos das Regiões 7–12.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado, sem `Parse Error`. |
| Take 10 do Acampamento | Captura 1600×900 concluída com a estação de expedição visível. |
| Gameplay normal | 30 segundos concluídos sem falha de script. |
| Limite regional | Nenhuma alteração em Vila Elevada, Observatório, Trilha da Montanha, Caverna, Câmara ou Hub Temporal. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase122_take10_majestic_physical.png` | Captura do Acampamento Majestic. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay de 30 segundos. |
| `ORIGEM_V2_RegionalWorld_Phase139_AnimatedMajestic_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase139_AnimatedMajestic_Validated.sha256` | SHA-256 `d2ca5c9c0cd40f794a7c5a4346929bd2847992706f6128967e7a0ca3831071d5`. |

> O checkpoint marca uma evidência de progresso. A continuação automática dentro das Regiões 1–6 permanece ativa.
