# ORIGEM — Bilhete de Retoma 005: QA do Afluente R4/R6

**Estado:** `QA_CANDIDATE_AUTHORIZED`

**Integração de referência:** `876092a90f30`

**Proprietários:** Dev4 é responsável pela leitura R4; Dev6 é responsável pelos invariantes R6.

## Objetivo material

Validar tecnicamente, fora da produção, se uma opacidade transitória de `0.82` aplicada apenas à lâmina do afluente R4 reduz a leitura excessivamente opaca sem tocar no lago R6. Este bilhete não autoriza alteração persistente do recurso lacustre.

## Alvo, recurso e candidata

| Campo | Definição autorizada |
|---|---|
| Nó de QA | `AfluenteCartograficoRioParaBacia/LaminaDoAfluenteCartografico`. |
| Consumidor R6 protegido | `RuinasSubmersasDoLago/LagoDasRuinasSubmersas`. |
| Recurso de produção | `_create_lake_material()` em `levels/ForestLakeRegion.gd`; somente leitura. |
| Candidata de QA | Copiar o `ShaderMaterial` em memória e trocar somente `ALPHA = 1.0;` por `ALPHA = 0.82;` na cópia do alvo R4. |
| Reversão | Descartar o override com a instância da prova; não gravar em `levels/`. |

## Limites invioláveis

Não editar `levels/ForestLakeRegion.gd`, `levels/regions/R6_SubmergedRuins.gd`, cenas, âncoras, rotas, UI, timeline, física ou câmara. Não criar nem mover geometria, luzes, colisores ou partículas. Não alterar cota, largura, transparência persistente, `cull_back`, emissão, rota ou orçamento.

R4 mantém a clareira Orion entre `Z≈126–151`, corredor de pelo menos 8 m e as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins`. R6 mantém `LagoDasRuinasSubmersas`, quatro luzes canónicas (`PreenchimentoMundialDoLago`, `PreenchimentoOpostoDoLago`, `PreenchimentoAzulDaMargem`, `LuzSubaquaticaCentral`) e as rotas `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`.

## Validação obrigatória

1. Executar `qa/regions/verify_r4_r6_inlet_alpha_candidate.gd` em Godot 4.7.1.
2. Confirmar o marcador `ORIGEM_R4_R6_ALPHA_CANDIDATE_OK`, `r6_alpha=1.0`, quatro luzes R6 e `production_mutations=0`.
3. Executar `tools/qa/run_regional_gate.sh R4 origin/integration/r1-r6-sprint1`.
4. Executar `git diff --check`, remover exclusivamente `.uid` não rastreados e registar o resultado.

## Aprovação e próximo passo

A prova técnica aprovada não é promoção de produção. A promoção visual só pode ser proposta com captura 16:9 de enquadramento aprovado e aceitação conjunta Dev4, Dev6 e Dev1/Diretor. Em caso de falha, descartar o override transitório e manter o material canónico.
