# CP-D5-078 — Lacunas cartográficas Dev5 R1–R6

## Cobertura actual de QA

| Marco | Cobertura Dev5 existente | Leitura |
|---|---|---|
| R1 — Casa Voss | Anexo, ancoragem R1/R2 e rumo Casa→Estrada | Cobertura técnica média |
| R2 — Estrada do Rio | Marco de ponte, composição R1/R2 e travessia Elias | Cobertura técnica alta |
| R3 — Arco | Corredor Elias com alvo físico `Z=92` | Cobertura técnica média |
| R4 — Floresta Densa | Vegetação aterrada, LOD e corredor de Elias | Cobertura técnica alta |
| R5 — Acampamento Majestic | Pavilhão aterrado, Elias e vegetação | Cobertura técnica alta |
| R6 — Ruínas Submersas | Baliza, folga, Elias, vegetação e handoff R7 | Cobertura técnica alta |

## Lacuna prioritária

A menor cobertura Dev5 encontra-se em **R1 — Casa Voss**, mas qualquer mudança da porta, casa, colisores ou prólogo pertence ao Dev1. Por isso, a próxima acção permitida não altera o módulo de produção: será uma prova isolada de **orientação de Elias a partir da âncora R1 para o primeiro rumo cartográfico R2**, usando apenas a apresentação Dev5 e balizas QA.

## Exclusões preservadas

A lacuna não autoriza a repetição de candidatos rejeitados: arco estrutural, ponte GLB leve e cais de lajes cúbicas permanecem excluídos. Também não autoriza alteração a `VossHouse.gd`, à porta [E] ou a `Player.gd`.

## Próxima tarefa automática

**CP-D5-079 — Elias orientação R1 de saída.** Validar a leitura de Elias na âncora Casa Voss e o rumo imediato para a Estrada do Rio, com câmara externa, sem alterar casa ou porta de produção.
