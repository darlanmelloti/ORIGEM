# CP 264 — Recomposição Macro da Saída Casa–Estrada–Arco

## Alteração executada

A tomada de saída foi rebaixada e alargada para recuperar mais chão de vale, mantendo a Casa Voss como moldura parcial, o rio como linha lateral e o Arco das Ruínas no plano médio direito. Foi acrescentada uma faixa física conformada ao terreno que prolonga a leitura da Estrada entre `z=26` e `z≈92`, coincidente com o corredor de jogo e sem colisores adicionais.

A recomposição respeita a profundidade macro definida no CP 263: não aproxima o Arco, não cria fundos artificiais e não comprime o espaço de viagem. O Arco continua na posição física `z=92`; os marcos intermédios e o material do leito dão continuidade à rota.

## Validação

| Prova | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado sem erros de parser, scripts ou recursos. |
| Tomada Casa Voss | Aprovada tecnicamente; a rota e o Arco passam a estar presentes, mas a composição ainda está abaixo da referência de 12 marcos. |
| Exploração de 30 segundos | Aprovada em três segmentos reais de 10 segundos por causa do limite conhecido do llvmpipe em renderização contínua. |

## Continuidade

O **CP 265 — Legibilidade atmosférica e silhuetas de plano médio** está em execução. O passe seguinte deve recuperar contraste natural entre Estrada, rio, Arco e montanha, reduzir elementos azuis não narrativos na tomada e preparar a recaptura Dev3 0C. Não será aceite uma imagem em que os marcos cartográficos sejam menores que os artefactos de QA ou se confundam com o terreno.
