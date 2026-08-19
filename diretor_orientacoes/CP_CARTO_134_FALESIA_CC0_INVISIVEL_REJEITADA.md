# CP-CARTO-134 — Falésia CC0 de fundo: rejeitada

## Hipótese

Foi inventariado e testado o activo CC0 `cliff_cave_rock.glb` como silhueta de falésia real atrás da Casa Voss. A instância foi acrescentada apenas ao modo QA, sem colisores, sem luzes e sem tocar em rotas ou Regiões 7–12.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay Estrada→Casa Voss | 36 segundos |
| Captura tardia | 1600×900 no segundo 30 |
| Geometria | GLB CC0 real, não painel |
| Ganho visual | Insuficiente; silhueta não entrou no enquadramento |

> Evidência: `/home/ubuntu/qa_evidence_dev1_cp245/road_return_voss_cp134_cliff/road_return_voss_cliff_qa_36s.png`

## Decisão

**REJEITADO.** A falésia CC0 não acrescentou leitura à tomada validada. O preload e a instância QA foram revertidos. Próximo passo: auditar a orientação efectiva da câmara e a franja de visibilidade do fundo antes de testar outro activo, sem repetir tentativas por coordenadas inferidas.
