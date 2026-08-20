# CP-D5-519 — Regressão contínua da apresentação de Elias

## Resultado

A cena `EliasThirdPersonPreview.tscn` passou o parser Godot 4.7.1 em renderer OpenGL Compatibility (`PARSER_EXIT=0`) e manteve a sessão QA headless durante 36 segundos em 1600×900. O término `QA_EXIT=124` corresponde ao timeout controlado previsto para encerrar a sessão de duração fixa.

## Evidência técnica

| Critério | Resultado |
|---|---|
| Cena validada | `entities/player/third_person/EliasThirdPersonPreview.tscn` |
| Parser | Aprovado — `PARSER_EXIT=0` |
| QA runtime | Aprovado — 36 s, `QA_EXIT=124` por timeout controlado |
| Câmara activa | `/root/EliasThirdPersonPreview/CameraQA` |
| Erros de script | Nenhum `SCRIPT ERROR` observado |
| Erros de parsing | Nenhum `Parse Error` observado |
| Escopo | `Player.gd` e módulos de produção não alterados |

Os avisos repetidos sobre FSR1 são limitações esperadas do renderer OpenGL Compatibility headless e não constituem falha do checkpoint. A apresentação de Elias permanece uma fundação técnica isolada de terceira pessoa, não uma substituição do jogador de produção.

## Integridade

O runtime completo está em `CP-D5-519_RUNTIME.log`. O checksum SHA-256 do relatório e do runtime está em `CP-D5-519_SHA256SUMS.txt`.

**STATUS_CODE: PASSED.** O próximo checkpoint deve ser aberto e executado imediatamente após a publicação.
