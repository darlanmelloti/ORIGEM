# CP-D5-012 — Cais QA das Ruínas Submersas

## Estado

**Concluído em QA local; aguarda captura visual 1600×900 no ambiente oficial.** O candidato foi criado em `levels/dev5/` para o marco 6, sem tocar `TempleLevel.gd` ou qualquer módulo regional de produção.

A cena `SubmergedRuinsPierPreview.tscn` instancia um cais com cinco lajes quebradas dispostas em percurso incompleto e quatro colunas parciais laterais. A água é representada por volume tridimensional não emissivo; o objecto não cria luzes dinâmicas. Os colisores existem apenas nas lajes percorríveis e nas colunas laterais, sem bloquear o eixo de travessia central.

A sessão headless local completou 36 segundos e confirmou `landmark=6 submerged=true emissive=false dynamic_lights=0 production_script=false`, sem erros de parser, script ou runtime Dev5. O aviso FSR1 observado pertence ao renderer de compatibilidade do ambiente e não ao candidato.

| Critério | Resultado |
|---|---|
| Marco | Aprovado: Ruínas Submersas, marco 6. |
| Geometria | Aprovada em QA: 5 lajes quebradas e 4 colunas parciais. |
| Emissão | Aprovado: zero emissão no objecto. |
| Luzes | Aprovado: zero luzes dinâmicas no objecto; luz única apenas no harness QA. |
| Física | Aprovada: colisores somente em superfícies de travessia e colunas laterais. |
| Parser/runtime | Aprovado localmente: 36 segundos sem erros Dev5. |
| Captura visual | Pendente no ambiente oficial com viewport 1600×900. |

## Ficheiros

- `levels/dev5/CartographicLandmarkObjects.gd`
- `levels/dev5/SubmergedRuinsPierPreview.gd`
- `levels/dev5/SubmergedRuinsPierPreview.tscn`
- `diretor_orientacoes/CP-D5-012_RUNTIME_HEADLESS.log`
