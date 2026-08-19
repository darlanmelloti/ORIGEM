# CP-D5-063 — Convergência de evidências cartográficas Dev5

**Destinatário:** Dev1, proprietário dos módulos de produção das Regiões 1–6.
**Âmbito Dev5:** apenas cenas e ferramentas QA em `levels/dev5/` e apresentação isolada de Elias. Nenhum item desta ficha autoriza promoção automática a `VossHouse.gd`, `RiverRoadJourney.gd`, `ForestLakeRegion.gd`, `TempleLevel.gd`, `CartographicMapUI.gd` ou `Player.gd`.

## Decisão de integração

> As evidências Dev5 comprovam **contratos técnicos** — posição X/Z, grounding, folga, câmara e rumo — mas não equivalem a aprovação visual de produção. A integração é sempre uma decisão explícita do proprietário Dev1, seguida por gameplay regional de pelo menos 30 segundos.

| Prova QA | Contrato demonstrado | Evidência | Estado para Dev1 |
|---|---|---|---|
| R1→R2 — Casa Voss / Estrada | R1 `(-22,8)` não salta R2 `(-21,4,12)`; Elias recebe rumo para a estrada | `EliasVossRoadHeadingPreview.tscn`, 36 s, 10 ciclos | Pode consultar a telemetria; não integrar a cena |
| R5→R6 — Majestic / Ruínas | Desvio oeste R5 `(-88,178)` reconverge em R6 `(60,252)` | `EliasR5R6HeadingPreview.tscn`, 36 s, chegada R6 | Pode reutilizar o contrato de rumo; não integrar a cena |
| R1–R6 — sequência | Ordem R1→R2→R3→R4→R5→R6 sem salto; R7 apenas depois de R6 | `CartographicSequenceR1R6Preview.tscn`, 8 asserções | Referência de regressão cartográfica |
| R5 — pavilhão/Elias | Pavilhão aterrado, corredor de Elias com folga `5,45 m`, vegetação lateral | `MajesticEliasVegetationReadPreview.tscn`, 36 s | Candidato técnico; revisão artística Dev1 obrigatória |
| R6 — baliza/Elias | Baliza `(52,260)`, corredor `X=60`, folga `6,05 m`, zero lajes | `R6EliasVegetationReadPreview.tscn`, 36 s | Candidato técnico; não reutilizar cais rejeitado |

## Condições intransponíveis

| Tema | Condição antes de integração |
|---|---|
| Escopo | Dev1 mantém controlo exclusivo dos módulos R1–R6; Dev5 não faz merge de geometria QA para produção |
| Cartografia | Preservar X/Z canónicos e o ramo Majestic lateral; não comprimir a distância R5→R6 |
| Navegação | Repetir rota regional real de 30 segundos após qualquer integração |
| Visual | Não aceitar captura QA simplificada como aprovação estética; requer ganho visual real e validação do proprietário |
| Desempenho | Máximo de 16 luzes dinâmicas; objectos Dev5 não introduzem Omni/Spot lights |
| Reversão | Reverter o candidato isolado, mantendo a régua cartográfica e os scripts de produção intactos |

## Caminhos de evidência

| Evidência | Captura / registo |
|---|---|
| R1→R2 | `/home/ubuntu/qa_evidence_dev5_heading_r1r2/heading_r1r2.png` e `runtime_36s.log` |
| R5→R6 | `/home/ubuntu/qa_evidence_dev5_heading_r5r6/heading_r5r6_framed.png` e `runtime_framed_36s.log` |
| R1–R6 | `/home/ubuntu/qa_evidence_dev5_sequence_r1r6/sequence_r1r6.png` e `runtime_36s.log` |
| R5 integrado | `/home/ubuntu/qa_evidence_dev5_r5_integrated_read/r5_integrated.png` |
| R6 integrado | `/home/ubuntu/qa_evidence_dev5_r6_integrated_read/r6_integrated.png` |

## Próxima tarefa automática

**CP-D5-064 — Auditoria de prontidão de integração.** Verificar se cada candidato técnico de R1, R2, R5 e R6 tem âncora, grounding, limite de luzes, evidência e condição de reversão registados antes de qualquer revisão Dev1.
