# CP 292 — Comparação de Câmara da Soleira

A captura em modo de compatibilidade tornou a avaliação visual fiável. A posição sudoeste testada em CP 292 deve ser rejeitada: embora aproxime a arquitectura, introduz um pilar e cobertura em primeiro plano à direita, retira a Casa da margem esquerda e encobre o corredor do vale. A composição não atinge o limiar visual do projecto.

A base anterior do miradouro compacto deve ser restaurada. A próxima tentativa não deve deslocar a câmara para dentro da própria Casa; deve trabalhar a linha de vista exterior, a remoção dos emissores técnicos e a leitura em camadas do rio, Estrada e Arco. A captura em `opengl3` é agora o método de comparação estável no sandbox.

## CP 296 — Rotação oeste

A rotação oeste melhorou a leitura da massa baixa da Casa/soleira no canto inferior esquerdo e manteve Estrada, rio e Arco visíveis. Contudo, a ponte transversal deixou de ser um marco legível e a Casa ainda não possui a leitura arquitectónica integral exigida. A candidata não deve ser aceite como tomada final; serve apenas como evidência de que a rotação deve ser ajustada em pequenos incrementos, mantendo a câmara física do miradouro.

## CP 297 — Rotação intermédia

A rotação intermédia preserva uma pequena leitura da soleira no canto inferior esquerdo e mantém o Arco e a estrada, mas ainda não torna a Casa Voss uma silhueta arquitectónica reconhecível nem recupera a ponte transversal como marco. Não satisfaz o limiar de aceitação e não deve ser publicada como tomada final. A próxima iteração deve reforçar a silhueta física do próprio marco ponte/soleira em vez de prolongar micro-rotações da lente.

## CP 299 — Lente baixa

A redução da altura da lente ampliou apenas a cobertura no primeiro plano inferior, sem revelar uma fachada reconhecível da Casa Voss e sem melhorar a leitura da ponte. O resultado não deve ser aceite. A altura de câmara deve regressar ao valor do miradouro compacto; a continuidade passa a exigir correcção de geometria e não outra redução de altura.

## CP 300 — Posição exterior leste

A posição exterior leste abriu o rio e tornou a ponte mais fácil de localizar, mas excluiu a Casa Voss da moldura. Como a referência exige explicitamente a Casa à esquerda, a candidata é rejeitada. A posição não será mantida; a evidência confirma que a próxima solução deve introduzir uma fachada física reconhecível sem afastar a lente do perímetro da casa.

## CP 301 — Diagonal sudeste

A diagonal sudeste provou que a Casa Voss é lida no lado direito da lente, com cobertura e pilar invasivos, enquanto a árvore ocupa a margem esquerda. Isto contradiz a composição desejada e elimina a candidata. A leitura confirma que a inversão de lado não é resolvida por deslocamentos da câmara; o próximo passe deve tratar a composição por geometria da soleira e da fachada, mantendo o vale desobstruído.

## CP 303 — Tomada histórica refinada

A tomada a oeste é a primeira captura a colocar uma massa inequívoca de cobertura da Casa Voss no lado esquerdo, preservando Estrada e Arco à direita. Contudo, a Casa continua a ser lida apenas pela cobertura, o rio/ponte não está suficientemente destacado e a parcela de céu continua excessiva. A configuração é a melhor base parcial, não a tomada final. O próximo refinamento deverá expor a fachada/ala abaixo da cobertura e reforçar uma leitura física da ponte sem ocultar o vale.

## CP 304 — Tomada histórica inclinada

A inclinação reduziu a proporção de céu e preservou a massa de cobertura da Casa Voss à esquerda, estrada e Arco. Ainda não revelou fachada suficiente nem deu leitura clara à ponte; é a melhor base parcial entre as tomadas testadas, mas não satisfaz a referência. O próximo ciclo deve parar de micro-ajustar a lente e trabalhar os marcos físicos intermédios da bacia.

## CP 307 — Ponte lateral reforçada

A elevação e a escala adicional da ponte lateral passaram a validação técnica, mas não produziram um ganho perceptível na tomada histórica: o marco continua encoberto pelo relevo e pelo primeiro plano da Casa. A candidata visual não deve ser aceite como solução cinematográfica. A geometria pode ser preservada para exploração, mas a próxima tentativa deve actuar na relação entre a crista topográfica e a linha de visão, não apenas escalar a ponte.

## CP 307 — Janela topográfica de ponte

A janela topográfica natural foi implementada, compilada e recapturada, mas não expôs a ponte lateral de forma perceptível na tomada histórica. A alteração foi revertida integralmente em `TerrainPatch.gd`; o relevo validado anterior é a base vigente. O próximo passe deverá trabalhar exclusivamente a silhueta estrutural e as margens de encontro da ponte, sem alterar a escala do mapa ou a crista do vale.

## CP 308–310 — Encontros de ponte e leitura diurna

O deslocamento do pilar de aproximação e as bases rochosas de encontro da ponte foram testados e revertidos: não resultaram numa silhueta perceptível na tomada histórica. O CP 309 de calibração diurna foi preservado por melhorar a leitura da parede da Casa, água e vegetação sem acrescentar luzes, tendo passado também na prova de 30 segundos. O próximo passe desloca-se das micro-variações da ponte para uma variação ambiental orgânica nas margens, sem alterar a escala do vale.

## CP 310–311 — Margens da ponte e fetos intermédios

Os encontros rochosos dos pilares e os fetos adicionais da margem foram renderizados em `opengl3`, mas não produziram ganho perceptível na tomada histórica; ambos foram revertidos. A base actual mantém a leitura de fachada e a iluminação CP309. A próxima intervenção deverá trabalhar uma melhoria de grande escala que possa ser visualmente verificada no enquadramento, em vez de adicionar detalhe imperceptível.

## CP 318 — Ponte positiva em z=58

A escala da ponte positiva foi ampliada mantendo a posição cartográfica, e a tomada recuada foi recapturada. Não houve ganho perceptível de silhueta contra a bacia; a escala anterior foi restaurada. O próximo passe não repetirá alterações isoladas de escala da ponte: deve investigar a relação de câmara e cadeia de marcos com o módulo cinematográfico Dev3.
