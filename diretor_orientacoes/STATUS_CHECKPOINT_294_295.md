# CP 294–295 — Abertura da Casa Voss

## Estado aceite

O CP 294 introduziu uma ocultação de prólogo por nome e por material emissivo, executada também após 3,2, 6 e 12 segundos. A captura de compatibilidade `cp294_marker_filter.png` confirmou a remoção dos pontos ciano dominantes sem remover terreno, árvore, água, Arco ou rota física. A validação headless Godot concluiu sem erro.

## Experiências rejeitadas

A câmara sudoeste CP 292 trouxe pilares e cobertura para primeiro plano e obstruiu o vale. A rotação leste CP 295 deslocou a Estrada e o Arco, mas continuou sem entregar a Casa Voss na margem esquerda. Ambas foram revertidas; o miradouro compacto é a autoridade actual.

## Evidência de execução

A base restaurada foi executada por 42 segundos no renderizador `opengl3`, ultrapassando a exigência mínima de 30 segundos. A captura em compatibilidade é agora o método de QA estável no sandbox restaurado.

## Continuidade CP 296 — já iniciada

O próximo passe Dev1 não deve mover a câmara às cegas. Deve reforçar a leitura física do primeiro plano Casa–soleira–ponte por geometria orgânica e linha de vista, mantendo o miradouro compacto e submetendo qualquer alteração a captura comparativa em compatibilidade e gameplay de 30 segundos.
