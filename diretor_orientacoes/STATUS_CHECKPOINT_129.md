# ORIGEM — Checkpoint 129: Arco das Ruínas Físico

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 1–6; implementação focada na Região 3 — Arco das Ruínas.
**Estado:** validado e preservado localmente; pronto para commit e sincronização quando a autenticação GitHub estiver disponível.

## Incremento contínuo

A auditoria da Estrada do Rio identificou que os dois núcleos de alvenaria do Arco das Ruínas tinham presença visual, mas não volumes físicos. Foram adicionados corpos estáticos e colisores cúbicos alinhados com cada pilar, preservando o vão central entre as colunas para não obstruir a rota Casa Voss → Estrada do Rio → Arco → Floresta.

O marcador passou a responder como arquitetura explorável, impedindo Elias de atravessar a pedra lateralmente, sem introduzir uma parede invisível na estrada. As brasas litúrgicas, as lajes e a silhueta distante mantêm-se inalteradas.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado. |
| Take 2 | Captura concluída; arco, brasas e estrada permanecem legíveis. |
| Gameplay | 30 segundos estáveis, sem `Parse Error` nem falha de carregamento. |
| Colisão | Dois volumes físicos coincidentes com a alvenaria lateral; vão central livre. |
| Fronteira | Nenhuma alteração nas Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase117_take2_road_arch.png` | Evidência visual do Arco das Ruínas. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay estável. |
| `ORIGEM_V2_RegionalWorld_Phase129_RuinArchPhysical_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase129_RuinArchPhysical_Validated.sha256` | SHA-256 `f07bda18414ca05be7fbe148d03f752b127773bee436ef8ce471f232e79f178b`. |

> O checkpoint é apenas um marco de evidência. O desenvolvimento contínuo das Regiões 1–6 permanece ativo.
