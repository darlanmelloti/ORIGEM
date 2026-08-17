# CP-D2-109 — Região 12 — Telemetria de Desempenho

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| **REGIAO_ACTUAL** | Região 12 — Hub Temporal / Cúpula Final |
| **STATUS_CODE** | PASSED |
| **TAREFA_EM_EXECUCAO_AGORA** | Iniciar o próximo passe de pacote final e auditoria de escopo |
| **ESCOPO_BLOQUEADO** | Regiões 1–6 permanecem intocadas |
| **DEADLINE_PROXIMO_PUSH** | 2026-08-18 05:05 GMT+1 |

A validação da rota `R11_R12_HUB_DEDICATED` foi repetida durante mais de 30 segundos. A telemetria recolhida no gameplay registou `fps=29–33` e `draw_calls=58–68`, sem erros de parser ou runtime. A pulsação do núcleo, a luz de contacto, os materiais dedicados, a câmara aproximada e a soleira aterrada permaneceram activos. O scope guard confirmou `regions=7-12` com `map_authority=mapaorigem.webp`.

| Artefacto | SHA-256 |
|---|---|
| `gameplay-30s.mp4` | `08eacb240866ebbd0793c34c3195a7859d8070750f2feeecdfc92010294f7a2a` |
| `print-1600x900.jpg` | `04051aff1f5e2275d91e0d48387a2152d077d4b5205bb5817dd3339f54e16cc8` |
| Pacote CP-D2-109 | Será calculado no empacotamento final do ciclo |

## NEXT_ACTION_IMMEDIATE

Executar o CP-D2-110 na Região 12: empacotar a telemetria e repetir a auditoria final da branch Dev2, mantendo o orçamento observado e sem tocar nas Regiões 1–6.
