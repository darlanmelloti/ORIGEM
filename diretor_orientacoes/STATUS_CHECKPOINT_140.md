# ORIGEM — Checkpoint 140: Fogueira Física do Acampamento Majestic

**Branch:** `feature/dev1-gameplay-core`
**Escopo:** Regiões 1–6. Alteração restrita ao Acampamento Majestic, Região 5.
**Estado:** validado e preservado localmente; pronto para commit e sincronização futura.

## Incremento contínuo

O anel de oito pedras da fogueira recebeu colisores esféricos discretos. Elias já não atravessa visualmente as pedras da estação de expedição, mas a passagem entre as quatro tendas e o acesso ao corredor lacustre permanece livre. A fogueira e as tochas continuam a usar a oscilação determinística de luz de baixo custo introduzida no checkpoint anterior.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado, sem `Parse Error`. |
| Take 10 | Captura 1600×900 concluída; tendas, fogo e perímetro mantêm composição legível. |
| Gameplay normal | 30 segundos concluídos sem falha de script. |
| Fronteira regional | Sem alterações nas Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase122_take10_majestic_physical.png` | Captura do acampamento com o anel físico. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay de 30 segundos. |
| `ORIGEM_V2_RegionalWorld_Phase140_PhysicalCampfire_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase140_PhysicalCampfire_Validated.sha256` | SHA-256 `bee1fe3f9ba13098072d2ecf2e6be37be68c4f6ec7335c27c80e75177237ea18`. |

> O checkpoint é apenas evidência de continuidade; o desenvolvimento automático das Regiões 1–6 permanece ativo.
