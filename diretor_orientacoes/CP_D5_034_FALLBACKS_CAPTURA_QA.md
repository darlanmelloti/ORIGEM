# CP-D5-034 — Fallbacks de captura dos previews QA

## Resultado

A auditoria encontrou cinco previews QA que ainda chamavam directamente `get_viewport().get_texture().get_image().save_png`. Foram endurecidos `CartographicGroundingPreview`, `CartographicHeightContractsPreview`, `MajesticGroundedPavilionPreview`, `MeshBudgetAuditPreview`, `StoneBridgeGLBPreview` e `VegetationDensityAuditPreview` com verificação explícita de textura e imagem nulas. Os previews já protegidos — Floresta Densa, Majestic, Ruínas Submersas e restantes — mantêm o mesmo contrato de fallback.

| Validação | Resultado |
|---|---|
| Varredura editor Godot Compatibility | Código 0 |
| Sessão `CartographicGroundingPreview` | 36 s, código 0 |
| `SCRIPT ERROR`/`Parse Error` | Nenhum encontrado |
| Chamadas directas inseguras restantes em `levels/dev5` | Nenhuma |
| Escopo de produção | Não alterado |
| Captura headless | Continua indisponível quando o backend devolve imagem nula |

A alteração melhora a robustez de QA sem promover candidatos, repetir geometrias rejeitadas ou alterar módulos regionais. O log está em `CP-D5-034_PARSER_SWEEP.log`.

## Próxima acção

Abrir o CP-D5-035 para a próxima auditoria ou melhoria de fundação não concorrente permitida pelo protocolo.
