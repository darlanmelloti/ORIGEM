# CP-D5-032 — Validação do Pavilhão Majestic aterrado

## Resultado

Foi validado o preview remoto `MajesticPavilionPreview.tscn`, que constrói o Pavilhão Majestic em cena QA isolada com terreno, rota central, materiais próprios e posição baixa de contacto (`y=0,12`). O preview não carrega módulos de produção nem integra o pavilhão no mundo principal.

A sessão Godot headless Compatibility completou 36 segundos com código de saída 0. Não foram encontrados `SCRIPT ERROR`, `Parse Error`, `Invalid call` ou `Invalid get` no log `CP-D5-032_RUNTIME_HEADLESS.log`. A captura gráfica não foi activada nesta execução porque o backend headless já demonstrou não fornecer uma `Image` válida; a pendência visual R4/R6 permanece documentada.

| Critério | Resultado |
|---|---|
| Parser/runtime | Aprovado localmente, 36 s |
| Isolamento de produção | Aprovado por estrutura do preview |
| Rota central | Presente no harness |
| Aterramento Majestic | Validação runtime concluída |
| Captura visual | Pendente de viewport gráfico válido |

## Próxima acção

Após publicar, abrir o CP-D5-033 para a próxima auditoria/ficha não concorrente, mantendo a pendência de captura visual explícita.
