# CP-CARTO-112 — Auditoria Determinística do Sinal Ciano

A análise por componentes da captura localizou o sinal no UV aproximado `(0,8075; 0,5554)`, com 104 píxeis de área. A projecção de nós 3D, a consulta física pelo raio no pixel e a comparação de ocultação da árvore lateral não revelaram um candidato causal único. O raio não encontrou colisor e o único nó na janela larga (`NucleoDeArvoreEstrada_00`) foi excluído visualmente.

A interface cartográfica também foi excluída: o mapa UI só é construído como ecrã completo quando `ORIGEM_QA_OPEN_MAP` está activo; essa variável não é usada no harness lateral.

| Resultado | Estado |
|---|---|
| Coordenada de imagem do sinal | Confirmada |
| Nó 3D causal | Não atribuído |
| Colisor no raio | Nenhum |
| Alteração de produção | Nenhuma |
| Sonda temporária | Revertida |

A investigação não será repetida sem nova evidência. O próximo passe volta ao ambiente material e topográfico, que tem impacto mensurável na leitura do mapa real.
