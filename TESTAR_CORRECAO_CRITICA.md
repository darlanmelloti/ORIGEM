# ORIGEM — Teste da Correção Crítica

## Objetivo

Esta versão corrige elementos visuais suspensos e recalibra a stamina de Elias para que exploração e combate mantenham um ritmo fluido.

## Grounding pass

1. Inicie um novo jogo e caminhe pela praça, caminho do lago e ruínas exteriores.
2. Observe rochas, contrafortes, colunas partidas, árvores, arbustos e flores.
3. Todos os elementos devem tocar o relevo; não devem existir rochas a flutuar nem raízes visivelmente enterradas.
4. A altura dos objetos agora é obtida por `TerrainPatch.height_at()`. O kit de ruínas também possui uma reserva por raycast vertical caso o terreno ainda não esteja disponível.

## Stamina

| Ação | Valor esperado |
| --- | --- |
| Ataque de espada | Consome 16 pontos, permitindo seis ataques a partir da stamina máxima. |
| Corrida | Consome 12 pontos por segundo. |
| Bloqueio | Consome 8 pontos por segundo. |
| Regeneração | Recupera 35 pontos por segundo após 0,30 segundos sem gastar stamina. |

## Validação de ritmo

1. Corra durante três segundos, pare e confirme que a barra recupera rapidamente.
2. Execute uma sequência de seis ataques; a stamina deve chegar perto de zero apenas no sexto golpe.
3. Entre na Câmara do Cubo e teste o Sentinela Kharu; bloqueio e ataque devem continuar táticos, sem esgotamento imediato.
