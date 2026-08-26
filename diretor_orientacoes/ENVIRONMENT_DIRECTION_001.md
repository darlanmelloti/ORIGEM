# ORIGEM — Direção Ambiental 001

> **Objetivo:** absorver o método de construção de ambiente dos tutoriais de referência sem copiar conteúdo, sem transformar ORIGEM em uma imitação de *Elden Ring* e sem introduzir atalhos visuais incompatíveis com o mundo físico explorável.

| Campo | Decisão |
|---|---|
| **Referências estudadas** | *Create A Elden Ring Environment In UE5* e *How I Built This Elden Ring Environment in Unreal Engine 5*. [1] [2] |
| **Motor de destino** | Godot 4.7.1, renderer Compatibility/OpenGL. |
| **Perfil de desempenho** | GTX 1050 Ti; prioridade para geometria modular económica, instanciamento e LOD, não para força bruta. |
| **Limites ORIGEM** | Mapa, âncoras, rotas, colisores, sequência R1→R6 e orçamentos regionais de luz são autoridade. |
| **Estado** | Direção QA; não autoriza alteração de produção. |

## 1. O que deve ser transferido

Os dois tutoriais convergem num método sólido: começar pela referência e pelo **blockout legível**, validar a escala com a personagem, definir uma vista dominante e somente depois distribuir materiais, vegetação e detalhe. O primeiro usa um caminho em U que sobe para um mirante; o segundo reduz uma fortaleza complexa a um kit de arcos, colunas e blocos reutilizáveis. [1] [2]

No ORIGEM, isto significa que cada região deve ter uma cadeia explícita de três leituras: **chegada**, **orientação do percurso** e **recompensa de vista**. A melhoria não pode resultar de uma parede de árvores, um fundo falso ou uma cortina de efeito: precisa de surgir da relação entre relevo físico, marcos existentes, materiais e a posição real do jogador.

| Princípio de ambiente | Tradução para ORIGEM | Verificação obrigatória |
|---|---|---|
| Blockout antes do detalhe | Medir a rota com Elias e identificar os enquadramentos de chegada/saída antes de mexer em materiais ou adereços. | Captura pela câmara do jogador e rota regional. |
| Escala humana | Usar `Player` como régua para altura de ruínas, largura de corredor e distância até marco. | Colisão, inclinação e corredor mínimo preservados. |
| Vista dominante | Cada região ganha somente uma intenção visual legível: arco, clareira, acampamento ou bacia. | Frame 16:9 da rota real; sem câmara de produção alterada. |
| Kit modular | Reutilizar rocha, pilar, estela e árvore existentes como famílias coerentes, não duplicar assets pesados. | Sem criação especulativa de cenas ou geometria. |
| Set dressing em camadas | Primeiro plano físico, midground narrativo e fundo com silhueta simples, cada qual subordinado à rota. | Sem painel, neblina plana, partículas ou emissões para esconder defeitos. |

## 2. O que não será transplantado

O uso de Nanite, Megascans de milhões de triângulos, Lumen, PCG volumoso, *fog cards* e partículas contínuas é uma resposta específica de UE5 e não é adequado ao orçamento do ORIGEM. Os tutoriais usam esses recursos como ferramentas; o princípio a preservar é a hierarquia visual, não a tecnologia empregada. [1] [2]

| Recurso UE5 observado | Decisão no ORIGEM | Motivo |
|---|---|---|
| Nanite e scans muito densos | **Rejeitado** | A GTX 1050 Ti exige controle explícito de polígonos, materiais e VRAM. |
| Lumen e névoa volumétrica pesada | **Rejeitado como base** | Não devem substituir composição física nem comprometer o renderer Compatibility. |
| Fog cards | **Rejeitado** | Constituem plano/fundo artificial, proibido pelas regras do projeto. |
| Niagara e queda contínua de folhas/cinzas | **Rejeitado nesta fase** | Partículas não podem mascarar a dívida visual nem criar custo persistente. |
| PCG indiscriminado | **Rejeitado** | A dispersão não pode criar repetição, parede vegetal ou invadir rotas. |

## 3. Implementação Godot compatível

Godot permite combinar LOD automático de malha e *visibility ranges* em `GeometryInstance3D`, inclusive `MeshInstance3D` e `MultiMeshInstance3D`. A documentação recomenda usar *visibility ranges* para HLOD controlado pelo artista e manter margens de histerese para evitar alternâncias visíveis. [3] O LOD automático é gerado na importação de cenas 3D e pode ser avaliado por redução de primitivas e ganho de FPS no editor. [4]

Para ORIGEM, a regra é simples: **não acrescentar mais conteúdo até que o conteúdo existente esteja classificado por distância e função de leitura**. Uma rocha próxima pode manter material completo; a silhueta distante deve usar material mais simples e LOD automático, desde que o teste de rota confirme a continuidade visual. O `WorldEnvironment` continua a ser global e único; por isso, qualquer modulação de cor ou ambiente precisa primeiro de baseline comparativa, não de alteração global impulsiva. [5]

| Camada | Técnica Godot autorizável após QA | Limite |
|---|---|---|
| Primeiro plano | Malhas e colisores existentes; material local calibrado. | Não alterar a rota, água ou física. |
| Midground | HLOD/`visibility_range` sobre agrupamentos existentes, com margem de histerese. | Não criar transparência para transições. |
| Fundo | LOD automático na importação e material distante mais simples, quando medido. | Não introduzir painel, horizonte falso ou parede de árvores. |
| Vegetação | Reutilização lateral de instâncias existentes; só avaliar `MultiMeshInstance3D` após prova de culling e densidade. | Sem preenchimento contínuo nem invasão da clareira/corredor. |
| Ambiente | Paleta e orientação solar apenas após captura comparativa. | Sem novas luzes fora do orçamento regional. |

## 4. Primeira aplicação proposta: diagnóstico de leitura ambiental

A primeira aplicação não é uma alteração estética de produção. É uma **auditoria de seis vistas reais do jogador**: uma chegada e uma saída por R2–R6. Ela estabelece uma folha de estilo mensurável para as decisões seguintes, sem mexer em mapa, âncoras, câmara, Player ou luzes.

| Região | Vista a medir | Pergunta de composição |
|---|---|---|
| R2 — Estrada do Rio | `road_to_arch` | O rio conduz até ao Arco ou divide a leitura do percurso? |
| R3 — Arco das Ruínas | `arch_to_forest` | O arco enquadra a transição sem bloquear a floresta? |
| R4 — Floresta Densa | `forest_to_majestic` | As massas laterais orientam sem formar uma parede? |
| R5 — Acampamento Majestic | `majestic_to_lake` | Os sete alvos formam uma hierarquia legível no percurso? |
| R6 — Ruínas Submersas | `forest_to_ruins` | Os marcos arqueológicos distinguem a entrada da bacia sem iluminação nova? |

A saída deve ser somente: seis capturas 1600×900, telemetria de câmara/rota, orçamento de luz e uma matriz de leitura. A tarefa **não** autoriza material, geometria, água, luz, partículas, colisão, câmara, âncora ou alteração de rota.

## 5. Critério de passagem para a produção

Uma intervenção regional só será proposta se uma captura de jogador demonstrar um problema verificável e se houver uma solução física local que respeite a família de marcos existente. A melhoria deverá ser percebida sem depender de emissão, luz suplementar, plano de fundo, partículas ou distorção da rota. Depois, parser, prova regional, orçamento, todas as rotas da região e a CI cumulativa são obrigatórios.

## Referências

[1]: https://www.youtube.com/watch?v=XWGhI801LQE "Create A Elden Ring Environment In UE5 (Tutorial)"
[2]: https://www.youtube.com/watch?v=aD-jccIFTbY "How I Built This Elden Ring Environment in Unreal Engine 5"
[3]: https://docs.godotengine.org/en/stable/tutorials/3d/visibility_ranges.html "Godot Docs — Visibility ranges (HLOD)"
[4]: https://docs.godotengine.org/en/stable/tutorials/3d/mesh_lod.html "Godot Docs — Mesh level of detail (LOD)"
[5]: https://docs.godotengine.org/en/stable/classes/class_worldenvironment.html "Godot Docs — WorldEnvironment"
