# CP-D5-101 — Ficha de Integração R1: Casa Voss Exterior Viva

## Finalidade

Integrar o candidato `R1LivingVossExteriorPreview.tscn` de modo reversível, sem alterar a Casa Voss jogável, a porta com tecla E ou `Player.gd`. A âncora Casa Voss permanece `(-22,8)` e a saída deve continuar a apontar para a Estrada do Rio.

| Elemento | Regra | Restrição |
|---|---|---|
| Anexo | Estrutura lateral independente, aterrada por raycast | Não intersectar a casa, porta ou rota exterior |
| Horta | Canteiros baixos fora do eixo de saída | Sem colisores que bloqueiem Elias |
| Fauna | Dois cervos ambientais afastados | Sem colisor bloqueante; distância mínima de 5 m da rota |
| Vegetação | Árvores/fetos laterais dentro de LOD | Nunca formar parede diante da porta |
| Iluminação | Sol e ambiente existentes | Não acrescentar luz dinâmica |

## Sequência de integração

1. Adicionar anexo lateral e validar saída da casa por 36 segundos.
2. Adicionar horta e confirmar que o corredor de Elias para a Estrada fica livre.
3. Adicionar fauna e vegetação em lote final, mantendo a leitura do Arco distante.
4. Reverter apenas o último lote se a porta, a rota, o mapa cartográfico ou a leitura de marcos sofrer regressão.

> A composição Dev5 é QA isolada. A promoção para `VossHouse.gd` requer revisão e commit próprio do Dev1/Dev7.
