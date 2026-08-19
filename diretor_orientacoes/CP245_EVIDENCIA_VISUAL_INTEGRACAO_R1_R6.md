# CP245 — Evidência Visual da Integração Cartográfica R1–R6

## Sessões concluídas

| Rota | Duração | Resultado técnico | Resultado visual |
|---|---:|---|---|
| Casa Voss → Estrada → Arco (`road_to_arch`) | 36 segundos | PASS — parser limpo, rota iniciada e captura emitida | REJECTED_VISUAL |
| Floresta → Majestic (`forest_to_majestic`) | 36 segundos | PASS — parser limpo, rota iniciada e captura emitida | REJECTED_VISUAL |

## Leitura observada

Na rota R1→R3, o caminho físico e o Arco permanecem legíveis no eixo de progressão. A abertura vegetal evita uma parede contínua de troncos e o marco R3 pode ser identificado à distância. Contudo, a arma de primeira pessoa domina o primeiro plano, os marcadores azuis de QA continuam visíveis e os elementos de árvore e ruína ainda possuem leitura de protótipo. A captura não deve ser apresentada como aprovação estética.

Na rota R4→R5, o corredor está livre e os limites de vegetação não bloqueiam a passagem. Contudo, as copas apresentam leitura planar, o solo e as sombras mostram repetição forte e permanecem marcadores cianos de QA. A continuidade física passou; a qualidade visual ainda não atinge o limiar de promoção.

## Decisão

> **CP245 técnico: PASS. CP245 visual: REJECTED.**
>
> Não existe regressão física comprovada nas duas rotas testadas. A próxima melhoria Dev1 deve remover ou ocultar os marcadores QA da captura de produção, sem eliminar telemetria nem alterar âncoras, colisores, luzes ou a separação R1–R6/R7–R12.
