# ORIGEM — Checkpoint 186: Rochas no Leito do Rio da Estrada do Rio

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `04da5aa` — `feat(river): add 4 submerged bed rocks for depth reading`.

## Incremento aplicado

Quatro rochas submersas foram adicionadas ao nó `RioDaEstrada_Norte` em posições distribuídas ao longo do curso do rio (z=28, 52, 76, 102). Cada rocha emerge ligeiramente acima da lâmina de água (by = média de altura + 0.08 m) e recebe um material de pedra molhada com emissão mínima para manter a leitura no crepúsculo de compatibilidade. A escala Y é 62% da escala XZ para simular um perfil achatado de rocha de leito. Não foram adicionados colisores, pois o jogador não atravessa o rio.

| Posição Z | Deslocamento X | Escala | Yaw |
|---|---|---|---|
| 28 | −1.4 | 0.32 | 0.42 |
| 52 | +1.8 | 0.28 | −1.12 |
| 76 | −0.6 | 0.36 | 2.34 |
| 102 | +1.2 | 0.30 | −0.78 |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase186_RiverBedRocks_Validated.zip`

SHA-256:

`91e517e1b4726e98bdaaebecb3ca6b248a1ba8a6b47671003ba07b1798d31b17`

## Próximas prioridades (por ordem de impacto visual)

1. **Auditoria de Takes 1–9** — recapturar e confirmar que todos os refinamentos dos CPs 144–186 são visíveis nos enquadramentos cinematográficos.
2. **Variação de rotação das lajes de percurso** — pequenas rotações aleatórias nas lajes da Floresta Densa para naturalizar o pavimento.
3. **Luz de preenchimento do Arco das Ruínas** — verificar se o Arco ainda tem leitura adequada após os refinamentos de crepúsculo.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
