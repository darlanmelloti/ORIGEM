# CP-D5-083 — Validação da sequência cartográfica R1–R6

## Resultado

O preview `CartographicSequenceR1R6Preview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. A sequência confirmou oito pontos de teste, nenhuma omissão de âncora, a transição lateral R5 Majestic e a chegada final às Ruínas R6.

| Ponto | X/Z | Próximo | Leitura |
|---|---|---:|---|
| R1 Voss | `(-22,8)` | 2 | Estrada do Rio |
| R2 saída | `(-21,4;25)` | 3 | Arco |
| R3 arco | `(-16,741;70)` | 4 | Floresta |
| R4 floresta | `(-9,140)` | 5 | Majestic |
| R5 aproximação leste | `(0,178)` | 5 | Majestic |
| R5 Majestic oeste | `(-88,178)` | 6 | Ruínas |
| R6 aproximação | `(60,230)` | 6 | Chegada às Ruínas |
| R6 chegada | `(60,252)` | 7 | Vila Elevada |

Telemetria final: `status=approved`, `checks=8`, `no_anchor_skip=true`, `majestic_lateral=true`, `ruins_arrival=true`. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-083_CARTOGRAPHIC_SEQUENCE_RUNTIME.log`.
