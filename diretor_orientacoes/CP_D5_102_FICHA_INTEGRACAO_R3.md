# CP-D5-102 — Ficha de Integração R3: Corredor Arco Vivo

## Finalidade

Integrar o candidato `R3LivingArchCorridorPreview.tscn` no corredor Arco→Floresta, sem criar arco estrutural, portal florestal ou encurtar a projecção física do Arco em z≈92.

| Elemento | Regra | Restrição |
|---|---|---|
| Corredor | Manter eixo físico rumo à Floresta | Não reduzir a leitura de profundidade |
| Ruínas laterais | Peças baixas e assimétricas | Nunca formar arco, lintel ou passagem artificial |
| Vegetação | Fauna e flora laterais com LOD limitado | Corredor central sempre livre |
| Fauna | Ambiental e sem colisor bloqueante | Afastada do percurso de Elias |
| Luz | Ambiente existente | Sem luz dinâmica adicional |

## Sequência Dev1/Dev7

1. Integrar somente ruínas laterais e validar `arch_to_forest` por 36 segundos.
2. Adicionar flora/fauna em lote separado e confirmar a silhueta do Arco no percurso.
3. Reverter o lote mais recente se a leitura de z≈92, a rota ou a escala cartográfica sofrer regressão.

> A cena Dev5 permanece como prova isolada; a alteração de produção pertence ao Dev1/Dev7.
