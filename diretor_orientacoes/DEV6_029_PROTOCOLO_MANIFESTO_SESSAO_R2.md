# DEV6-029 — Protocolo de Manifesto por Sessão R2

Cada execução de `road_to_arch` que produza uma captura candidata deve gerar um manifesto SHA-256 novo, guardado no mesmo directório QA externo da sessão. O manifesto não pode ser reutilizado depois de qualquer nova execução que substitua PNGs ou logs.

## Procedimento obrigatório

1. Executar o parser Godot e a sessão `road_to_arch` por 36 segundos.
2. Confirmar a telemetria mínima: R1–R6, `grounding=9`, `dynamic_lights=0` e `qa_duration_seconds=36`.
3. Gerar `sha256sum` para log, captura intermédia e captura final com identificador do checkpoint.
4. Validar imediatamente o manifesto com `sha256sum --check`.
5. Registar no checkpoint a decisão técnica e, quando aplicável, a decisão visual da matriz DEV6-014.

| Situação | Decisão |
|---|---|
| Novo manifesto passa e recaptura ainda em primeira pessoa | PASS técnico; `REJECTED_VISUAL` mantido |
| Novo manifesto passa e terceira pessoa cumpre a matriz | Reavaliar aceitação visual |
| Manifesto histórico falha depois de nova captura | Regenerar; não tratar como corrupção de runtime |
| Telemetria não passa | Rejeitar sessão e corrigir antes de publicar |

Este protocolo assegura que Dev6 mantém rastreabilidade sem bloquear o ciclo de desenvolvimento.
