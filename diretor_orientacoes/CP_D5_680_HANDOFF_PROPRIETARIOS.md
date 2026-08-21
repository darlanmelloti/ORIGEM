# CP-D5-680 — Handoff Gamma aos Proprietários Regionais

## Escopo

Este pacote entrega aos proprietários regionais a informação necessária para rever os candidatos Gamma sem promover alterações automaticamente no mundo principal. O pacote cobre o espelhamento real R4/R5/R6, o apoio de grounding dos adereços R5 e a continuidade cartográfica R5→R6.

| Artefacto candidato | Finalidade | Evidência |
|---|---|---|
| `GammaR4R5R6MirrorPreview.tscn` | Espelhamento R4/R5/R6 | Contrato Gamma e runtime CP-D5-677 |
| `GammaR5PropGroundingPreview.tscn` | Grounding de tenda, fogueira e equipamento | APOIO-GAMMA-01 |
| `GammaR5R6TransitionPreview.tscn` | Continuidade Majestic→Ruínas | APOIO-GAMMA-02 |
| `CP_D5_679_CHECKLIST_INTEGRACAO_SEGURA.md` | Critérios de promoção e rollback | CP-D5-679 |
| `CP_D5_676_REVISAO_FINAL_GAMMA.md` | Rastreabilidade mapa/storyboard | CP-D5-676 |

## Evidências verificáveis

O parser Godot 4.7.1 foi concluído com código `0`. Os previews foram submetidos a sessões controladas de 36 segundos, com término `124` pelo protocolo. O grounding usa raycast, preserva X/Z e respeita erro máximo de `0,05 m`. A rota principal é R4→R5→R6; o corredor auxiliar é R5→R6. A iluminação declarada permanece abaixo do limite de 16 luzes dinâmicas, com máximo Gamma de 2.

## Gate de promoção

A promoção só pode ocorrer depois de revisão visual Dev3, auditoria técnica Dev4, validação ambiental Dev6 e aprovação do proprietário regional da área afectada. A integração deve ser feita num commit separado, com rollback explícito e regressão posterior do corredor R1–R6. Até esse momento, `PRODUCTION_MODULES_CHANGED=false` permanece obrigatório.

**STATUS_CODE: HANDOFF_READY / REGION_OWNER_REVIEW / CP-D5-680.**
