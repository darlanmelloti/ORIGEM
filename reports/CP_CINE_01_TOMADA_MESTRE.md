# CP-CINE-01 — Especificação da Tomada Mestre Casa Voss → Vale de Kheper

## Base de referência

O mapa de autoridade distribui a viagem num vale em profundidade: Casa Voss no canto inferior esquerdo; Estrada do Rio e Arco no primeiro plano; Floresta e Acampamento no centro/esquerda; Bacia das Ruínas como massa hídrica central; Vila Elevada e Observatório no flanco direito; trilha, Caverna, Câmara Orion e o sinal Chronos na serra superior; Hub Temporal no quadrante inferior direito. A imagem conceptual confirma uma composição horizontal 16:9 em que a própria casa ocupa a margem esquerda como moldura tridimensional, e não como painel ou objeto isolado.

## Hierarquia de planos para Dev3

| Plano | Elementos a enquadrar | Responsável físico | Regra de realização |
| --- | --- | --- | --- |
| Primeiro plano esquerdo | Parede, porta, soleira e lanterna da Casa Voss | Dev1 | A arquitectura toca a margem esquerda sem cobrir o vale. |
| Primeiro plano inferior | Ponte, Estrada do Rio e Arco das Ruínas | Dev1 | Formas grandes e separadas, com linha de fuga para o centro. |
| Plano médio | Floresta Densa, Acampamento Majestic e Bacia | Dev1 | Massa orgânica em camadas, água central e nenhuma parede vegetal. |
| Flanco direito | Vila Elevada e Observatório | Dev2 | Leitura por socalcos e cúpula; nunca um farol ciano no prólogo. |
| Horizonte | Trilha, Caverna, Câmara Orion e cadeia montanhosa | Dev2 | Silhuetas escalonadas; emissão Chronos apenas depois da abertura. |
| Canto inferior direito | Hub Temporal | Dev2 | Sugestão por anel de monólitos em perspectiva, não por painel. |

## Contrato de câmara

A tomada mestre deve iniciar numa posição física utilizável da soleira ou do terraço da Casa Voss. A lente tem de preservar a escala macro; o enquadramento deve deslocar o eixo para a direita da casa para que a construção apareça à esquerda, enquanto a Estrada e o rio formam diagonais descendentes para a bacia. O campo de visão deve ficar entre 70° e 78°; valores maiores comprimem os marcos, e valores menores excluem o vale.

O Dev3 pode alterar somente `RegionalCinematicDirector.gd` para documentar e reproduzir takes de QA. Alterações de posição de Casa, terreno, ponte, rio, água, árvore, ruína ou montanha devem ser encaminhadas como requisitos aos proprietários Dev1/Dev2, sem modificação directa.

## Evidência actual e lacuna

A captura Dev1 recuperada no CP 288 comprovou que sinais técnicos ciano podem ser removidos temporariamente na abertura. Ainda falta atingir a moldura esquerda arquitectónica e a leitura simultânea dos marcos intermédios. Portanto, a lacuna actual é de **geometria e posição de câmara integrada**, não de pós-processamento nem de sinalização.

## CP-CINE-02 — iniciado automaticamente

Criar uma matriz comparativa entre a tomada actual e os critérios acima. A matriz deve indicar: elemento ausente, proprietário da alteração, parâmetro de câmara a testar, captura requerida e condição de aceitação. Assim que Dev1 fornecer uma nova captura da soleira, Dev3 deve repetir a comparação, actualizar a especificação e abrir CP-CINE-03 sem aguardar mensagem da direcção.
