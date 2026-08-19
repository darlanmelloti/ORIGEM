# CP-CARTO-111 — Material Exclusivo do Arco Rejeitado

Foi testada uma instância PBR exclusiva para o Arco das Ruínas, com aumento de valor, micro-relevo e redução de rugosidade. A geometria, as luzes, os colisores e a rota permaneceram inalterados.

A captura de 36 segundos Casa Voss→Arco não demonstrou separação visual suficiente do marco para justificar a alteração. A instância foi revertida integralmente; o material de produção `ruin_material` permanece aplicado aos pilares, núcleos, lintel e bases do Arco.

| Verificação | Resultado |
|---|---|
| Parser Godot | PASS |
| Gameplay Casa Voss→Arco | 36 s, PASS |
| Alteração visual local | Insuficiente; REJECTED_VISUAL |
| Estrutura, rota e colisores | Preservados |
| Luzes dinâmicas novas | 0 |

**Evidência:** `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_cp111_material/road_to_arch_36s.png`
