# ORIGEM — Checkpoint 193: Pedras de Base do Arco das Ruínas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `8b046c8` — `feat(arch): add base rocks at ruin arch pillars for archaeological read`.

## Incremento aplicado

Foram adicionadas 2 pedras de base nos pilares do Arco das Ruínas (`_build_ruin_arch` no `RiverRoadJourney.gd`), posicionadas em `(-3.25, -0.12, 0.55)` e `(3.25, -0.12, 0.55)` no espaço local do arco. As pedras têm escala assimétrica (0.34 e 0.30) e rotação ligeiramente diferente para criar uma transição orgânica entre os pilares e o solo, reforçando a leitura arqueológica do marco.

| Pilar | Posição local | Escala | Rotação Y |
|---|---|---|---|
| Esquerdo | `(-3.25, -0.12, 0.55)` | `0.34 × 0.58 × 0.34` | −0.72 rad |
| Direito | `(3.25, -0.12, 0.55)` | `0.30 × 0.58 × 0.30` | +0.72 rad |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 2 | `origem_v2_phase117_take2_road_arch.png` | Arco com pedras de base visíveis; silhueta arqueológica reforçada; trilho físico desobstruído. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível: `/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase193_ArchBaseRocks_Validated.zip`

SHA-256: `d0c42cd99ac4bd0cace5a3bf2f898ceca5f5dd3366a0facfaa3e33f7f059dd62`

## Ponto de situação geral (CPs 182–193)

A sessão atual completou 12 checkpoints de refinamento contínuo nas Regiões 1–6:

| CP | Módulo | Incremento |
|---|---|---|
| 182 | ForestLakeRegion | Copas focais de folha larga ampliadas |
| 183 | ForestLakeRegion | Fogueira do Acampamento Majestic reforçada |
| 184 | ForestLakeRegion | Iluminação subaquática das Ruínas Submersas |
| 185 | ForestLakeRegion | Variação de altura das coníferas |
| 186 | RiverRoadJourney | Rochas submersas no leito do rio |
| 187 | Auditoria | Takes 1–9 auditados |
| 188 | ForestLakeRegion | Acentos visuais no corredor Take 6 |
| 189 | ForestLakeRegion | Variação de rotação das lajes de percurso |
| 190 | ForestLakeRegion | Luz de preenchimento do Take 9 |
| 191 | ForestLakeRegion | Material de pedra molhada nas lajes de margem |
| 192 | RiverRoadJourney | Pedras emergentes no leito do rio |
| 193 | RiverRoadJourney | Pedras de base do Arco das Ruínas |

## Próximas prioridades

1. **Nota de direção sobre o Take 6** — remover ou transferir para a branch `dev2` o take que aponta para z=462–535.
2. **Auditoria final de Takes 1–11** — confirmar que todos os refinamentos dos CPs 182–193 são visíveis nos enquadramentos cinematográficos.
3. **Passe de micro-detalhes na Casa Voss** — verificar se a iluminação interior e o limiar de saída mantêm a qualidade após os refinamentos desta sessão.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
