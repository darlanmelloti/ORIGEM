# CP-D5-089 — Regressão da apresentação third-person de Elias

## Resultado

A apresentação `EliasThirdPersonPreview.tscn` foi revalidada no renderer Compatibility headless. O carregamento do projecto em modo editor terminou com `PARSER_EXIT=0`, e a sessão QA terminou pelo limite controlado de 36 segundos com a câmara QA externa activa.

| Verificação | Resultado |
|---|---|
| Parser Godot | Aprovado (`PARSER_EXIT=0`) |
| Cena QA | `EliasThirdPersonPreview.tscn` |
| Câmara activa | `CameraQA` externa |
| QA | 36 segundos (`QA_EXIT=124`, timeout controlado) |
| `SCRIPT ERROR` / `Parse Error` | 0 |
| Alteração de `Player.gd` | 0 |
| Renderer | OpenGL Compatibility |

As mensagens repetidas `FSR1 is only available when using the Forward+ renderer` são advertências de configuração do ambiente Compatibility e não falhas de parser ou de execução da apresentação.

O log está em `CP-D5-089_PARSER_RUNTIME.log`.
