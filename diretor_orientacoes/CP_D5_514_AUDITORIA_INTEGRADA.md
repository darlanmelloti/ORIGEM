# CP-D5-514 — Auditoria integrada contínua R1–R6

## Resultado

A cena `CartographicRegressionAuditPreview.tscn` passou o parser Godot 4.7.1 em renderer OpenGL Compatibility (`PARSER_EXIT=0`) e manteve a sessão QA headless durante 36 segundos em 1600×900. O término `QA_EXIT=124` corresponde ao timeout controlado previsto para encerrar a sessão de duração fixa.

## Evidência técnica

| Critério | Resultado |
|---|---|
| Candidatos auditados | 6 |
| Grounding e rotas | Aprovados |
| Clearance da ponte | `0.21` |
| Passagem florestal | `2.4 m` |
| Scripts de produção | `0` |
| Luzes dinâmicas | `0` |
| Composição vegetal R4/R5 | `1/3/4` |
| Parede de árvores | `false` |
| Escopo | Módulos de produção e `Player.gd` não alterados |

Não foram observados `SCRIPT ERROR` ou `Parse Error`. Os avisos repetidos sobre FSR1 são limitações esperadas do renderer OpenGL Compatibility headless e não constituem falha do checkpoint. A auditoria continua isolada e não autoriza integração automática nos módulos regionais.

## Integridade

O runtime completo está em `CP-D5-514_RUNTIME.log`. O checksum SHA-256 do relatório e do runtime está em `CP-D5-514_SHA256SUMS.txt`.

**STATUS_CODE: PASSED.** O próximo checkpoint deve ser aberto e executado imediatamente após a publicação.
