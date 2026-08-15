# ORIGEM — Checkpoint 130: Estrada do Rio Física

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 1–6; implementação focada na Região 2 — Estrada do Rio.
**Estado:** validado e preservado localmente; pronto para commit e sincronização quando a autenticação GitHub estiver disponível.

## Incremento contínuo

As 38 lajes da Estrada do Rio receberam volumes físicos baixos e alinhados à rotação individual da malha. O jogador passa a sentir a rota como uma sequência de pedra assentada sobre o terreno, enquanto a espessura reduzida dos volumes evita degraus artificiais e mantém a estrada transitável até ao Arco das Ruínas.

A intervenção complementa o Checkpoint 129: os pilares laterais do arco bloqueiam atravessamento de arquitetura, e as lajes que conduzem a ele fornecem uma continuidade física legível desde a Casa Voss. O curso central do arco e as áreas de vegetação adjacentes permanecem livres.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado. |
| Take 2 | Captura concluída; lajes, arco e brasas mantêm leitura clara. |
| Gameplay | 30 segundos estáveis, sem `Parse Error` ou falhas de carregamento. |
| Colisão | 38 volumes baixos rotacionados com as lajes; sem bloqueio do vão do arco. |
| Fronteira | Nenhuma alteração nas Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase117_take2_road_arch.png` | Evidência visual da estrada e do arco. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay estável. |
| `ORIGEM_V2_RegionalWorld_Phase130_RiverRoadPhysical_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase130_RiverRoadPhysical_Validated.sha256` | SHA-256 `080360a33d0ef34609a96f5f6bd16b9ef99ea2b69510292b528831b091e9fca4`. |

> O checkpoint é um marco de evidência. O desenvolvimento nas Regiões 1–6 prossegue sem pausa.
