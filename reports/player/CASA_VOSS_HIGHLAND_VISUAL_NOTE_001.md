# Casa Voss — Nota Visual da Hipótese 001

## Prova observada

As capturas da sonda `QA-CASA-VOSS-HIGHLAND-060` mostram que o novo patamar e a sequência de lajes são superfícies físicas contínuas. A sonda percorreu a descida e a Estrada sem travamento, com queda de cota medida de 2,551 m e `845` frames em contacto com o chão.

## Leitura visual provisória

| Captura | Resultado | Limite da evidência |
| --- | --- | --- |
| `00_highland_start.png` | A descida de lajes é legível e aponta para a Estrada/Arco. | O spawn de QA olha para a Estrada; a fachada Casa Voss não entra no enquadramento. |
| `30_highland_mid.png` | A rota continua no vale físico, sem parede ou fundo falso. | É uma captura de exploração, não uma tomada de composição da saída. |

> A prova atual confirma a física e a legibilidade da descida, mas não substitui a captura lateral de composição exigida para avaliar a Casa à esquerda no primeiro plano.

## Próximo marco

Gerar uma captura lateral 16:9 a partir da soleira, com a fachada no terço esquerdo, a descida no plano médio e a direção do vale/Orion preservada. Esta captura será o artefacto enviado ao Dev4 para aplicação da rúbrica publicada na issue #507.

## Revisão da hipótese após a captura lateral

A captura interna tardia confirmou que a primeira hipótese não satisfaz ainda a referência visual: o suporte retangular do patamar aparece como parede alta no lado esquerdo e domina o primeiro plano, enquanto a massa da Casa Voss não é lida como fachada doméstica. Embora a descida física tenha passado no teste de 60,45 segundos, esta composição deve ser rejeitada antes de qualquer publicação.

> A correção seguinte substituirá a elevação por blocos verticais por uma crista contínua no `TerrainPatch`, mantendo a casa apoiada no solo físico e reduzindo as lajes a uma camada superficial. O objetivo é conservar a mesma diferença de cota sem criar uma parede artificial, nem alterar âncoras ou rotas.
