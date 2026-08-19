# DEV6-012 — Cobertura de Evidência R2

A auditoria de cobertura confirmou que os documentos de integração, baseline e protocolo de recaptura estão versionados na branch Dev6. A evidência binária da sessão de 36 segundos foi gerada no workspace de QA externo e não é duplicada no repositório Git para evitar crescimento desnecessário da branch.

| Artefacto | Estado | Localização |
|---|---:|---|
| Integração e reversão R2 | PASS | `diretor_orientacoes/DEV6_001_ESTRADA_RIO_R2_VALIDADA.md` |
| Baseline técnica | PASS | `diretor_orientacoes/DEV6_009_BASELINE_REGRESSAO_R2.md` |
| Protocolo de recaptura | PASS | `diretor_orientacoes/DEV6_011_MATERIAIS_E_RECAPTURA_R2.md` |
| Log de 36 s | PASS externo | `/home/ubuntu/qa_evidence_dev6_r2/road_to_arch_36s.log` |
| Captura intermédia | PASS externa | `/home/ubuntu/qa_evidence_dev6_r2/road_to_arch_r2_midrun.png` |

A ausência desses binários dentro do clone não é uma falha de execução: são artefactos QA locais, enquanto a telemetria essencial e as decisões de reversão foram versionadas em Markdown. A próxima tarefa deve manter a mesma separação e verificar a existência dos artefactos no diretório QA antes de uma nova entrega externa.
