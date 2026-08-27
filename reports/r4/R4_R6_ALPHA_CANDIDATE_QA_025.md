# ORIGEM — Resultado QA da Candidata Alfa R4/R6 025

**Candidata:** `ALPHA = 1.0 → ALPHA = 0.82`

**Escopo:** prova isolada no afluente R4, com material clonado somente em memória.

**Produção:** `production_mutations=0`

## Resultado técnico

A prova `qa/regions/verify_r4_r6_inlet_alpha_candidate.gd` passou sob Godot 4.7.1 com o marcador:

```text
[ORIGEM_R4_R6_ALPHA_CANDIDATE_OK] target=R4 alpha=0.82 r6_alpha=1.0 r6_lights=4 production_mutations=0
```

| Invariante | Resultado |
|---|---|
| Alvo de override | Apenas `LaminaDoAfluenteCartografico` (R4). |
| Material R6 | `LagoDasRuinasSubmersas` conservou a receita e alfa canónicos. |
| Luzes R6 | Quatro luzes canónicas encontradas. |
| Novas luzes/colisores R4 | Nenhum criado pela prova. |
| Arquivos de produção | Nenhuma alteração em `ForestLakeRegion.gd` ou `R6_SubmergedRuins.gd`. |
| Porta regional R4 | `PASS`: parser, provas cumulativas e rotas `arch_to_forest`, `forest_to_majestic`, `forest_to_ruins`. |
| CI/PR | Nenhuma iniciada. |

## Limite da evidência

O teste foi técnico e executado no renderer headless; mensagens do backend dummy sobre parâmetros de material nulos foram emitidas após a prova, mas o processo concluiu com código zero e sem alterar recurso de produção. Esta evidência não aprova promoção visual. Qualquer promoção requer captura 16:9 com enquadramento aprovado e nova decisão conjunta Dev4/Dev6/Dev1.

**Decisão atual:** `QA_TECHNICAL_ISOLATION_PASS`; candidata ainda não promovida para produção.
