# CP-D5-061 — Validação SubmergedRuins R6

## Resultado

O preview `SubmergedRuinsPierPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. A telemetria confirma o landmark R6 submerso, sem emissividade artificial, sem luzes dinâmicas e sem script de produção.

| Critério | Resultado |
|---|---|
| Landmark | `6` |
| Submerso | `true` |
| Emissivo | `false` |
| Luzes dinâmicas | `0` |
| Script de produção | `false` |
| Runtime | 36 segundos |
| Parser/Script Error | Nenhum |

A advertência FSR1 pertence ao renderer Compatibility local. A aprovação visual de R6 continua pendente de viewport gráfico válido; a validação técnica não autoriza integração em módulos regionais.

O log está em `CP-D5-061_RUINS_PIER_RUNTIME.log`.
