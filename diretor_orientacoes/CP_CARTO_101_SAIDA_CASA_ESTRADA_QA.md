# CP-CARTO-101 — Saída Casa Voss→Estrada

## Resultado

A primeira tentativa de tomada nasceu no interior da Casa Voss e foi **rejeitada visualmente**. A correcção substituiu coordenadas fixas pela transformação real da soleira exterior `CasaVoss.to_global(Vector3(0, 1.25, -7.25))`. A recaptura passou 36 segundos de gameplay e confirmou uma saída livre para as lajes, a Estrada do Rio e o Arco físico.

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay na rota exterior | 36 segundos, PASS |
| Captura validada | `/home/ubuntu/qa_evidence_dev1_cp245/voss_to_road_cp101_exterior/voss_to_road_36s.png` |
| Porta, câmara e FOV de produção | Sem alteração |
| Rota exterior | Sem intersecção da geometria da casa |

## Avaliação visual

A saída técnica é válida, mas a tomada global permanece abaixo do limiar artístico do projecto: a lâmina do rio ainda domina como massa escura lateral e a cadeia de marcos longínquos não é suficientemente rica para o impacto pedido. Não houve alteração de produção no rio, nos marcos, nas árvores ou no Arco. A rota QA exterior fica preservada para comparações posteriores.
