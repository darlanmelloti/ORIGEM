# ORIGEM — Checkpoint 154: Interação da Estela de Chegada

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `1d52e2d` — `test(interaction): validate lake arrival stela`.

## Incremento aplicado

O modo de QA da Estela de Chegada deixou de usar coordenadas fixas e agora recupera `RuneP0_02` pelo nó real da cena regional. Assim, o spawn técnico acompanha a cota da água e os refinamentos futuros da margem. Foi acrescentada uma prova headless reprodutível que posiciona Elias, atualiza o RayCast3D, simula a ação `interact` e confirma a resposta de HUD sem depender do foco da janela X11.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Raio de interação | `qa_lake_stela_probe.gd` | Alvo `RuneP0_02` confirmado. |
| Ação equivalente a `[E]` | HUD de `main.gd` | Mensagem confirmada: `RUNAS: Os Kharu vigiam a nascente, mas não compreendem a memória que guardam.` |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiros alterados: `TempleLevel.gd`, QA local | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase154_LakeStelaInteraction_Validated.zip`

SHA-256:

`c2592d8cc8c2f2d206c104ffa3866f2e3d1a479a76f8501a0df8238972c66dc5`

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `qa_lake_stela_probe.gd` | Validação de posição, raio, interação e mensagem de HUD. |
| `/home/ubuntu/origem_v2_phase118_take11_majestic_lake_transition.png` | Evidência visual atual das Ruínas Submersas. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência da chegada física à margem. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
