# ORIGEM — Checkpoint 146: Estela de Memória do Acampamento Majestic

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `9402ca4` — `test(interaction): validate majestic memory stela`.

## Incremento aplicado

Foi acrescentado o modo `ORIGEM_QA_INTERACT=majestic_stela` ao orquestrador regional. O spawn técnico localiza a Estela de Memória pelo nó real `RegiaoFlorestaLagoExploravel/AcampamentoMajestic/RuneP0_01`, coloca Elias no exterior do anel de tendas e orienta a câmara de primeira pessoa ao longo do eixo correto do raio de interação. O carregamento regional é imediato apenas nos modos de QA de interação; a entrada normal do jogo mantém o fluxo encenado.

A prova reprodutível `qa_majestic_stela_probe.gd` confirmou fisicamente o raio de 2,5 m contra o colisor da estela e simulou a ação `interact`, verificando no HUD a mensagem narrativa rúnica.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Alcance de interação | `qa_majestic_stela_probe.gd` | Alvo `RuneP0_01` confirmado pelo RayCast3D. |
| Ação equivalente a `[E]` | HUD de `main.gd` | Mensagem validada: `RUNAS: A água recorda aquilo que o tempo tentou apagar.` |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Corredor regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase146_MajesticStela_Validated.zip`

SHA-256:

`c728a26440586f225971491e89c7eb0102685852f952ede15eaca6262f2b1ac3`

## Artefactos e scripts de QA

| Ficheiro | Finalidade |
|---|---|
| `qa_majestic_stela_probe.gd` | Validação de raio, ação de interação e mensagem de HUD. |
| `/home/ubuntu/test_checkpoint146_majestic_stela_interaction.sh` | Captura auxiliar em GL Compatibility. |
| `/home/ubuntu/origem_v2_phase146_majestic_stela_interaction.png` | Evidência visual da sessão de QA. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de percurso físico de 30 segundos. |

> O checkpoint é uma evidência, não uma pausa. O próximo ciclo permanece limitado às Regiões 1–6 e continuará com a continuidade visual Casa Voss → Estrada do Rio → Arco → Floresta → Acampamento Majestic → Ruínas Submersas.
