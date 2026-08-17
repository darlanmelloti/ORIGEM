# CONTINUIDADE_DEV1 — CP 325 EM EXECUÇÃO

**Fronteira obrigatória:** Regiões 1–6 e Takes 1–11. Não alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem módulos das Regiões 7–12.

## Base preservada

Os CPs 317–324 preservaram a tomada recuada de Casa Voss, a prioridade explícita da câmara de prólogo, a limpeza de contentores técnicos legados e uma materialidade PBR de terreno com melhor separação entre solo, estrada e água. Todas as candidatas de câmara, ponte, talude, atmosfera e vegetação sem ganho visual foram revertidas.

A tomada é ainda **parcial**, não uma aprovação final de 12 marcos: Casa Voss tem leitura à esquerda e o Arco surge no horizonte, mas a ponte transversal requer maior leitura física no plano intermédio.

## CP 325 — Em execução imediata

**Objectivo:** construir continuidade física de margens entre a bacia Casa Voss e a ponte positiva z=58, usando rochas CC0 e transições de terreno fora do corredor jogável. A finalidade é criar planos intermédios legíveis sem aproximar marcos cartográficos, sem painéis e sem luzes adicionais.

| Critério | Verificação obrigatória |
| --- | --- |
| Geometria | Margens irregulares e reais; nenhuma moldura artificial. |
| Profundidade | Casa, água, ponte, Estrada e Arco mantêm planos distintos. |
| Integridade | Godot 4.7.1 headless sem erro GDScript. |
| Jogabilidade | Captura `opengl3` e execução de 30 segundos sem bloqueio. |
| Reversibilidade | Reverter qualquer candidata sem ganho visual verificável. |

**Próxima acção já iniciada:** auditar a posição das margens e rochas da bacia para acrescentar apenas agrupamentos que entrem no cone da tomada recuada.

> Nenhum checkpoint encerra o ciclo. Cada validação abre imediatamente o próximo passe dentro do escopo Dev1.
