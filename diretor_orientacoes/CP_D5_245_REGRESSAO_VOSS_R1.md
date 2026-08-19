# CP-D5-245 — Regressão Casa Voss R1 viva

## Resultado

A cena `R1LivingVossExteriorPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A Casa Voss permanece uma composição exterior viva e isolada, com fauna, jardim e posto de passagem aterrados, rota aberta e nenhuma alteração aos módulos de produção.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Elementos de jardim | 5 |
| Casa/posto de passagem | `true` |
| Elementos aterrados | 8 |
| Ciclos de rota | 4, todos `clear=true` |
| Distância de fauna | 9,07–9,87 |
| Casa de produção tocada | `false` |
| Porta de produção tocada | `false` |
| Módulos de produção alterados | `false` |

A regressão aprova a composição viva R1 para uso como candidato QA, sem autorizar integração automática na Casa Voss de produção. Os avisos FSR1 do renderer Compatibility não produziram erros Dev5. O log está em `CP-D5-245_R1_VOSS_EXTERIOR_RUNTIME.log`.
