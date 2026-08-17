# CP-CINE-52B — Falha de Suporte Físico

A sonda de arranque normal da cena `orion_interior.tscn` mediu Elias em `y = -19,90` após dois segundos, com a câmara de Elias confirmada como activa. O ecrã preto das capturas CP-CINE-52 não foi causado pela luz ou pela orientação: Elias atravessava o piso visual porque o casco gerado não oferecia uma superfície de colisão utilizável pelo `CharacterBody3D`.

A correcção será exclusivamente física. Será adicionada uma base invisível, contínua e ligeiramente abaixo do piso artístico do corredor. A base não cria qualquer geometria visível, não acrescenta luzes e não altera materiais ou a silhueta interior. A malha artística permanecerá a autoridade visual; a base apenas garante suporte confiável para o jogador até a futura colisão detalhada derivada do casco estar consolidada.
