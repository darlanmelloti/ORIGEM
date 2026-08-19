# CP-CARTO-108 — Estrada de Lama Auxiliar Removida

## Causa confirmada

A tomada lateral QA isolou as duas camadas visuais criadas pela Casa Voss. Ao ocultar apenas `EstradaDeLamaConformada`, a faixa escura irregular desapareceu, preservando as lajes físicas e a faixa macro posterior. A geometria não era água, sombra, afluente, Vale Diurno nem duplicação de `SuperficieRioEstrada`.

A camada auxiliar foi removida da construção de produção. `EstradaDeLamaConformada` não possuía colisores; a progressão jogável continua nas lajes da Estrada do Rio, na soleira e nos respectivos corpos físicos.

| Verificação | Resultado |
|---|---|
| Tomada lateral Casa Voss | 36 s, PASS |
| Casa Voss→Arco | 36 s, PASS |
| Faixa escura na origem | Removida |
| Lajes, rota e Arco | Preservados |
| Luzes dinâmicas novas | 0 |
| Regiões 7–12 | Não alteradas |

## Evidências

- Lateral: `/home/ubuntu/qa_evidence_dev1_cp245/voss_lateral_cp108_production/voss_lateral_36s.png`
- Rota principal: `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_cp108_production/road_to_arch_36s.png`

A correcção satisfaz o objectivo local de eliminar a superfície escura auxiliar. O refinamento global do vale continua aberto; esta promoção não declara a meta artística final concluída.
