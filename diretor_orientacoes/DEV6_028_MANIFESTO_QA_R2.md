# DEV6-028 — Manifesto QA R2 Renovado

A auditoria detectou que o manifesto DEV6-013 já não correspondia às capturas PNG, pois sessões posteriores de regressão substituíram os ficheiros de evidência com novas capturas válidas. O log permaneceu inalterado. Isto é uma diferença de ciclo QA, não uma falha de runtime.

Foi criado o manifesto externo actualizado em `/home/ubuntu/qa_evidence_dev6_r2/DEV6_028_manifesto_sha256.txt`. A validação SHA-256 passou para o log e as duas capturas actualmente usadas pela baseline.

| Artefacto actual | Integridade | Telemetria associada |
|---|---:|---:|
| `road_to_arch_36s.log` | PASS | 36 s, R1–R6, 9/9 grounding, 0 luzes incrementais |
| `road_to_arch_r2_midrun.png` | PASS | Captura intermédia 1920×1080 |
| `road_to_arch_36s.png` | PASS | Captura final 1920×1080 |

O protocolo de recaptura passa a exigir um manifesto próprio por sessão de evidência, evitando a reutilização de hashes históricos depois de novas validações.
