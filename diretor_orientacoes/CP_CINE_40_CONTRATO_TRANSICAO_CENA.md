# CP-CINE-40 — Contrato de Transição Exterior–Interior Orion

A auditoria CP-CINE-40 confirmou que `TerrainPatch` é uma superfície de terreno de face única, com `cull_back`; não pode funcionar como envolvente subterrânea. O interior Orion passa portanto a ser uma cena independente, carregada apenas quando Elias atravessa o volume físico CP-CINE-28.

| Etapa | Regra de execução | Regra visual |
|---|---|---|
| 1. Garganta exterior | Elias atravessa fisicamente o `Area3D` de handoff | Não há Cube, altar ou brilho Chronos |
| 2. Transição curta | Fade opaco de 0,35 s; guardar ponto de retorno exterior | Não existe corte exposto ou teletransporte visível |
| 3. Cena interior | Carregar `res://scenes/orion_interior.tscn` na posição de entrada | A cena inclui apenas soleira e corredor neutro |
| 4. Retorno | Acção de saída restaura a cena principal e o ponto guardado | A abertura Casa Voss não é recriada nem modificada |

A primeira cena interior terá sua própria câmara, ambiente, piso e colisão. O Cubo só pode ser instanciado num checkpoint posterior, depois de a cena de soleira cumprir os critérios de leitura e gameplay.
