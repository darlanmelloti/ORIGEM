# CP-CINE-28 — Gatilho Físico da Garganta Orion

Foi criado `GatilhoFisicoInteriorOrion`, uma `Area3D` invisível de 4,2 × 3,4 × 1,4 m, localizada no eixo da garganta após `z=553`. O gatilho não teletransporta Elias, não muda a câmara, não gera luz e não torna o Cube visível. Limita-se a marcar a prontidão do futuro módulo subterrâneo depois de uma travessia real.

A prova QA de 30 segundos deslocou Elias pelo terreno de `z=532` até `z=554`. O log confirmou explicitamente:

> `[CP-CINE-28] ORION_HANDOFF_READY player=Player`

A trajectória usada na prova foi removida do código permanente após a validação. O gatilho físico permanece, enquanto o Cube continua bloqueado no exterior.

## CP-CINE-29 já iniciado

A próxima tarefa constrói o primeiro bloco interior como módulo separado, carregado apenas quando este gatilho for alcançado. A abertura Casa Voss e as Regiões 1–6 permanecem fora desta frente.
