# CP-D5-038 — Smoke test runtime das cenas QA Dev5

## Resultado

Foi executado um smoke test isolado em **17 cenas QA** de `levels/dev5/`. Cada cena recebeu um processo headless Compatibility com timeout próprio e duração de cinco segundos. Todas terminaram com código 0 e nenhuma produziu `SCRIPT ERROR`, `Parse Error`, `Invalid call`, `Invalid get` ou falha de carregamento.

| Métrica | Resultado |
|---|---:|
| Cenas testadas | 17 |
| Processos concluídos | 17 |
| Falhas de runtime Dev5 | 0 |
| Erros de parser detectados | 0 |
| Módulos de produção alterados | 0 |

A matriz inclui grounding, placement, regressão cartográfica, portal de floresta, vegetação aterrada R4/R5, Majestic, composição vegetal, malha, composição multi-marco, ponte, ruínas submersas, densidade e LOD vegetal, além de Voss. O smoke test confirma integridade de instanciação, não substitui a sessão de 36 segundos nem a captura visual gráfica. R4/R6 continuam pendentes de viewport válido e não foram promovidos.

O log completo está em `CP-D5-038_RUNTIME_SMOKE.log`.

## Próxima acção

Abrir o CP-D5-039 para a próxima auditoria/ficha QA ou melhoria de fundação permitida.
