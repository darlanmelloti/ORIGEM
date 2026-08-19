# DEV6-051 — Regressão Integrada R2–R6

A regressão cobriu as quatro promoções reversíveis realizadas pela frente Dev6. Cada percurso foi testado por 36 segundos depois da integração, e nenhum candidato visualmente insuficiente foi promovido como estado final.

| Região | Integração Dev6 | Percurso | Contrato técnico | Decisão visual |
|---|---|---:|---|---|
| R2 — Estrada do Rio | ponte lateral, 2 cervos, 4 vegetações e 2 vestígios | `road_to_arch`, 36 s | PASS — 9/9 grounding, X/Z preservado, 0 luzes | `REJECTED_VISUAL` |
| R3 — Arco | 2 cervos, 4 vegetações e 2 vestígios; sem arco estrutural | `arch_to_forest`, 36 s | PASS — 8/8 grounding, X/Z preservado, 0 luzes | `REJECTED_VISUAL` |
| R4 — Floresta | 1 pinheiro, 3 árvores e 2 fetos; sem portal | `forest_to_majestic`, 36 s | PASS — 6/6 grounding, X/Z preservado, 0 luzes | `REJECTED_VISUAL` |
| R6 — Margem | monólito, 3 afloramentos e 2 fetos; sem cais | `majestic_to_lake`, 36 s | PASS — 6/6 grounding, X/Z preservado, 0 luzes | `REJECTED_VISUAL` |

A auditoria de código confirmou que os quatro blocos Dev6 não instanciam `Light3D`, `OmniLight3D`, `SpotLight3D` ou `DirectionalLight3D`. O orçamento global do projecto não recebeu aumento através destas promoções.

## Retorno obrigatório a Dev1 e Dev3

A primeira recaptura de cada corredor deve usar terceira pessoa real, com Elias totalmente visível, arma fora da área central, FOV moderado e a rota em diagonal. A captura deve identificar pelo menos três planos: **Elias e lajes**, **candidato Dev6 lateral** e **marco cartográfico seguinte**. Dev1 detém a câmara/controlador e Dev3 a composição; Dev6 não deve alterar esses módulos.

> A base técnica está pronta, mas a validação visual permanece rejeitada. A ausência de uma recaptura cinematográfica não pode ser mascarada por documentação, telemetria ou parser limpo.
