# Casa Voss — Hipótese de Abertura Elevada 002

## Escopo

Esta entrega constrói apenas a leitura inicial da Região 1: Casa Voss apoiada num esporão de terreno contínuo, uma sequência superficial de lajes que acompanha a descida e o eixo jogável que continua para a Estrada do Rio. Não altera `CartographicAnchors`, rotas canónicas, luzes, água, R2–R6 ou o contrato de regiões posteriores.

## Mudança espacial

| Elemento | Solução | Limite preservado |
| --- | --- | --- |
| Cota da Casa Voss | Elevação contínua de até 2,40 m no `TerrainPatch`. | A âncora X/Z de Casa Voss não se moveu. |
| Descida | Oito lajes visuais seguem o declive real do terreno. | O `TerrainPatch/ColisaoDoTerreno` é o único piso físico. |
| Abertura | A descida aponta para a Estrada/Arco e mantém o vale como plano posterior. | Não cria atalho, bloqueio lateral ou nova rota. |
| Horizonte | A rota conserva a leitura existente para o Arco e a futura direção Orion. | Não introduz caverna, asset de R7 ou fundo falso. |

## Validação executada

| Prova | Resultado |
| --- | --- |
| Parser Godot 4.7.1 + `git diff --check` | PASS |
| `QA-CASA-VOSS-HIGHLAND-060` por teclado X11 físico | PASS — 60,33 s, 42,344 m, 906 frames no chão, W/A/S/D observados, descida de 1,881 m. |
| `QA-POST-PROLOGUE-INPUT-060` por teclado X11 físico | PASS — 60,02 s, 41,322 m, 114 frames no chão, W/A/S/D com movimento. |
| Porta regional R2 | PASS — estabilidade R1→R2, marcos físicos e rotas `road_to_arch`, `positive_bridge`, `road_return_voss`. |

## Evidência visual

- `qa/player/casa_voss_highland_start_1600x900.png` mostra o patamar e a descida imediatamente após o spawn técnico.
- `qa/player/casa_voss_highland_mid_1600x900.png` mostra continuidade da rota no vale durante a prova.
- `qa/player/casa_voss_postprologue_60s_1600x900.png` é uma evidência de gameplay pós-prólogo com input físico.

## Limitação para revisão Dev4

Esta hipótese resolve a **topografia e a circulação**, não a composição final da referência. A captura de rota ainda privilegia o caminho e o Arco, e não coloca a fachada de Casa Voss no terço esquerdo. Dev4 deve aplicar a rúbrica da issue #507 a estas provas e devolver requisitos de enquadramento ao Dev1; não deve modificar produção.
