# CONTINUIDADE_DEV1 — CP 329 EM EXECUÇÃO

**Fronteira obrigatória:** Regiões 1–6 e Takes 1–11. Não alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem módulos das Regiões 7–12.

## Base preservada

Os CPs 317–328 preservaram a tomada recuada de Casa Voss, a prioridade explícita da câmara de prólogo, a limpeza de contentores técnicos legados e uma materialidade PBR de terreno com melhor separação entre solo, estrada e água. As candidatas de câmara, ponte, talude, atmosfera e vegetação que não demonstraram ganho visual foram revertidas.

A sequência QA agora separa três marcos reais: Casa Voss, aproximação física da ponte positiva em `z=58` e Arco das Ruínas. O estágio `ORIGEM_QA_STORYBOARD_STAGE=ponte` é exclusivo de evidência e não altera prólogo, colisores nem a exploração normal de Elias.

## CP 329 — Em execução imediata

**Objectivo:** auditar a continuidade estrutural real entre Casa Voss, estrada, água e aproximação da ponte positiva. A finalidade é reforçar planos intermédios sem comprimir marcos cartográficos, sem painéis e sem luzes adicionais.

| Critério | Verificação obrigatória |
| --- | --- |
| Geometria | Continuidade orgânica e tridimensional; nenhuma moldura artificial. |
| Profundidade | Casa, água, ponte, Estrada e Arco mantêm planos distintos. |
| Integridade | Godot 4.7.1 headless sem erro GDScript. |
| Jogabilidade | Captura `opengl3` e execução de 30 segundos sem bloqueio. |
| Reversibilidade | Reverter qualquer candidata sem ganho visual verificável. |

**Próxima acção já iniciada:** comparar o frame de Casa com o frame de aproximação da ponte para determinar uma única intervenção física de percurso que entre no cone útil sem reduzir escala.

> Nenhum checkpoint encerra o ciclo. Cada validação abre imediatamente o próximo passe dentro do escopo Dev1.
