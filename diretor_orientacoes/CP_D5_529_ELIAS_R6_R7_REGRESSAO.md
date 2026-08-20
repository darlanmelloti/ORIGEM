# CP-D5-529 — Regressão Elias no handoff modular R6→R7

## Resultado

A cena `EliasR6R7HandoffPreview.tscn` passou o parser Godot 4.7.1 em renderer OpenGL Compatibility (`PARSER_EXIT=0`) e manteve a sessão QA headless durante 36 segundos em 1600×900. O término `QA_EXIT=124` corresponde ao timeout controlado previsto para encerrar a sessão de duração fixa.

## Evidência técnica

| Critério | Resultado |
|---|---|
| Âncora R6 X/Z | `(60.00, 252.00)` |
| Próximo marcador | `PASSAGEM: VILA ELEVADA` |
| ID do marcador | `7` |
| Âncora R7 X/Z | `(140.00, 352.00)` |
| Elias alcançou R7 | `true` |
| Geometria Dev2 criada | `false` |
| Módulos de produção alterados | `false` |
| Modo | `marker_only=true` |
| Parser | Aprovado — `PARSER_EXIT=0` |
| QA | Aprovado — 36 s, `QA_EXIT=124` por timeout controlado |

O handoff confirma a expansão do espelhamento cartográfico até à transição R6→R7 sem criar geometria canónica da Região 7. A câmara de produção não foi instanciada; a apresentação permanece um preview técnico isolado, em conformidade com a fronteira de escopo.

Os avisos FSR1 são limitações esperadas do renderer OpenGL Compatibility headless e não constituem falha do checkpoint. Não foram observados `SCRIPT ERROR`, `Parse Error` ou alteração de produção.

## Integridade

O runtime completo está em `CP-D5-529_RUNTIME.log`. O checksum SHA-256 do relatório e do runtime será registado em `CP-D5-529_SHA256SUMS.txt`.

**STATUS_CODE: PASSED.** O próximo checkpoint deve prosseguir sem pausa após a publicação.
