# ORIGEM — Checkpoint 195: Ecologia da Curva Sul do Rio

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `15f9f7b` — `feat(river): add south bend ecology - 3 rocks and 2 ferns at z=112-138`.

## Incremento aplicado

Foi adicionada a função `_build_south_bend_ecology()` ao `RiverRoadJourney.gd`, que popula a zona z=112–138 da curva sul do rio com 3 pedras de margem e 2 fetos. Esta zona estava identificada como vazia na auditoria do CP 187. Os elementos estão posicionados lateralmente ao curso do rio (offset 5.6–6.2 m do centro) para não obstruir a estrada.

| Elemento | Posição Z | Lado | Escala |
|---|---|---|---|
| Rocha 1 | 112 | Esquerdo | 0.28 |
| Feto 1 | 118 | Direito | 0.44 |
| Rocha 2 | 124 | Direito | 0.32 |
| Feto 2 | 132 | Esquerdo | 0.40 |
| Rocha 3 | 138 | Esquerdo | 0.24 |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível: `/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase195_SouthBendEcology_Validated.zip`

SHA-256: `6d3119ab0068d0e45009ec0604b34cc132b7e727c972c92fece67991aaa237c5`

## Estado dos commits pendentes de push

Os commits `9f783dc`, `37e5f42`, `fa8b15a`, `15f9f7b` (e anteriores) estão criados localmente mas aguardam push para o GitHub. O push será executado assim que a autenticação GitHub estiver disponível nesta sessão.

## Próximas prioridades

1. **CP 196 — Auditoria final de Takes 1–11** — recapturar todos os takes para confirmar que os refinamentos dos CPs 182–195 são visíveis nos enquadramentos cinematográficos.
2. **Push de todos os commits pendentes** — sincronizar os CPs 194 e 195 com o repositório remoto.
3. **CP 197 — Passe de luz ambiente da Floresta Densa** — a floresta ainda tem zonas de sombra densa; adicionar uma OmniLight3D de preenchimento frio no corredor central.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
