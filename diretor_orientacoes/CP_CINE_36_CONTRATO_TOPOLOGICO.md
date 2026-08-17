# CP-CINE-36 — Contrato Topológico de Interior Fechado

Antes de qualquer nova captura interior, o protótipo deve provar que a câmara fica dentro de uma envolvente espacial completa. Não será aceite uma composição cuja leitura dependa de painéis decorativos soltos.

| Superfície | Função | Condição de aceitação |
|---|---|---|
| Piso | Suporte visual e físico | Uma malha contínua e um colisor derivado da mesma geometria |
| Parede esquerda | Limite lateral | Une piso e teto sem lacuna de céu |
| Parede direita | Limite lateral | Une piso e teto sem lacuna de céu |
| Teto | Oclusão superior | Cobre integralmente o frustum da câmara interior |
| Fundo | Profundidade e desvio de rota | Fecha a visão directa e sugere continuidade lateral |
| Entrada de teste | Única abertura controlada | Mantida atrás da câmara QA, fora do cone de captura |

A sonda CP-CINE-36 contará quatro superfícies de oclusão activas (piso, duas paredes e teto) e verificará que o fundo está à frente da câmara. Se a topologia não fechar, a captura não será realizada.
