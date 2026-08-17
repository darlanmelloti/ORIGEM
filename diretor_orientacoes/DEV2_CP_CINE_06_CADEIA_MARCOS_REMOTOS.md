# Dev2 — CP-CINE-06: Cadeia de marcos remotos a partir da Casa Voss

## Decisão cinematográfica

Os testes Dev1 de microgeometria entre `z≈42` e `z≈68` não criaram ganho perceptível e foram revertidos no CP 333. A tomada recuada mantém Casa Voss, Estrada do Rio e Arco físico, mas a referência exige continuidade mais longa: água, floresta, bacia/lago, massas de vila e serra devem poder ser inferidos como uma cadeia real, sem comprimir o mapa.

A responsabilidade da melhoria seguinte pertence ao **Dev2**, proprietário exclusivo das Regiões 7–12. Esta é uma ordem de integração remota, não autorização para modificar qualquer módulo Dev1.

## Ordem única

Criar uma **cadeia de silhuetas remotas escalonadas** nos limites de entrada das Regiões 7–9, alinhada às âncoras cartográficas de Vila Elevada, Observatório e Trilha da Montanha. As massas devem ter presença tridimensional e ser exploráveis na distância real; não podem ser painéis, faróis ciano, uma parede contínua nem uma aproximação artificial de Orion.

| Segmento | Requisito espacial | Critério de retorno |
|---|---|---|
| R7 — Vila Elevada | Primeiro agrupamento arquitectónico em socalcos, perceptível além da bacia sem cobrir o Arco Dev1 | Leitura de cidade distante, não de ruína isolada |
| R8 — Observatório | Uma silhueta de observatório não emissiva, atrás/lateral à Vila e abaixo da serra | Forma distinguível sem ponto de luz técnico |
| R9 — Trilha da Montanha | Dois contrafortes graduais que conduzem visualmente da vila à montanha, preservando a profundidade | A montanha continua remota e a rota não vira corredor comprimido |

## Restrições invioláveis

Não alterar `VossHouse.gd`, `RiverRoadJourney.gd`, `ForestLakeRegion.gd`, `TerrainPatch.gd`, a câmara de prólogo, a ponte ou qualquer objecto das Regiões 1–6. Não criar luzes dinâmicas adicionais. Não modificar âncoras cartográficas.

## Evidência e continuidade

Validar Godot 4.7.1, capturar 16:9 da cadeia de handoff e executar 30 segundos de gameplay. Depois do retorno, abrir automaticamente CP-CINE-07: a mesma tomada da Casa Voss será recapturada para verificar se a cadeia remota passa a organizar o vale sem repetir candidatos já revertidos.

> Este documento é uma tarefa em execução, não um pedido de confirmação. Ao terminar, o Dev2 deve publicar evidência e encadear o próximo CP.
