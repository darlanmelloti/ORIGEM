# DEV6-014 — Matriz de Aceitação da Recaptura R2

A matriz permite avaliar uma futura captura de terceira pessoa sem reinterpretar os contratos que já passaram tecnicamente.

| Dimensão | Condição de aceitação | Proprietário | Estado actual |
|---|---|---|---:|
| Perspectiva | Elias visível em terceira pessoa, sem arma a dominar o quadro | Dev1 / Dev3 | Pendente de recaptura |
| Composição | Estrada, Arco e dois planos laterais identificáveis numa leitura | Dev3 | Pendente de recaptura |
| Rota | `road_to_arch` contínua por 36 s | Dev1 / Dev6 | PASS baseline |
| Cartografia | X/Z, Arco z≈92 e curva da estrada preservados | Dev1 / Dev6 | PASS baseline |
| Grounding | 9/9 activos R2 no solo | Dev6 | PASS baseline |
| Luzes | 0 incrementais Dev6; total da cena ≤16 | Dev6 / Dev4 | PASS incremental |
| Materiais | Fauna, ruína e solo sem regressão GL | Dev6 | PASS técnico |
| Evidência | PNG 1920×1080 e log com hash | Dev6 | PASS baseline |

A recaptura só poderá ser marcada como **aceite visualmente** se as duas primeiras linhas também passarem. Um resultado que cumpra apenas rota, grounding e luzes continua tecnicamente válido, mas mantém a decisão `REJECTED_VISUAL`.
