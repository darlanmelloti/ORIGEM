# STATUS CHECKPOINT 335 — Diagnóstico de pontos residuais na abertura

**Estado:** auditoria concluída; hipótese de limpeza adicional revertida por ausência de ganho visual.

## Método aplicado

Foi criada uma sonda temporária que projectou os nós do mundo no cone da câmara de prólogo. A leitura confirmou que o Arco, a ponte, os afloramentos, os fetos e os marcos remotos são geometria física no vale, não um plano de fundo. A sonda também revelou luzes de orientação distantes no corredor florestal e na transição Majestic.

Uma filtragem temporária ocultou somente essas luzes de orientação durante a abertura. A captura comparativa `cp335_wayfinding_clean.png` não demonstrou redução perceptível dos pontos azulados/claros que permanecem no frame, pelo que a alteração em `VossHouse.gd` foi integralmente revertida. Não foi removida geometria nem afectada a exploração normal.

## Conclusão operacional

Os pontos remanescentes não podem ser atribuídos com segurança às balizas sem apagar marcos reais ou introduzir uma heurística frágil. A base CP 331 permanece válida: elementos técnicos legados e emissões ciano detectáveis são ocultados e restaurados correctamente no handoff. O CP 335 não preserva código de runtime.

## Próximo ciclo já activo

A melhoria de impacto continua a ser a cadeia estrutural remota R7–R9, atribuída ao Dev2 no CP-CINE-06. Dev3 utilizará a matriz CP-CINE-07 para recapturar a abertura quando a integração física estiver disponível. Não repetir filtros de balizas, microgeometria, terreno, ponte, lente ou atmosfera já revertidos.
