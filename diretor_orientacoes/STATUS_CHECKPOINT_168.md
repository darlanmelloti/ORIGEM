# ORIGEM — Checkpoint 168: Take 10 do Acampamento Majestic

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `a89b1a0` — `feat(cinematic): frame majestic camp as expedition station`.

## Incremento aplicado

O Take 10 foi elevado e aberto para apresentar o Acampamento Majestic como uma estação de expedição completa. A nova perspetiva enquadra o anel de quatro tendas, as lajes rasas, a fogueira, a mesa de cartografia, as caixas de campo e o suporte de expedição. A alteração é exclusivamente cinematográfica: não muda colisores, o percurso de Elias ou módulos fora das Regiões 1–6.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 10 | Captura 1600×900 | Tendas, fogueira, cartografia e equipamentos lidos como estação organizada. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RegionalCinematicDirector.gd` | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase168_MajesticCinematic_Validated.zip`

SHA-256:

`0d76639c7542aed877cab9570d8611f822473718296d2fb4888262b952ebbb2b`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase122_take10_majestic_physical.png` | Evidência visual do Acampamento Majestic. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
