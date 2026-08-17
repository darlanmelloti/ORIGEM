# Planta espacial CP 255 — Revelação dos 12 marcos a partir da Casa Voss

A referência aprovada redefine a saída da Casa Voss como uma **varanda natural sobre o Vale de Kheper**. A composição não é um painel: cada leitura deve ser uma malha tridimensional, em profundidade e encaixada na cartografia canónica de `CartographicAnchors.gd`.

## Leitura no ecrã

| Zona do enquadramento | Marcos do mapa | Tradução tridimensional obrigatória | Responsável |
|---|---:|---|---|
| Borda esquerda | 1 Casa Voss | Parede, porta aberta, beiral e lanterna enquadram a vista sem ocultar o vale. | Dev1 |
| Inferior esquerdo | 2 Estrada do Rio | Lajes antigas descem até uma ponte de pedra sobre água real. | Dev1 |
| Centro inferior | 3 Arco das Ruínas | Arco alto e atravessável, afastado da lente; silhueta distinta antes da floresta. | Dev1 |
| Centro-esquerda | 4 Floresta Densa | Bosque profundo de troncos e copas irregulares, aberto por um percurso visível. | Dev1 |
| Meio-esquerda | 5 Acampamento Majestic | Tendas, estandarte e luzes de fogo discretas numa crista oposta. | Dev1 |
| Centro | 6 Ruínas Submersas | Bacia turquesa, ruínas emergentes, queda de água e um núcleo arqueológico visível. | Dev1 |
| Flanco direito | 7 Vila Elevada | Cidade em socalcos e cascatas laterais, elevada sobre a bacia. | Dev2 |
| Direita superior | 8 Observatório | Cúpula de pedra isolada acima da Vila. | Dev2 |
| Horizonte central | 9 Trilha da Montanha | Trilha clara e serpentiforme que atravessa as cristas. | Dev2 |
| Horizonte alto | 10 Caverna Orion | Abertura escura numa montanha dominante. | Dev2 |
| Pico | 11 Câmara do Orion Cube | Brilho Chronos azul no cume, sem parecer uma esfera suspensa. | Dev2 |
| Inferior direito | 12 Hub Temporal | Círculo de monólitos e núcleo azul, visível mas fora do percurso imediato. | Dev2 |

## Regra de composição

A câmara abre a 16:9 com a Casa Voss a preencher no máximo 18% da largura à esquerda. A estrada curva para o Arco no terço inferior; a bacia ocupa o terço médio; a Vila e Orion fecham a pirâmide de profundidade. A câmara não pode apontar para uma planície vazia nem para o céu sem marcos.

## Ordem técnica Dev1

1. Criar uma soleira/varanda física imediatamente além da porta, com piso de pedra irregular e sem bloquear a rota.
2. Enquadrar a primeira tomada entre a casa à esquerda e a ponte/arco no primeiro plano, alinhando a mira da câmara com a bacia central em `x≈60, z≈252`.
3. Reforçar por geometria real os marcos 2–6: ponte, arco, copas em camadas, tendas, bacia, ruínas e quedas de água.
4. Reduzir a neblina de abertura apenas o suficiente para a leitura dos marcos e preservar a serra como destino distante.
5. Validar em captura de abertura, Novo Jogo, salto do prólogo e exploração de 30 segundos.

## Ordem técnica Dev2 e Dev03

Dev2 deve entregar silhuetas tridimensionais de baixo custo para 7–12, colocadas nas coordenadas canónicas e visíveis a partir da lente da Casa Voss, sem alterar módulos Dev1. Dev03 deve manter uma grelha de auditoria 16:9 que marque a presença, a posição relativa e a leitura de cada ponto 1–12. Nenhuma destas tarefas bloqueia o ciclo Dev1.
