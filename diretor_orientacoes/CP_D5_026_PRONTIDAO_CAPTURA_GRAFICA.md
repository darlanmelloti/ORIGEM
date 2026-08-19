# CP-D5-026 — Prontidão para captura gráfica dos candidatos R4/R6

## Estado

Os candidatos `DenseForestPortalPreview.tscn` (marco 4) e `SubmergedRuinsPierPreview.tscn` (marco 6) estão tecnicamente prontos para avaliação, mas ainda não possuem captura visual válida neste ambiente headless. As sessões de 36 segundos confirmaram os contratos de runtime e não apresentaram `SCRIPT ERROR` ou `Parse Error`.

A variável de captura é `ORIGEM_QA_VIEWPORT_SNAPSHOT=/caminho/absoluto/captura.png`. O procedimento recomendado é abrir cada cena num viewport gráfico Godot 4.7.1 com Compatibility renderer, aguardar pelo menos 30 frames após `_ready`, capturar a imagem interna e avaliar a leitura visual contra os critérios abaixo. O fallback agora regista `snapshot_unavailable=headless_renderer` ou `snapshot_unavailable=headless_image` e não tenta `save_png` sobre uma textura nula.

| Candidato | Critérios de aceitação visual | Rejeitar se |
|---|---|---|
| Floresta Densa, marco 4 | Troncos inclinados com profundidade lateral, passagem central de 2,4 m e leitura orgânica do portal | Parede de árvores, lintel/pilares, bases cúbicas ou armação estrutural provisória |
| Ruínas Submersas, marco 6 | Lajes e colunas parciais legíveis como cais arqueológico, água não emissiva e travessia possível | Lajes cúbicas isoladas, colunas uniformes ou aspecto de plano de ensaio |

## Verificação de escopo

A ficha confirma que os previews só vivem em `levels/dev5/`, não integram `ForestLakeRegion.gd` nem `TempleLevel.gd`, não alteram `Player.gd` e não adicionam candidatos rejeitados. Os candidatos permanecem QA e não podem ser promovidos sem captura e avaliação visual comparável.

## Próxima acção

Depois de existir viewport gráfico válido, repetir as duas sessões, anexar as capturas e decidir aceitar/rejeitar cada candidato. Enquanto isso, a fila pode avançar apenas com auditorias e fichas que não criem geometrias concorrentes.
