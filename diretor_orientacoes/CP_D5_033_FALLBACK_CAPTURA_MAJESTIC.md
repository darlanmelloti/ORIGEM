# CP-D5-033 — Fallback de captura do Pavilhão Majestic

## Resultado

O preview `MajesticPavilionPreview.gd` foi endurecido para verificar a textura e a imagem do viewport antes de chamar `save_png`. Em renderer headless, o sistema agora regista `snapshot_unavailable=headless_image` e termina a captura de forma segura, sem `SCRIPT ERROR` por imagem nula.

A sessão Godot Compatibility completou 36 segundos com código de saída 0. O aviso FSR1 e o parâmetro nulo do backend gráfico continuam externos ao preview; não foram encontrados `Parse Error`, `Invalid call` ou `Invalid get` do script Dev5.

| Critério | Resultado |
|---|---|
| Parser/runtime | Aprovado, 36 s |
| Fallback de viewport nulo | Aprovado |
| Captura gráfica em headless | Indisponível; pendente de viewport válido |
| Escopo | Apenas preview QA e documentação |
| Promoção R4/R6 | Não autorizada |

## Próxima acção

A continuidade abre o CP-D5-034 para a próxima auditoria/ficha QA ou melhoria de fundação permitida.
