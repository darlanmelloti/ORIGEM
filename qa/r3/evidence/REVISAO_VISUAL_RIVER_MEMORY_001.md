# Revisão Visual — DEV3-R3-RIVER-MEMORY-006

Duas capturas técnicas foram executadas sem UI. Ambas confirmam que o enquadramento de contexto não introduz novos obstáculos, mas não tornam os seixos suficientemente legíveis: a primeira é dominada pelo pilar e pela placa lateral; a segunda fica demasiado próxima do solo. A implementação material e a prova técnica continuam válidas, mas a evidência visual requer uma câmara centrada nas posições globais reais dos três seixos.

| Item | Estado |
|---|---|
| Montagem modular | Três `SphereMesh` achatados, laterais e sem texto estão instalados. |
| Contrato físico | A prova `[ORIGEM_R3_RIVER_MEMORY_OK]` confirmou o offset lateral, ausência de colisores, luz, áudio e UI. |
| Evidência visual | Pendente de reenquadramento dinâmico pelos seixos reais; a captura atual não será aceite como prova de leitura material. |

> A correção seguinte altera exclusivamente o script de captura de QA; não altera física, narrativa, luzes ou composição jogável.

## Revisão de materialidade

O alinhamento ao terreno resolveu a interseção e tornou os três seixos visíveis. Contudo, o enquadramento aproximado revelou uma tonalidade azul demasiado intensa e facetas demasiado evidentes, incompatíveis com a intenção de pedra húmida discreta. A correção seguinte reduz a componente azul e o reflexo metálico, aumenta a suavidade radial do `SphereMesh` e mantém a ausência total de emissão, luz e VFX adicional. A captura de contexto será usada para confirmar que os seixos se fundem ao marco sem desaparecerem.

## Revisão final — aceite

O assentamento pela altura real do terreno torna os três seixos plenamente visíveis na captura próxima. A revisão de pátina elimina o brilho metálico: os seixos aparecem como ardósia húmida escura no renderizador de compatibilidade, sem emissão e sem luz adicional. O enquadramento próximo é evidência de materialidade; a leitura de contexto continua delegada à captura de passagem, onde estes elementos permanecem laterais e subordinados ao Arco.
