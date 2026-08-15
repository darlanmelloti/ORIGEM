# ORIGEM — Teste da Fundação Chronos

## Objetivo

Esta versão conclui o polimento do interior do Santuário da Nascente e introduz o primeiro protótipo funcional de mudança temporal. A alteração de era, por enquanto, modifica luz, céu, bruma, saturação e atmosfera; a geometria própria do Egito Antigo será criada numa expansão seguinte.

## Rota de teste

| Etapa | Resultado esperado |
| --- | --- |
| Interior | A pedra do corredor e da Câmara do Cubo apresenta micro-relevo procedural, contraste de roughness e brilho mais forte nas superfícies molhadas. |
| Água | As poças laterais da Sala dos Poços são escuras e opacas, com reflexos condicionados ao que está visível no ecrã. |
| Braseiros | Os braseiros azulados desenham pontos de luz frios; a luz direcional e SSAO mantêm as colunas legíveis. |
| Partículas | A Ponte de Ressonância e a Câmara do Cubo possuem partículas azuis lentas; não devem impedir a leitura do caminho. |
| Console Chronos | Na Câmara do Cubo, mire no pedestal menor à direita do Cubo e prima `E`. O perfil deve alternar entre **Kheper — Crepúsculo** e **Egito Antigo — Sol do Vale dos Reis**. |
| Retorno | Prima `E` novamente no console para voltar ao perfil de Kheper. Nenhuma cena é trocada nesta etapa. |

## Perfis disponíveis no núcleo Chronos

| Perfil | Papel atual | Área futura preparada |
| --- | --- | --- |
| `KHEPER_TWILIGHT` | Vale de Kheper atual | Fundação do presente arqueológico. |
| `EGYPT_SUN` | Demonstração de transição | Vale dos Reis e templos P-0. |
| `NEW_YORK_100K` | Perfil reservado | Nova Iorque P-52, selva bioluminescente e ruínas verticais. |
| `PRIMAL_NIGHT`, `ASHEN_TWILIGHT`, `FUTURE_ASH` | Perfis reservados | Pré-história, era medieval e futuro P-47. |

## Limite de desempenho

Para a GTX 1050, mantenha o projeto em **Forward+** com escala 3D de 75%. Esta versão usa SSAO, SSR limitado a 32 passos e ReflectionProbes locais. Não ative névoa volumétrica global.
