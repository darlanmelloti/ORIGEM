# ORIGEM — Checkpoint 138: Materialidade do Acampamento Majestic

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 1–6; passe aplicado exclusivamente ao Acampamento Majestic, na Região 5.
**Estado:** validado e preservado localmente; pronto para commit e sincronização futura.

## Incremento contínuo

As tendas do Acampamento Majestic deixaram de depender apenas de cor plana. Foi criada e integrada uma textura de lona de expedição envelhecida, com trama de tecido, remendos e costuras visíveis. O material conserva alta rugosidade, resposta difusa de baixa intensidade ao crepúsculo e filtragem anisotrópica com mipmaps, mantendo o orçamento da GTX 1050 Ti.

O spawn de QA da estela lacustre também foi tornado resiliente ao carregamento procedural regional. Este auxiliar é isolado por variável de ambiente e não altera o fluxo jogável normal.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado; textura importada corretamente. |
| Take 10 | Captura 1600×900 concluída; tecido das tendas apresenta variação material visível. |
| Gameplay normal | 30 segundos concluídos sem `Parse Error` ou falha de script. |
| Limite regional | Nenhuma alteração em módulos, geometrias ou câmaras das Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `assets/textures/generated/majestic_weathered_canvas_albedo.png` | Textura de lona envelhecida integrada nas tendas. |
| `origem_v2_phase122_take10_majestic_physical.png` | Evidência visual do acampamento texturizado. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência do gameplay normal de 30 segundos. |
| `ORIGEM_V2_RegionalWorld_Phase138_TexturedMajestic_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase138_TexturedMajestic_Validated.sha256` | SHA-256 `432ff728c42fb2c1385f62d8ce06988f654bbb40f3330620d717f2d19961d025`. |

> O checkpoint é evidência. O desenvolvimento automático das Regiões 1–6 permanece ativo.
