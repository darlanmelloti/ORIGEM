# ORIGEM — Checkpoint 171: Sinais P-0 Discretos

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `824b4cd` — `feat(forest): soften p0 route markers`.

## Incremento aplicado

Os três sinais P-0 da Floresta Densa mantêm a função narrativa temporal, mas receberam emissão azul reduzida, intensidade inferior e menor alcance de luz. A orientação quente do percurso preserva prioridade, enquanto os marcos deixam de competir como pontos luminosos artificiais no corredor Majestic–lago.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 9 | Captura 1600×900 | Corredor regional com sinais P-0 menos proeminentes. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase171_SubtleP0_Validated.zip`

SHA-256:

`66f5a3f2ca3ad2c234a9f3797d5cdea8a28e950c32b040333e2484711ed27b97`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase123_take9_majestic_connector.png` | Evidência visual do corredor Majestic–lago. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
