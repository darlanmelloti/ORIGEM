# ORIGEM — Checkpoint 156: Legibilidade Interior da Casa Voss

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `9631fbb` — `feat(voss): improve interior twilight readability`.

## Incremento aplicado

A Casa Voss recebeu uma resposta de luz e material própria para o renderizador de compatibilidade. Foram introduzidos preenchimentos localizados no interior e no limiar, uma luz prática da mesa de Tomás e uma resposta residual controlada nos materiais de madeira interior, latão e pedra. O resultado mantém o exterior noturno e o carácter íntimo do prólogo, mas deixa a estrutura, a janela, o piso, a parede de pedra e os objetos narrativos discerníveis sem depender exclusivamente da lanterna de Elias.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Interior após prólogo | Captura em gameplay real, 1280×720 | Estrutura, pedra, piso e elementos narrativos legíveis. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `VossHouse.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase156_VossInteriorReadability_Validated.zip`

SHA-256:

`2bb9bd4efb0eabfd751e5b8499a3f09a8ea23835366a0e5244388ee25503e4ab`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase156_voss_interior_lighting.png` | Captura de gameplay do interior após o prólogo. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência estável de prólogo, porta e exterior. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
