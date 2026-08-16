# Briefing do Diretor — Take 8 / Região 8

## Objectivo narrativo e espacial

O Take 8 representa a entrada na Trilha da Montanha, imediatamente depois da progressão pelos Takes 6–7. A Região 8 deve comunicar ascensão, altitude e a primeira leitura clara do destino superior, sem revelar ainda a Cúpula Final. O jogador deve compreender fisicamente que o trilho continua para cima e que a montanha é o eixo de orientação.

## Câmara sugerida

A câmara de validação deve iniciar aproximadamente a 12–16 metros atrás do primeiro marco do trilho, com altura de jogador entre 1,7 e 2,2 metros. O alvo deve ficar 2–3 metros acima do ponto de navegação mais próximo, permitindo que a linha de pedras ascendente e a parede alpina ao fundo ocupem o terço superior do enquadramento. A trajectória de 30 segundos deve deslocar-se em diagonal suave, evitando uma vista frontal plana e evitando atravessar rochas ou paredes.

## Elementos visuais obrigatórios

A composição deve usar massas orgânicas CC0, rochas de escala irregular, taludes e marcadores pétreos baixos. O trilho deve ser legível por uma sequência de pedras aterradas, não por cubos, planos cinzentos ou setas artificiais. A névoa deve ser fria e baixa, suficiente para separar planos de profundidade, sem ocultar a rota. Devem existir silhuetas de montanha no fundo e uma luz de recorte alpina que mantenha o destino legível em hardware GTX 1050.

## Critérios de aceitação visual

O frame 1600×900 deve permitir localizar a rota em menos de três segundos. A silhueta do trilho deve subir claramente da zona inferior para o fundo, com pelo menos três planos de profundidade. A imagem não deve parecer uma composição de primitivas, uma arena plana ou um corredor fechado. Se a leitura visual for inferior a 85%, iterar composição, aterramento, escala e névoa antes do checkpoint.

## Critérios técnicos

A validação deve usar Godot 4.7.1, Forward+/compatibilidade conforme o harness disponível, sem erros de parser/runtime. O ciclo formal exige gameplay de aproximadamente 30 segundos, print 1600×900, avaliação escrita, ZIP reproduzível, SHA-256, commit `CP-D2-001` e sincronização para `feature/dev2-mountain-canyon`. Regiões 1–6 são proibidas neste passe.

## Referência de comparação

Comparar com a directiva de Arqueologia Alpina Cinematográfica: escala monumental, transição de floresta/rocha para altitude, organicidade dos activos e leitura narrativa por composição. O resultado deve parecer um caminho arqueológico real em montanha, não uma sequência de blocos.
