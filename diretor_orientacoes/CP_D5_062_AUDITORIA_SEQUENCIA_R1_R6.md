# CP-D5-062 — Auditoria de sequência cartográfica R1–R6

**Escopo:** cena QA isolada. Não altera a UI de mapa, os módulos das regiões, o controlo de Elias ou conteúdo das Regiões 7–12.

## Objectivo

Executar `CartographicAnchors.next_dev1_destination()` em pontos que representam a progressão real das Regiões 1–6 e comprovar que a orientação respeita o mapa como autoridade espacial, incluindo o desvio ocidental do Acampamento Majestic.

| Ponto testado | Mundo X/Z | Próximo destino confirmado |
|---|---:|---|
| R1 — Casa Voss | `(-22,8)` | R2 — Estrada do Rio |
| Saída R2 | `(-21,4,25)` | R3 — Arco das Ruínas |
| R3 — Arco | `(-16,741,70)` | R4 — Floresta Densa |
| R4 — Floresta | `(-9,140)` | R5 — Acampamento Majestic |
| Aproximação R5 a leste | `(0,178)` | R5 — Acampamento Majestic |
| R5 — Majestic oeste | `(-88,178)` | R6 — Ruínas Submersas |
| Aproximação R6 | `(60,230)` | Chegada às Ruínas |
| R6 — Ruínas | `(60,252)` | R7 — Vila Elevada |

## Validação

O parser Godot 4.7.1 passou. A sessão QA de 36 segundos executou oito verificações com asserções, confirmou `no_anchor_skip=true`, `majestic_lateral=true` e `ruins_arrival=true`, e gerou captura interna.

A captura mantém-se uma ferramenta cartográfica técnica: os marcadores simplificados só representam as âncoras e não promovem qualquer geometria QA a produção.

## Próxima tarefa automática

**CP-D5-063 — Convergência de evidências cartográficas.** Criar uma ficha de integração para Dev1 que consolide os harnesses de rumo R1→R2, R5→R6 e a sequência R1–R6, com limites de escopo e os caminhos de evidência.
