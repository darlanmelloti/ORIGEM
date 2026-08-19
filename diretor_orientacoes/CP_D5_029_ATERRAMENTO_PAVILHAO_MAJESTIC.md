# CP-D5-029 — Aterramento do Pavilhão Majestic

**Escopo:** cena QA em `levels/dev5/`; nenhum módulo de produção foi alterado.

## Resultado

O pavilhão criado por `create_majestic_pavilion_landmark()` foi colocado no marco R5 e aterrado através de `CartographicGroundingSystem.gd`. O sistema preservou a âncora `(-88, 178)` e ajustou apenas Y até ao colisor físico `TerrenoMajesticColisorQA`. A fundação, os quatro postes e a cobertura permaneceram volumétricos, apoiados visualmente sobre o solo e sem luzes próprias.

| Parâmetro | Resultado |
|---|---|
| Âncora cartográfica | R5 — `(-88, 178)` |
| Altura inicial | 17,00 m |
| Altura de impacto | -0,00 m |
| X/Z preservado | Sim |
| Fundação apoiada | Sim |
| Luzes dinâmicas adicionadas pelo objecto | 0 |
| Alterações em produção | 0 |

A cena passou o parser Godot 4.7.1, manteve 36 segundos de execução QA e produziu captura interna. O término externo por timeout ocorreu após a janela de validação, sem erro de parser, de script ou de asserção.

## Decisão

**APROVADO como prova técnica de integração.** Este resultado não autoriza modificar `ForestLakeRegion.gd`; permite apenas que Dev1 avalie o pavilhão já aterrado quando for planeada uma integração regional.

## Próxima tarefa automática

**CP-D5-030 — Vegetação média aterrada R4/R5.** A próxima cena QA deve aplicar raycast a uma pequena composição irregular de activos vegetais já aprovados na auditoria LOD, usando os marcos 4 e 5. Não pode reconstruir o portal florestal estrutural rejeitado, criar parede de árvores ou ultrapassar os limites LOD Dev5.
