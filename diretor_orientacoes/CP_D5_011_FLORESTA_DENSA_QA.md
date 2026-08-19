# CP-D5-011 — Portal QA da Floresta Densa

## Estado

**Concluído em QA local; aguarda captura visual 1600×900 no ambiente oficial.** O candidato foi criado exclusivamente em `levels/dev5/` para o marco 4 do mapa, com a âncora explícita `FLORESTA_DENSA=(-9; 116)`. Nenhum módulo de produção, incluindo `ForestLakeRegion.gd`, foi alterado.

## Implementação

A cena `DenseForestPortalPreview.tscn` instancia `create_dense_forest_portal_landmark()`. O candidato contém uma camada de solo volumétrica, seis troncos cilíndricos inclinados em profundidade lateral, seis galhos curtos e quatro rochas laterais irregulares. A faixa central permanece visualmente aberta e tem largura nominal de 2,4 m, sem lintel, pilares ou parede de árvores.

A física usa colisores apenas nos seis troncos e nas quatro rochas laterais. O solo não recebe collider próprio no harness, evitando criar uma barreira invisível na passagem central. O objecto não cria luzes dinâmicas nem utiliza placas, billboards ou texturas frontais.

## Validação

A sessão headless local foi executada por 36 segundos com Godot 4 compatível e confirmou a linha `[DEV5_FOREST_QA] anchor=(-9.0, 116.0) passage_width=2.4 isolated=true region_script=false`. Não foram encontrados erros de script, parser, instanciação ou runtime Dev5. O log integral está em `CP-D5-011_RUNTIME_HEADLESS.log`. O aviso FSR1 do renderer, presente no ambiente de teste, é externo ao candidato e não altera a validação da cena.

| Critério | Resultado |
|---|---|
| Âncora cartográfica | Aprovada: `FLORESTA_DENSA=(-9; 116)`. |
| Geometria | Aprovada em QA: troncos inclinados, rochas laterais, solo e profundidade real. |
| Passagem | Aprovada estruturalmente: 2,4 m nominais, sem bloqueio central. |
| Colisores | Aprovados: somente troncos e rochas laterais. |
| Luzes | Aprovado: zero luzes no objecto; uma luz apenas no harness QA. |
| Parser/runtime | Aprovado localmente: sessão de 36 s sem erros Dev5. |
| Captura visual | Pendente no ambiente oficial com viewport 1600×900. |
| Próxima tarefa | CP-D5-012 — cais das Ruínas Submersas, marco 6. |

## Ficheiros

- `levels/dev5/CartographicLandmarkObjects.gd`
- `levels/dev5/DenseForestPortalPreview.gd`
- `levels/dev5/DenseForestPortalPreview.tscn`
- `diretor_orientacoes/CP-D5-011_RUNTIME_HEADLESS.log`
