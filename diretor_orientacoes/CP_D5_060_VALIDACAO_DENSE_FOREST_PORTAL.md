# CP-D5-060 — Validação DenseForestPortal R4

## Resultado

O preview `DenseForestPortalPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. A telemetria confirma a âncora R4, largura de passagem e isolamento do script regional.

| Critério | Resultado |
|---|---|
| Âncora R4 | `(-9,0;116,0)` |
| Largura de passagem | `2,4 m` |
| Portal isolado | `true` |
| Script regional alterado | `false` |
| Runtime | 36 segundos |
| Parser/Script Error | Nenhum |

A advertência FSR1 pertence ao renderer Compatibility local. A captura visual de R4 continua pendente de viewport gráfico válido; esta prova confirma apenas os contratos técnicos do preview Dev5.

O log está em `CP-D5-060_FOREST_RUNTIME.log`.
