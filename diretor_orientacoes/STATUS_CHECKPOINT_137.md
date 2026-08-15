# ORIGEM — Checkpoint 137: Crepúsculo Litúrgico com Leitura Regional

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 1–6; calibração ambiental aplicada ao Vale de Kheper ativo.
**Estado:** validado e preservado localmente; pronto para commit e sincronização futura.

## Incremento contínuo

O perfil de crepúsculo litúrgico foi recalibrado para preservar a paleta azul-fria e a direção quente do sol, enquanto recupera detalhes no terreno, na vegetação, no Acampamento Majestic e na bacia das Ruínas Submersas. O ajuste eleva moderadamente a contribuição ambiente, a exposição cinematográfica e a luz solar, e reduz de forma subtil a densidade de neblina.

A alteração permanece focada na leitura explorável do bloco de Regiões 1–6. Não foram alteradas geometrias, câmaras, ativos ou módulos das Regiões 7–12.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado. |
| Take 10 | Captura de alta resolução concluída; acampamento e horizonte mais legíveis. |
| Gameplay normal | 30 segundos concluídos sem `Parse Error` ou falha de script. |
| Direção artística | Mantém crepúsculo litúrgico; não converte o vale em cena diurna. |
| Fronteira | Nenhuma alteração nas Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase122_take10_majestic_physical.png` | Evidência visual após a recalibração. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência do gameplay de 30 segundos. |
| `ORIGEM_V2_RegionalWorld_Phase137_TwilightLegibility_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase137_TwilightLegibility_Validated.sha256` | SHA-256 `3d0a4a6db94779ef3fff695cd75d6a9bcea548d801afc28105deafa6bf43fa55`. |

> O checkpoint é evidência. A consolidação automática das Regiões 1–6 permanece ativa.
