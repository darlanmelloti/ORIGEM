# STATUS CHECKPOINT 336 — Orçamento de luzes na abertura e handoff

**Estado:** aceite; não foi necessária alteração de iluminação.

## Método

A sonda CP 336 instanciou a cena real, mediu todos os `Light3D` visíveis e, em seguida, calculou as luzes que alcançam a posição da câmara activa. A contagem global é superior ao orçamento porque o mundo regional é carregado de uma vez; ela não representa luzes a sombrear o mesmo sector. O critério operacional para a GTX 1050 Ti é a carga local simultânea no cone/célula da câmara.

| Momento | Luzes globais visíveis | Luzes locais activas | Luzes locais com sombra | Margem para o limite de 16 |
|---|---:|---:|---:|---:|
| Abertura CP317/CP331 | 49 | 1 | 1 | 15 |
| Handoff do prólogo | 78 | 4 | 2 | 12 |

## Decisão

A abertura e o handoff mantêm margem substancial para o orçamento de 16 luzes dinâmicas simultâneas. Não se apagaram luzes remotas, pois elas não incidem na câmara do jogador na Casa Voss e permanecem necessárias aos respectivos sectores de exploração. O sol e a luz do jogador são as únicas fontes com sombra que entram na verificação local do handoff.

## Continuidade

A sonda temporária será removida antes do commit. O próximo retorno cinematográfico activo continua a ser CP-CINE-07, dependente da integração Dev2 R7–R9 e da recaptura Casa Voss com a matriz congelada.
