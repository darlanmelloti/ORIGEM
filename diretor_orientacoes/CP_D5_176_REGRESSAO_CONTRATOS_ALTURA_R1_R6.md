# CP-D5-176 — Regressão dos contratos de altura e aterramento R1→R6

## Resultado

A cena `CartographicHeightContractsPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os seis contratos de altura foram emitidos com coordenadas canónicas, proprietários regionais e regras explícitas de aterramento.

| Métrica | Resultado |
|---|---|
| Cobertura | 6/6 regiões |
| Proprietários de terreno | 3 |
| Modo padrão | Raycast obrigatório antes de integração |
| Produção alterada | `false` |
| Arco estrutural R3 | Excluído; não repetir candidato rejeitado |
| Cais de lajes R6 | Excluído; não repetir candidato rejeitado |
| Estado | `approved` |

Os contratos preservam módulos e superfícies de produção, restringem os candidatos a QA e mantêm a resolução de Y independente de X/Z. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. O log está em `CP-D5-176_HEIGHT_CONTRACTS_RUNTIME.log`.
