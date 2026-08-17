# CP-D2-093 — Região 11 → Região 12 — Pass3

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Região 12 — Hub Temporal / Cúpula Final |
| **STATUS_CODE** | REJECTED_VISUAL |
| **TAREFA_EM_EXECUCAO_AGORA** | Consolidar a soleira orgânica aterrada e eliminar a leitura residual de massas horizontais suspensas na vista dedicada R11→R12 |
| **ESCOPO_BLOQUEADO** | Regiões 1–6 permanecem intocadas; R7–R11 preservadas |
| **DEADLINE_PROXIMO_PUSH** | 2026-08-17 21:05 GMT+1 |

## Resultado técnico

O parser/headless em Godot 4.7.1 terminou sem erros. O harness dedicado `Region12Traversal.tscn` produziu gameplay de 30 segundos e print de 1600×900 aos 20 segundos. O scope guard confirmou a fronteira exclusiva das Regiões 7–12, com `mapaorigem.webp` como autoridade espacial. Os colliders de handoff R11→R12 permaneceram presentes.

## Resultado visual

O passe ocultou o conjunto de travessia original na rota dedicada, introduziu um portal orgânico dedicado com colunas verticais, lintel, recesso escuro, base e chão de aterramento, e recentrou a câmara. A leitura melhorou, mas a evidência ainda mostra planos/massas horizontais que podem ser interpretados como elementos suspensos; por isso o estado visual permanece rejeitado e não deve ser tratado como aprovação estética.

## Evidência

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `8d514ea5a4ac02a45b0f0fb01b6a43d4bba9a3035089a97978855112072fa02d` |
| `print-1600x900.jpg` | `c3d91d2c31e70f79d9c59b7ef6ee664003a2cb83b8fbacdc927e3e83d57414c2` |
| `CP-D2-093-r11-r12-diagnostic-pass3-culling.zip` | `8c2d4a0bcc8da71508676ed0ffb007277d7afec4aae50249c86b449b6363fd37` |

> Nota de rastreabilidade: os hashes dos ficheiros de evidência correspondem à captura final do ciclo após o reenquadramento da câmara; o ZIP contém o código, harness, QA, assets CC0 e a pasta de evidência do checkpoint.

## NEXT_ACTION_IMMEDIATE

Na sequência imediata, executar o CP-D2-094 na Região 12: substituir o lintel/placa horizontal residual por uma coroa orgânica vertical ou ocultá-lo na rota dedicada, reforçar o contacto visual entre colunas, soleira e chão, repetir a captura de 30 segundos e o print 1600×900, e só então promover o estado a `PASSED` se a silhueta deixar de parecer suspensa. As Regiões 1–6 permanecem intocadas.
