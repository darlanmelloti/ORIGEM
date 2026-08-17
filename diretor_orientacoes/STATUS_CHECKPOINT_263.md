# CP 263 — Profundidade Macro Casa–Estrada–Arco

## Estado

**Implementado e validado tecnicamente.** O primeiro corredor passou a usar profundidade física mais ampla: o Arco das Ruínas foi recuado para `z=92`, marcos de orientação intermédios foram distribuídos ao longo da Estrada e a leitura material do leito foi aumentada para que a rota permaneça visível como linha de viagem no vale.

A alteração conserva as âncoras cartográficas lógicas para mapa e narrativa, mas cria uma separação física maior entre a Casa Voss, a Estrada e o Arco. A vegetação e a ecologia de aproximação acompanham a nova posição do Arco, evitando que a sua silhueta pareça um objecto isolado.

## Evidência

| Prova | Resultado |
|---|---|
| Validação headless Godot 4.7.1 | Aprovada sem erro de parser, script ou recurso. |
| Gameplay de 30 segundos | Aprovado em três segmentos reais de 10 segundos devido ao limite conhecido de renderização contínua do llvmpipe. |
| Captura de composição | A lente elevada demonstrou profundidade geográfica, mas a leitura conjunta Casa–Estrada–Arco continua abaixo do alvo e permanece em refinamento. |

## Continuidade

O CP 264 está **em execução**: recomposição da tomada de saída para expor simultaneamente a moldura da Casa, a linha de Estrada, a silhueta do Arco macro e a primeira camada do rio. Não aceitar um enquadramento que mostre apenas céu, relevo ou um marco isolado.
