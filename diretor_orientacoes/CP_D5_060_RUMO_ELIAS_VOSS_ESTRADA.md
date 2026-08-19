# CP-D5-060 — Rumo de Elias: Casa Voss → Estrada do Rio

**Escopo:** harness QA isolado em `levels/dev5/`. Não altera `VossHouse.gd`, `RiverRoadJourney.gd`, `Player.gd`, o mundo Dev1 ou regiões Dev2.

## Objectivo

Verificar que a orientação cartográfica não salta o primeiro marco jogável após Casa Voss. Elias deve identificar a Estrada do Rio como próximo destino, enquanto o anexo da Casa Voss e a ponte modular R2 são mantidos como volumes 3D de referência isolada.

| Elemento | Regra QA | Resultado |
|---|---|---|
| Casa Voss | Âncora R1 `(-22,8)` | Aterrado e visível |
| Estrada do Rio | Âncora R2 `(-21,4,12)` | Próximo destino confirmado |
| Ponte modular | Referência isolada em `(-21,4,28)` | Aterrada; não é ponte GLB rejeitada |
| Elias | Rota lateral `X=-18`, Z `8→13` | 10 ciclos sem bloqueio |
| Câmara | Uma câmara QA externa | Câmara interna de Elias inactiva |
| Luzes | Uma direccional QA | Dentro do orçamento Dev5 |

## Validação

O parser Godot 4.7.1 passou. A sessão de 36 segundos gerou captura interna, completou dez ciclos de rota e registou consistentemente `RUMO À ESTRADA DO RIO`, âncora 2. A composição mostra Casa Voss, Elias e a ponte modular no mesmo volume QA, mas permanece **evidência técnica** e não integração de produção.

## Próxima tarefa automática

**CP-D5-061 — Auditoria de sequência R1–R6.** Criar uma matriz executável de pontos de teste para `next_dev1_destination()`, validando que as transições R1→R2→R3→R4→R5→R6 respeitam as âncoras e não saltam o desvio Majestic.
