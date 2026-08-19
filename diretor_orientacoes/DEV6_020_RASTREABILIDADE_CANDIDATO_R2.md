# DEV6-020 — Rastreabilidade do Candidato R2

A cadeia de rastreabilidade do candidato R2 encontra-se completa desde a integração inicial até à baseline de recaptura. Os commits DEV6-001 a DEV6-019 estão publicados em sequência na branch `feature/dev6-environment-art`; os documentos correspondentes estão versionados e a evidência QA binária é preservada externamente com manifesto SHA-256.

| Camada de prova | Referência | Estado |
|---|---|---:|
| Integração reversível | `b24c5a6` / DEV6-001 | PASS |
| Materiais, LOD e solo | `c616433`, `075e019`, `c39fc0b` | PASS técnico; rejeições visuais registadas |
| Ambiente e escala | `6bec16e`, `c08f105` | PASS técnico; rejeições visuais registadas |
| Baseline, orçamento e integridade | `a13d3d7` a `5902efe` | PASS |
| Matriz, prontidão e escopo | `316168e` a `eb7842b` | PASS |
| Recaptura e coerência | `0b632f5`, `61ec5a4`, `dc55c92` | PASS documental |
| Evidência QA externa | Log, PNG 1920×1080 e manifesto | PASS |

A única condição aberta não é técnica: Dev1/Dev3 devem publicar a recaptura de terceira pessoa que demonstre Elias, a Estrada, o Arco e os planos laterais no mesmo enquadramento. Assim que a entrada existir, Dev6 executará novamente a baseline DEV6-017 e a matriz DEV6-014 sem redefinir os critérios.
