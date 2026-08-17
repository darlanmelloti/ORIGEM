# CP-CINE-26 — Prova de Travessia da Garganta Orion

A trajectória QA percorreu o eixo físico da garganta desde `z=532` até `z=553` em 12 segundos de simulação. Os registos confirmaram cinco posições sucessivas no terreno, sem erro de script ou bloqueio de colisão. A distância final ao centro da Câmara foi de **10,16 m**, menor do que o anterior raio de revelação de 10,5 m.

A captura final revelou um facto importante: nessa posição ainda não existe uma câmara ou corredor físico que separe o jogador do altar. Mostrar o Cube neste ponto criaria um artefacto exposto na superfície, contrário ao roteiro e à exigência de mundo tridimensional real.

Por isso, a condição normal de revelação foi deliberadamente bloqueada. O Cube só pode ser mostrado através do estágio QA interior explícito enquanto o futuro corredor subterrâneo não existir. Isto preserva a abertura limpa e impede um marco Chronos flutuante no colo da montanha.

## CP-CINE-27 já iniciado

A próxima tarefa é um desenho de transição subterrânea real que use um módulo próprio de interior, carregado apenas depois do cruzamento físico da garganta. Nenhuma câmara, luz, cubo ou altar será mostrado na superfície até essa integração estar validada.
