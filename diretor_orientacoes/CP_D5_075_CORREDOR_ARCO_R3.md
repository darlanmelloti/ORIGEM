# CP-D5-075 — Corredor cartográfico do Arco R3

**Escopo:** harness QA isolado em `levels/dev5/`. Não cria arco estrutural, não toca em `RiverRoadJourney.gd` e não altera módulos de produção.

## Objectivo

Confirmar que Elias pode atravessar o corredor físico associado ao marco R3, mantendo o alvo físico do Arco em `Z=92` e recebendo a orientação cartográfica para a Floresta Densa.

| Critério | Resultado QA |
|---|---|
| Âncora canónica | R3 `(-16,741,48)` |
| Alvo físico do Arco | `Z=92` preservado |
| Rumo ao iniciar | R4 — Floresta Densa |
| Geometria de arco | `structural_arch=false` |
| Passagem | 3 ciclos em 36 segundos |
| Elias | Terceira pessoa e câmara interna inactiva |
| Luzes | Uma direccional QA, zero Omni/Spot |

## Revisão visual

A captura apresenta Elias, as balizas técnicas de orientação e a marca `Z=92` no mesmo corredor. Não existe arco construído, pelo que a prova não contradiz a rejeição anterior do candidato estrutural; trata-se exclusivamente de validação de rumo e profundidade cartográfica.

## Próxima tarefa automática

**CP-D5-076 — Matriz de travessia R2/R3/R4/R5/R6.** Consolidar folgas, câmaras, grounding e limites de cada prova de passagem para a revisão técnica Dev1, preservando a distinção entre QA e aprovação estética.
