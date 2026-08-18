# CP-CARTO-62 — Rejeição do Ensaio PBR do Sobreiro da Casa Voss

## Hipótese

O sobreiro PBR `SobreiroDeTomas`, enquadrado na saída da Casa Voss, apresentava tronco demasiado claro na captura da Estrada. Foi preparado um ajuste por superfície para preservar texturas e elevar a rugosidade sem alterar a rota ou o combate.

## Resultado técnico

O parser Godot 4.7.1 passou e a sessão foi mantida por 36 segundos. No entanto, a captura do modo `voss_road` ficou geometricamente inválida — a câmara atravessou a grande lâmina de água/terreno e não apresentou uma vista utilizável da árvore. A evidência não permite avaliar o ensaio com integridade.

## Decisão

O código do ajuste foi removido integralmente e o sobreiro regressou ao último estado publicado. Não promover o ensaio sem uma tomada Casa Voss válida. CP-CARTO-56 continua aguardando a publicação Dev2 para R6→R7.
