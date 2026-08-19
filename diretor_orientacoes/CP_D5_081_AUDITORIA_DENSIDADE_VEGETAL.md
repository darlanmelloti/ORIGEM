# CP-D5-081 — Auditoria de densidade vegetal

## Resultado

O preview `VegetationDensityAuditPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless e confirmou uma composição controlada, sem parede de árvores e sem luzes dinâmicas adicionais.

| Componente | Quantidade |
|---|---:|
| Pinheiro focal | 1 |
| Árvore escura média | 3 |
| Árvore leve | 1 |
| Fetos de foreground | 2 |
| Triângulos totais | 27.208 |
| Luzes dinâmicas | 0 |
| Densidade em parede | `false` |

A composição permanece compatível com o orçamento Dev5 para GTX 1050 Ti e não altera módulos de produção. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-081_VEGETATION_DENSITY_RUNTIME.log`.
