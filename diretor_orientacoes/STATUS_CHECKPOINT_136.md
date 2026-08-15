# ORIGEM — Checkpoint 136: Ligação Majestic–Trilho Integralmente Física

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 1–6; implementação focada na transição Região 4 → Região 5.
**Estado:** validado e preservado localmente; pronto para commit e sincronização futura.

## Incremento contínuo

A ligação de expedição entre o Acampamento Majestic e o trilho da Floresta Densa passou a conter colisão em **todas** as 29 lajes. Antes, apenas lajes alternadas tinham volumes físicos; agora a linha de percurso mantém uma superfície tátil contínua, sem alterar o desenho da rota ou bloquear a floresta.

As três balizas de expedição mantêm a leitura de navegação para o corredor que conduz do acampamento à floresta e, subsequentemente, às Ruínas Submersas. A captura do Take 9 confirma a relação espacial entre acampamento, lajes e mata.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado. |
| Take 9 | Captura de alta resolução concluída. |
| Travessia Majestic–lago | Gameplay de 30 segundos concluído sem `Parse Error` ou falha de script. |
| Colisão | As 29 lajes do conector têm volumes físicos baixos e contínuos. |
| Fronteira | Nenhuma alteração nas Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase123_take9_majestic_connector.png` | Evidência visual da ligação Acampamento Majestic–Floresta. |
| `origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de gameplay de 30 segundos. |
| `ORIGEM_V2_RegionalWorld_Phase136_MajesticConnectorPhysical_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase136_MajesticConnectorPhysical_Validated.sha256` | SHA-256 `e0e226873450ea05c75a2e777cd3b56805fbddbe7bb9e1599d5f81a48810d368`. |

> O checkpoint é evidência. A consolidação automática das Regiões 1–6 permanece ativa.
