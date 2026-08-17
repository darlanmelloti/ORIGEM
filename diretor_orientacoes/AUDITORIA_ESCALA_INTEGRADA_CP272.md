# CP 272 — Auditoria de Escala Integrada: Casa Voss → Bacia

## Resultado

O mapa oficial permanece a autoridade espacial. A rota Dev1 possui cinco intervalos físicos progressivos e não deve ser comprimida para resolver lacunas de composição. A análise confirma que as camadas de terreno, água, trilho, ruínas e vegetação estão construídas nos módulos Dev1; a principal lacuna remanescente é a **leitura simultânea de múltiplas camadas na tomada de saída**, que depende de composição e das silhuetas Regionais 7–12 sob responsabilidade Dev2.

| Segmento cartográfico | Distância canónica no mundo | Construção física confirmada | Leitura actual | Próxima acção |
|---|---:|---|---|---|
| Casa Voss → Estrada do Rio | 4,04 m | Soleira, lajes e marcos laterais | Imediata | Manter a moldura de saída e a recuperação de câmara sem encurtar o percurso |
| Estrada do Rio → Arco das Ruínas | 36,30 m | Solo compacto, lajes, rio, taludes e Arco em `z=92` | Boa no eixo da Estrada | Refinar o contraste de materiais e a continuidade hídrica sem aproximar o Arco |
| Arco → Floresta Densa | 68,44 m | Limiar, clareiras, árvores, rochas e fetos escalonados | Boa em camadas | Preservar a abertura central; evitar uma parede de floresta |
| Floresta → Acampamento Majestic | 100,42 m | Trilho, conector, tendas, fogueira e mastros de chegada | Parcial à distância | Dev3 deve enquadrar a chegada e Dev1 mantém a silhueta física |
| Acampamento → Ruínas Submersas | 165,46 m | Margem, lajes, bacia, pilares, domo, cascata e promontório | Parcial, mas destino materializado | Preparar a tomada da margem ocidental e manter a Vila fora do escopo Dev1 |

## Conformidade técnica

A sonda regional aprovou a presença simultânea do orquestrador, Estrada, solo da Estrada, Arco, Floresta e Casa Voss. As mudanças recentes foram validadas em Godot 4.7.1 headless. O gameplay obrigatório é executado em três segmentos reais de 10 segundos no llvmpipe, perfazendo 30 segundos sem falsificar a duração de exploração.

## Lacunas com proprietário

| Lacuna | Proprietário | Ordem activa |
|---|---|---|
| Tomada 16:9 que reúna Casa, Estrada, Arco, rio, floresta, bacia e silhuetas futuras | Dev3 | Recaptura 0C com grelha de legibilidade, sem FOV extremo ou escurecimento |
| Vila Elevada, Observatório, Trilha, Caverna, Câmara e Hub como silhuetas de profundidade | Dev2 | CP-D2-006, mantendo a fronteira Regiões 7–12 |
| Contraste, hidrologia, escala de trilhos e chegada à Bacia | Dev1 | CP 273 — Integração da leitura hídrica Estrada → Bacia |
| Verificação de retorno de evidências e orçamento de luzes | Dev4 | DIR-118 com artefacto material obrigatório |

## Regra de continuidade

Esta auditoria não encerra o ciclo. O CP 273 inicia imediatamente e deve ligar, por meio de sinais físicos consistentes, a leitura do rio da Estrada à água da Bacia sem alterar a escala macro nem introduzir fundos artificiais.
