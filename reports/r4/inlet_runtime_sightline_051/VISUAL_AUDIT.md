# Auditoria Visual — Linha de Visão do Afluente R4 051

| Campo | Resultado |
|---|---|
| **Task ID** | `DEV4-R4-CARTOGRAPHIC-INLET-RUNTIME-SIGHTLINE-051` |
| **Captura** | `arch_to_forest_baseline.png`, 1600×900, viewport gráfico OpenGL. |
| **Mutação de produção** | `0`. A câmara QA e a ocultação de UI existiram somente durante a sessão. |
| **Luzes R4** | `1`, a baliza local aprovada. |
| **Luzes R6** | `4`, com os quatro nomes obrigatórios preservados. |
| **Rotas / física** | Não alteradas; a prova é observacional. |

## Leitura observada

A baseline demonstra que o afluente é uma faixa contínua, ampla e opaca que ocupa grande parte do primeiro plano e do centro do enquadramento. A leitura confirma o diagnóstico anterior: a causa visível está associada à lâmina cartográfica e não foi resolvida pelas variantes de transparência, cota, largura ou `cull_back`, todas já rejeitadas.

As medições QA dos cinco pontos mostram separação planar crescente face ao eixo do corredor, de `15,019 m` a `35,417 m`. A captura preserva a rota física à direita do enquadramento e não demonstra invasão do corredor. Contudo, essa distância não autoriza criar uma nova massa ambiental: as rochas e os fetos do afluente pertencem ao mesmo nó-raiz da lâmina e continuam inelegíveis como solução modular independente.

> **Decisão:** a baseline é evidência de uma dívida visual legítima, mas **não** é prova suficiente para uma correção de produção. Não será aplicada alteração de material, água, geometria, largura, cota, culling, luz, colisão, câmara, rota ou âncora.

## Invariantes confirmadas

| Invariante | Evidência |
|---|---|
| Cinco pontos cartográficos | Telemetria listou os cinco pontos originais. |
| Material / geometria de produção | Runner não escreve em recursos, nós ou cenas. |
| R4 | Uma única luz local detetada. |
| R6 | Quatro luzes obrigatórias detetadas: `PreenchimentoMundialDoLago`, `PreenchimentoOpostoDoLago`, `PreenchimentoAzulDaMargem` e `LuzSubaquaticaCentral`. |
| Captura | PNG 16:9 1600×900, com UI ocultada somente no runner QA. |

## Próxima análise

A próxima tarefa deve reconciliar esta baseline com o enquadramento normal do jogador e verificar se a dívida permanece dominante durante uma travessia real `arch_to_forest`. Ela continua estritamente QA: deverá comparar a leitura de câmara QA e câmara de jogador sem introduzir qualquer override ou modificação do mundo.
