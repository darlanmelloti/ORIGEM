# Dev7 — Auditoria Contínua Pós-Canónica do Registo R6 007

| Campo | Resultado |
|---|---|
| **Tipo de trabalho** | Revalidação QA somente de leitura do registo `R6-ENTRY-VESTIGES-05` |
| **Base comparada** | `R6_ARCHAEOLOGY_TARGET_REGISTRY_005.log` vs. head Dev7 reconciliado `ad7c150c` |
| **Captura comparativa** | Não executada |
| **Material temporário/override** | Não criado |
| **Mutação de produção** | Zero |
| **Estado de produção R6** | Bloqueada até decisão explícita Dev6/R6 |

## Objetivo

Após a reconciliação com o head canónico, esta auditoria confirmou se o registo QA de alvos arqueológicos R6 continuava estável. A sonda já existente `qa/dev7/list_r6_archaeology_target_registry.gd` foi executada apenas como enumerador de leitura. Não foram criadas imagens baseline/variante, luzes, colisores, materiais persistentes, nodes de produção ou alterações de rota.

## Resultado de identidade

A comparação determinística dos `NodePath` extraídos do registo 005 e da execução pós-canónica devolveu diferença vazia. Os **20 NodePaths** enumerados permanecem idênticos: cinco pertencem ao conjunto de vestígios de entrada e quinze às quatro categorias históricas da captura 003.

| Prefixo | Quantidade estável | Conjunto |
|---|---:|---|
| `VestigioDeAproximacaoBacia_` | 3 | `R6-ENTRY-VESTIGES-05` |
| `VestigioDaEntradaDaBacia_` | 2 | `R6-ENTRY-VESTIGES-05` |
| `EstelaDaChegada` | 1 | Categoria histórica da captura 003 |
| `MarcoRuinaEmergente_` | 3 | Categoria histórica da captura 003 |
| `PilarSubmerso_` | 8 | Categoria histórica da captura 003 |
| `AfloramentoChegadaRuinas_` | 3 | Categoria histórica da captura 003 |
| **Total** | **20** | 5 vestígios de entrada + 15 meshes de categorias históricas |

A estabilidade confirma que a reconciliação canónica não introduziu ambiguidade nova na taxonomia. Também reforça a conclusão anterior: os quatro prefixos históricos não devem voltar a ser descritos como quatro objetos únicos nem usados como seleção aberta para um futuro teste.

## Invariantes QA

| Invariante | Resultado |
|---|---|
| `production_mutations` | `0` |
| `created_light3d` | `false` |
| `created_collision` | `false` |
| `created_override` | `false` |
| Mudança de NodePaths | `false` |
| Rota/água/Player/câmara de jogador | Não modificados |

> Esta auditoria não reabre a captura 003, que permanece rejeitada para produção. Ela só confirma que o registo de identidade continua válido depois da integração canónica.

## Continuidade segura

O trabalho Dev7 permitido continua documental. O registo `R6-ENTRY-VESTIGES-05` permanece disponível para uma futura decisão regional, mas nenhuma hipótese visual, enquadramento de prova ou autorização de Dev6/R6 foi recebida. Até isso ocorrer, novos comparativos e toda mutação de produção seguem proibidos.

## Evidências

| Artefacto | Finalidade |
|---|---|
| `target_registry_postcanonical.log` | Enumerador QA no head reconciliado. |
| `nodepath_diff.log` | Diferença vazia dos 20 caminhos QA. |
| `R6_ARCHAEOLOGY_TARGET_REGISTRY_005.log` | Linha de base de identidade. |
| `qa/dev7/list_r6_archaeology_target_registry.gd` | Sonda somente de leitura. |
