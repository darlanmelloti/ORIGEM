# CP-CINE-43 — Reversão de Rochas Laterais

## Resultado

A medição dos pivôs confirmou que `stone_largeB.glb` e `stone_tallC.glb` possuem limite inferior a `-0,05 m`, permitindo uma ancoragem matemática no piso do corredor. Contudo, a captura `cp_cine43_orion_grounded_rocks.png` demonstrou que, neste contexto interior, a silhueta de `stone_tallC.glb` permanece demasiado angular e legível como suporte artificial na margem direita.

A instanciação lateral foi revertida. O corredor contínuo independente, os seus dois emissores de baixo custo e a malha/colisor unificados foram preservados.

## Regra acrescentada

O alinhamento do pivô é condição necessária, mas não suficiente. Antes de integrar qualquer activo externo numa passagem interior, a silhueta deve ser validada na câmara de percurso; activos que leiam como pilares, suportes ou painéis não podem ser usados para simular paredes de caverna.

## Próximo ciclo já iniciado

**CP-CINE-44 — Contraste de percurso:** validar uma solução de leitura baseada exclusivamente na malha contínua, em pequenas diferenças de rugosidade e numa iluminação direccional de profundidade, sem elementos soltos laterais.
