# CP-CARTO-54 — Prova macro por enquadramentos sobrepostos

## Objectivo

Substituir tentativas de alteração cega por duas provas reais e reprodutíveis: a origem Casa Voss e o eixo de saída QA Estrada→Arco. O checkpoint não altera geometria, FOV, câmara de produção, água, iluminação, escala ou módulos Dev2.

## Execução e resultado técnico

| Prova | Ambiente | Duração | Resultado |
| --- | --- | --- | --- |
| Origem Casa Voss | `ORIGEM_QA_CINEMATIC_CAPTURE=1`, Novo Jogo automatizado | 30 s | Aprovado sem erro de parser ou runtime; `cp_carto54_voss_origin_1600x900.png`. |
| Saída QA para Estrada→Arco | `ORIGEM_QA_SKIP_OPENING=1`, Novo Jogo automatizado | 30 s | Aprovado sem erro de parser ou runtime; `cp_carto53_voss_exit_1600x900.png`. |

## Avaliação visual

A tomada da origem confirma Casa Voss como âncora de origem e conserva o início físico da faixa de lajes. A tomada de saída confirma a Estrada como rota real. Nenhuma das duas prova, isoladamente, tornou a silhueta distante do Arco suficientemente dominante; a diferença é de composição macro e não justifica remover ou recuar árvores sem identificar oclusores por projecção.

## Decisão

**Sem alteração de mundo promovida.** A base R1–R6 é preservada. O CP-CARTO-55 só pode alterar um nó específico depois de uma sonda de projecção ou de uma captura macro que demonstre a oclusão causal. As hipóteses já rejeitadas continuam fechadas.
