# CP-CARTO-109 — Sinal Ciano Residual Não Atribuído

## Objectivo

Atribuir de forma causal o pequeno sinal ciano ainda visível na tomada lateral da Casa Voss, depois de removida a faixa escura da estrada auxiliar.

## Evidência recolhida

A projecção de câmara e a consulta do raio no quadrante observado não encontraram colisor nem emissor coincidente. A única instância centrada na janela inicial foi `NucleoDeArvoreEstrada_00` em `(-26.16133, 0.359373, 30.0)`. A ocultação exclusivamente QA dessa árvore não removeu o sinal residual.

| Hipótese | Resultado |
|---|---|
| Árvore lateral `NucleoDeArvoreEstrada_00` | Rejeitada visualmente |
| Luzes no quadrante observado | Sem coincidência causal |
| Geometria com colisor no raio exacto | Nenhuma |
| Alteração de produção | Nenhuma |

## Decisão

A sonda temporária será revertida integralmente. Não se altera vegetação, luzes, água ou marcos com base num sinal que ainda não possui atribuição única. A tomada CP-CARTO-108 limpa da faixa escura mantém-se como a evidência de produção válida.

## Evidências

- Projecção: `/home/ubuntu/qa_evidence_dev1_cp245/voss_lateral_cp109_raycast_corrected/`
- Comparação da árvore: `/home/ubuntu/qa_evidence_dev1_cp245/voss_lateral_cp109_no_tree00/voss_lateral_no_tree_00_36s.png`
