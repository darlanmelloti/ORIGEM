# CP-D5-532 — Regressão Elias no corredor modular expandido

## Resultado

A cena `EliasR6R7HandoffPreview.tscn` passou o parser Godot 4.7.1 em renderer OpenGL Compatibility (`PARSER_EXIT=0`) e manteve a sessão QA headless durante 36 segundos em 1600×900. O término `QA_EXIT=124` corresponde ao timeout controlado previsto para encerrar a sessão de duração fixa.

## Evidência técnica

| Critério | Resultado |
|---|---|
| Âncora R6 X/Z | `(60.00,252.00)` |
| Marcador R7 | `PASSAGEM: VILA ELEVADA`, ID `7` |
| Âncora R7 X/Z | `(140.00,352.00)` |
| Marcador alcançado | `true` |
| Câmara de produção | `false` |
| Geometria Dev2 criada | `false` |
| Modo | `marker_only=true` |
| Parser | Aprovado — `PARSER_EXIT=0` |
| QA runtime | Aprovado — 36 s, `QA_EXIT=124` por timeout controlado |
| Escopo | `production_modules_changed=false` |

A regressão confirma que Elias mantém o handoff cartográfico até à entrada R7 mesmo após a expansão do corredor para duas faixas. A geometria modular continua isolada no preview Dev5; a Região 7 canónica não foi criada nem alterada.

Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless e não constituem falha. Não foram observados `SCRIPT ERROR` ou `Parse Error`.

## Integridade

O runtime completo está em `CP-D5-532_RUNTIME.log`. O checksum SHA-256 do relatório e do runtime será registado em `CP-D5-532_SHA256SUMS.txt`.

**STATUS_CODE: PASSED.** O próximo checkpoint deve prosseguir sem pausa após a publicação.
