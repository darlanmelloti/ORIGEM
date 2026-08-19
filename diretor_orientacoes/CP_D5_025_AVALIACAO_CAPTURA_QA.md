# CP-D5-025 — Avaliação visual dos candidatos QA

## Resultado técnico

Foram executadas sessões independentes de 36 segundos para `DenseForestPortalPreview.tscn` (marco 4) e `SubmergedRuinsPierPreview.tscn` (marco 6), usando a variável `ORIGEM_QA_VIEWPORT_SNAPSHOT` e o fallback seguro de captura interna.

| Candidato | Âncora/runtime | Sessão | Captura |
|---|---|---|---|
| Portal Floresta Densa | `anchor=(-9,116)`, passagem 2,4 m, isolado | 36 s, sem `SCRIPT ERROR` ou `Parse Error` | Indisponível no renderer headless: imagem de viewport nula |
| Ruínas Submersas | `landmark=6`, água não emissiva, zero luzes do objecto | 36 s, sem `SCRIPT ERROR` ou `Parse Error` | Indisponível no renderer headless: imagem de viewport nula |

O fallback evita chamar `save_png` quando o renderer headless não fornece imagem. O aviso `FSR1` e o parâmetro nulo do backend gráfico pertencem ao ambiente de validação, não à geometria ou aos scripts dos candidatos. Não é possível aceitar ou rejeitar visualmente os candidatos com esta execução; ambos permanecem **candidatos técnicos com avaliação visual pendente** até existir um viewport gráfico válido.

## Escopo

Não foram criados novos objectos 3D, não foram repetidas as geometrias rejeitadas e nenhum módulo de produção foi alterado. As alterações limitam-se ao fallback de captura e à documentação de evidência.

## Próxima acção

A continuidade deve manter a avaliação visual pendente claramente documentada e abrir a próxima tarefa QA autorizada sem promover estes candidatos a produção.
