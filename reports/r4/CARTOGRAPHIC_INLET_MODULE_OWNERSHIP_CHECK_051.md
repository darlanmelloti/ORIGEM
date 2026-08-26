# ORIGEM — Verificação de Propriedade Modular do Afluente R4 051

**Tarefa:** `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-OWNERSHIP-CHECK-051`
**Estado:** Verificação documental aprovada; nenhuma candidata de produção criada

## Causalidade confirmada

A leitura observada em `arch_to_forest` continua ligada à lâmina ampla `LaminaDoAfluenteCartografico`, construída em `ForestLakeRegion.gd` e ligada à fábrica `_create_lake_material()`. A fábrica usa `depth_draw_opaque` e `ALPHA = 1.0`; portanto, a causa permanece dentro da superfície e do material lacustre partilhado, não nas duas raízes R4 inventariadas.

As variantes de transparência, cota, largura e `cull_back` permanecem rejeitadas pelo contrato canónico. A correcção local anteriormente publicada foi retirada durante a reconciliação e não existe override local de material na lâmina.

## Responsabilidade e limites

| Tema | Responsável primário | Validação necessária | Estado nesta tarefa |
|---|---|---|---|
| Clareira Orion, corredor e leitura de aproximação | Dev4/R4 | Dev1 | Preservados; nenhuma alteração |
| Lâmina e material lacustre | Dev6/R6 | Dev4 + Dev1 | Sem autorização para intervenção unilateral |
| Água, quatro luzes e handoff R6→R7 | Dev6/R6 | Dev1 | Imutáveis |
| Margem modular externa | Dev4/R4 somente após aprovação conjunta | Dev6 + Dev1 | Duas referências apenas inventariadas |
| Captura comparativa | Dev4/QA | Dev6 + Dev1 | Roteiro definido; não executado sem candidata aprovada |

> **Conclusão de propriedade:** não existe aprovação explícita R4/R6 para alterar as raízes inventariadas, a geometria do afluente ou o material de água. Por isso, esta tarefa não promove qualquer referência a candidata de produção.

## Roteiro QA para futura captura comparativa

O roteiro é condicional e só pode ser executado por uma tarefa posterior que receba aprovação conjunta e identifique uma candidata não equivalente às quatro variantes rejeitadas.

| Passo | Condição de entrada | Evidência exigida | Operação permitida |
|---|---|---|---|
| 1. Baseline | Contracto e ponta integrada confirmados | Captura `arch_to_forest` 16:9, pós-carregamento estabilizado, sem candidata | Capturar somente QA |
| 2. Causalidade | Nó, asset, posição e dono identificados | Distância ≥8 m, exclusão de `Z≈126–151`, sem água/luz/colisor | Registar proposta, não aplicar |
| 3. Aprovação | Consentimento explícito Dev4/R4 e Dev6/R6 | Referência canónica de aprovação | Autorizar candidata temporária separada |
| 4. Comparação | Baseline e candidata com enquadramento idêntico | Par de imagens, logs e leitura comparativa | Avaliar sem mascaramento |
| 5. Gate | Não regressão espacial e técnica | Parser, `git diff --check`, orçamento, gates R4/R6 e rotas | Decidir somente com evidência completa |

A candidata permanece **não criada**. Não foram adicionados geometria, material, luz, colisor, partícula, efeito de ocultação, nó de cena ou mudança de produção.

## Preservação verificável

| Limite | Estado |
|---|---|
| Clareira Orion `Z≈126–151` | Livre |
| Corredor R4 | Referências inventariadas a 8,75 m e 9,20 m; nenhuma modificação |
| Lâmina partilhada | Sem override local; material lacustre canónico presente |
| R6 | Água, quatro luzes, handoff, lajes e rotas sem alteração |
| R5 | Sem alteração |
| Produção nesta tarefa | Zero alterações |

## Sucessão

A próxima tarefa activa é `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-CAPTURE-READINESS-052`. Ela deve continuar exclusivamente em QA documental: verificar que o roteiro de baseline está executável e que uma eventual captura futura continuará separada de qualquer candidata, sem alterar produção até que exista aprovação explícita conjunta.
