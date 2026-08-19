# CP-CARTO-131 — Marca ciano da saída: feto rejeitado

## Investigação

A análise de componentes ciano da captura tardia apontou um componente no quadrante direito. A projecção câmara→mundo devolveu o grupo `Integration92_FetoDeMargem_03` como candidato visual mais próximo. A instância foi ocultada exclusivamente em QA após o carregamento da região.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay Casa Voss→Estrada | 36 segundos |
| Captura tardia | 1600×900 no segundo 30 |
| Produção | Não alterada |
| Marca azul | Persistiu |

> Evidência comparativa: `/home/ubuntu/qa_evidence_dev1_cp245/voss_to_road_cp131_fern_hidden/voss_to_road_cyan_fern_hidden_36s.png`

## Decisão

**REJEITADO.** O feto de margem não é a origem da marca azul. A sonda temporária foi removida sem alterar a produção. A próxima investigação deve identificar a marca por profundidade ou por máscara de renderização, sem repetir o candidato vegetal.
