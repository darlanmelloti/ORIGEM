# Notas de captura R5

A primeira captura 16:9 (`majestic_wind_16x9.png`) confirmou a abertura da sessão sem erros de parser, mas foi obtida durante o ecrã de arranque do motor Godot e não mostra o Acampamento Majestic. Não constitui evidência de aprovação visual. A auditoria será repetida com tempo de aquecimento superior antes de qualquer conclusão sobre as lonas, as cordas ou o conector navegável.

## Segunda captura — sessão aquecida

A captura `majestic_wind_16x9_scene.png` confirma uma sessão 16:9 do jogo carregada sem erros de parser, mas o enquadramento mostra o ponto inicial do mundo aberto e não o Acampamento Majestic. Portanto, ela ainda não permite avaliar as lonas ou cordas da R5, nem confirma visualmente a largura do conector Majestic. A evidência de visualização local é válida apenas para confirmar que a inicialização deixou de falhar; a próxima correção deve posicionar explicitamente Elias na âncora R5 antes de repetir a captura.

## Terceira captura — aproximação Floresta–Majestic

A captura `majestic_wind_from_forest_16x9.png` enquadra corretamente o corredor físico de lajes até ao Acampamento Majestic e confirma que não há obstrução lateral evidente na aproximação. O acampamento e as lonas estão, porém, demasiado distantes para se avaliar a amplitude e a assimetria do movimento. Será usado um modo QA exclusivamente técnico, com Elias posicionado próximo da área de expedição, sem alterar o jogo normal, a rota ou os módulos regionais.

## Quarta captura — spawn técnico do acampamento

A captura `majestic_wind_camp_close_16x9.png` mostra o Acampamento Majestic em 16:9, incluindo as tendas, mastros, lonas de chegada e o suporte de expedição. A área central e a aproximação mantêm espaço visível para Elias; a câmara baixa é técnica e não representa um enquadramento final de gameplay. Uma imagem fixa não comprova a assimetria temporal do vento, pelo que a auditoria continuará com dois fotogramas do mesmo spawn em instantes distintos antes de marcar a tarefa como aprovada.

## Fotogramas temporais — inspeção visual

Os fotogramas 01 e 03 mantêm a câmara, as tendas, a iluminação e o corredor estáveis, sem deslocação da geometria do acampamento. A variação das lonas e cordas é propositadamente de baixa amplitude e não é inequívoca na pré-visualização reduzida; por isso, a confirmação final será quantitativa, comparando os três frames e verificando que há alteração de píxeis sem instabilidade global da câmara ou alteração do conector.
