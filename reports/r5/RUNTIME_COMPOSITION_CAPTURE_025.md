# ORIGEM — Captura Runtime R5 025

**Tarefa:** `DEV5-R5-RUNTIME-COMPOSITION-CAPTURE-025`  
**Estado:** VALIDADA LOCALMENTE; sem alteração de produção.

## Evidência

Foram capturadas as rotas `forest_to_majestic` e `majestic_to_lake` em `1600×900`, após 12 segundos de estabilização e confirmação de spawn. Os logs preservam os marcadores de rota e não apresentam erro de parser, script ou recurso.

| Rota | Spawn confirmado | Captura pós-carregamento |
|---|---:|---:|
| `forest_to_majestic` | `(-2.5, 1.343, 178.0)` | Presente |
| `majestic_to_lake` | `(-77.4, 2.414, 178.0)` | Presente |

## Resultado

As capturas confirmam o corredor, as lajes e a saída para o lago. Contudo, o enquadramento canónico das rotas não apresenta o núcleo do acampamento com detalhe suficiente para selecionar melhoria ambiental. Não foi aplicada correção ao mundo, aos conectores, aos colisores ou à iluminação.

## Próxima tarefa

A sequência avança para uma sonda QA de composição do núcleo R5, estritamente separada da câmara de jogo e da produção do acampamento.
