# CP-D5-009 — Matriz de revisão Dev1 para candidatos cartográficos Dev5

**Estado:** decisão de integração pendente do proprietário Dev1.  
**Regra central:** cada linha abaixo é um candidato isolado; **nunca integrar dois candidatos no mesmo checkpoint**. O mapa cartográfico e as âncoras X/Z continuam a ser a autoridade espacial.

## Ordem de revisão proposta

| Ordem | Candidato Dev5 | Marco | Módulo de produção proprietário | Ganho esperado | Risco principal | Decisão Dev5 |
|---:|---|---:|---|---|---|---|
| 1 | Ponte de Pedra Arqueada | 2 — Estrada do Rio | `RiverRoadJourney.gd` | Aumentar a leitura arqueada do marco intermédio no eixo Casa→Arco | Duplicar ou estreitar a ponte positiva existente | **Revisar primeiro, A/B obrigatório** |
| 2 | Anexo Casa Voss | 1 — Casa Voss | `VossHouse.gd` | Dar densidade habitada ao ponto de origem do mapa | Bloquear a porta E, prólogo ou corredor Casa→Estrada | **Revisar apenas depois da ponte** |
| 3 | Pavilhão Majestic | 5 — Acampamento Majestic | `ForestLakeRegion.gd` | Reforçar a leitura de acampamento ocidental na bifurcação R4→R5→R6 | Poluir o conector físico recém-validado R5→R6 | **Revisar por último** |

## Condições de aceitação por candidato

| Candidato | Antes de integrar | Gameplay obrigatório | Reversão imediata se |
|---|---|---|---|
| Ponte | Captura A/B com a ponte actual, distância X/Z conferida e uma única variante visível | Menu→Novo Jogo, 36 s no eixo Estrada→Arco e atravessamento sem queda | A nova malha duplica a ponte, reduz o espaço de passagem ou não melhora a leitura ≥85% |
| Anexo Casa Voss | Colocação periférica fora da abertura, da estrada e da câmara de prólogo | Menu→Novo Jogo, E para porta e 36 s desde o interior até à Estrada | A colisão encosta na porta, corta a silhueta de saída ou prejudica o prólogo |
| Pavilhão Majestic | Posição fora das lajes R5→R6 e sem luz dinâmica nova | 36 s Floresta→Majestic e Majestic→Ruínas | O objecto fecha a bifurcação, altera a rota ou se comporta como parede de floresta |

## Inventário de orçamento

| Candidato | Triângulos teóricos | Materiais | Luzes dinâmicas | Colisores |
|---|---:|---:|---:|---|
| Ponte arqueada | 516 | 3 | 0 | Tabuleiro por laje |
| Anexo Casa Voss | 180 | 3 | 0 | Fundação e paredes |
| Pavilhão Majestic | 180 | 2 | 0 | Estrado e banco |

Todos os candidatos permanecem muito abaixo do limite de 2.500 triângulos por objecto Dev5 e não consomem o orçamento de 16 luzes dinâmicas. Os números são de primitivas visuais da biblioteca Dev5; colisores não são geometria renderizada.

## Dependências de integração

1. **Dev5:** não integra. Mantém cenas QA, evidência e activos sob `levels/dev5/`.
2. **Dev1:** escolhe uma única linha da matriz, cria o checkpoint de produção e conduz parser, menu, gameplay, captura e push.
3. **Dev2:** não é envolvido; R7–R12 continuam fora do escopo.
4. **Elias em terceira pessoa:** continua uma frente QA independente. Nenhum candidato de mundo depende do modelo humano rigado bloqueado.

## Próxima tarefa Dev5

**CP-D5-010 — Auditoria de activo humano externo.** Só retomar quando existir GLTF/GLB humano recuperável e a licença estiver documentada. Caso contrário, Dev5 mantém-se em modo de suporte documental e de QA, sem criar geometrias adicionais que concorram com a revisão Dev1.
