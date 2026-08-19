# CP-CARTO-099 — Tomada de Recuo Casa Voss→Arco

## Resultado

A rota QA `road_to_arch_recede` foi criada como ferramenta reversível, conservando a câmara e o FOV de produção. O spawn recua para `z≈14` no mesmo eixo cartográfico e apontado para o Arco físico em `z=92`.

O gameplay de 36 segundos passou e a captura tornou a sequência de lajes e a silhueta do Arco simultaneamente legíveis. A superfície escura revelada no lado ocidental foi atribuída à malha física triangulada `SuperficieRioEstrada`, não a um painel, marcador ou módulo R7–R12.

## Decisão

**Sem promoção de alteração de água.** A malha do rio é construída por triângulos seguindo as margens e já foi alvo de hipóteses de material, emissão e altura rejeitadas. Não se reabre essa família sem uma causa nova. A tomada de recuo fica preservada como ferramenta QA de composição; não altera o jogo normal.

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay real | 36 segundos, PASS |
| FOV e câmara de produção | Preservados |
| Rota e colisores | Preservados |
| Captura | `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_recede/road_to_arch_recede_36s.png` |
