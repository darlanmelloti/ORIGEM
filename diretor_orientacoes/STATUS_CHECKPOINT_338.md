# STATUS CHECKPOINT 338 — Eixo R6→R7 aberto

**Branch Dev1:** `feature/director-cinematic-polish`  
**Âmbito:** apenas Região 6 / Ruínas Submersas e o handoff físico para a Região 7. Nenhum módulo R7–R12 foi alterado nesta branch.

## Correcção

`ForestLakeRegion.gd` reposicionou `ArvoreFocalMargem_02`, uma conífera da margem que ocupava o cone do handoff a partir de `(30, 282)`. A árvore passou de `(61, 290)` para `(8, 306)`: continua como massa vegetal real na margem exterior, mas deixa livre a leitura da estrada, dos terraços R7 e da Vila Elevada.

## Evidência

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless no workspace de integração | Aprovado sem erro de sintaxe |
| Captura `cp338_r6_r7_handoff.png` | Aprovada: o primeiro plano está aberto; estrada e Vila permanecem legíveis |
| Gameplay OpenGL de 30 segundos | Aprovado sem `SCRIPT ERROR`, `Parse Error`, chamada inválida ou falha de processo |
| Fronteira Dev1 | Preservada: apenas `ForestLakeRegion.gd` foi modificado |

As limitações SSR/SDFGI exibidas no log são avisos esperados do renderizador `gl_compatibility` sobre llvmpipe; não constituem erros de jogo e não ocorrem como falhas de script.

## Continuidade já iniciada

O CP-CINE-07 deve ser repetido no branch de integração `feature/cine07-integration`, usando a mesma câmara da Casa Voss e o handoff agora aberto. O objectivo é validar a cadeia Casa → Estrada → Arco → R6 → terraços R7 → Vila, sem alterar a escala cartográfica.
