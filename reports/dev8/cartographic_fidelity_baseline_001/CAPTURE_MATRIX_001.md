# Dev8 — Matriz de Capturas Cartográficas 001

**Tarefa:** `DEV8-CARTOGRAPHIC-FIDELITY-BASELINE-001`
**Modo:** cena de jogo, Xvfb/OpenGL, mapa aberto por ambiente QA
**Resolução:** 1600×900 em todas as rotas
**Produção:** `production_mutations=0`

| Rota QA | Evidência | Posição observada / telemetria | Destino cartográfico devolvido | Leitura QA |
|---|---|---|---|---|
| `road_to_arch` | `routes_1600x900/road_to_arch.png` | Spawn Estrada–Arco `(-20.05, 0.606, 22.0)`; estado narrativo mantém Casa Voss. | Estado inicial de descoberta; não medir progressão a partir desta vista. | Mapa, legenda e UI legíveis. |
| `arch_to_forest` | `routes_1600x900/arch_to_forest.png` | `(-9.00, 107.00)`; marco próximo 4 a 9.00 m. | 4 — `RUMO À FLORESTA`. | Marcador Elias corresponde ao corredor da Floresta. |
| `forest_to_majestic` | `routes_1600x900/forest_to_majestic.png` | `(-2.50, 178.00)`; primeira perna ocidental. | 5 — `RUMO AO MAJESTIC`. | Desvio cartográfico para oeste preservado. |
| `majestic_to_lake` | `routes_1600x900/majestic_to_lake.png` | `(-77.40, 178.00)`; marco 5 a 10.60 m. | 6 — `RUMO ÀS RUÍNAS`. | Reconvergência para a bacia é legível. |
| `forest_to_ruins` | `routes_1600x900/forest_to_ruins.png` | `(9.77, 194.00)`; trecho leste da faixa 150–202. | 5 — `RUMO AO MAJESTIC`. | Resultado corresponde à regra espacial atual; é observação, não defeito confirmado. |
| `ruins_arrival` | `routes_1600x900/ruins_arrival.png` | `(13.68, 222.00)`; marco 6 a 55.19 m. | 6 — `CHEGADA ÀS RUÍNAS`. | Handoff R6 permanece coerente. |

## Resultado visual

A folha `routes_1600x900/contact_sheet.png` confirma que as seis vistas mantêm escala, contraste e legenda utilizáveis. Não foram criados painéis, setas no mundo, sinalização artificial, luzes, partículas, materiais ou geometria.

A primeira vista de Estrada–Arco preserva o marcador narrativo de Casa Voss porque o harness técnico não simula a descoberta completa. Ela não invalida as restantes capturas; marca apenas uma lacuna de cobertura que deverá ser entregue ao Dev1/timeline como hipótese QA, sem alteração Dev8 de produção.

## Conclusão

A matriz cumpre a captura cartográfica das rotas canónicas. Qualquer possível ajuste de descoberta narrativa, destino ou UI pertence ao Dev1 ou dono regional após hipótese causal e autorização explícita.
