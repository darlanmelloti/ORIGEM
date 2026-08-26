# Dev7 — Contrato de Intake da Baseline Ambiental 023

| Campo | Contrato |
|---|---|
| **Dono da baseline** | Dev1, sob `DEV1-ENVIRONMENT-PLAYER-VIEW-BASELINE-002`. |
| **Consumidor QA** | Dev7, sob `DEV7-ENVIRONMENT-DIRECTION-ALIGNMENT-022`. |
| **Natureza** | Validação somente de leitura; não cria capturas, variantes, materiais ou produção. |
| **Condições de entrada** | Relatório de leitura, diretório de seis PNGs e telemetria de rota/câmara/luzes. |
| **Saída Dev7** | `PENDING`, `READY_FOR_DEV7_RECONCILIATION` ou `INVALID_INPUT`. |

## Entradas esperadas

O bundle publicado por Dev1 deve identificar, para cada rota reconhecida, a imagem 1600×900 da câmara real do jogador, telemetria de spawn/câmara/rota, contagem de luzes regionais e uma decisão de leitura permitida. As rotas são `road_to_arch`, `arch_to_forest`, `forest_to_majestic`, `majestic_to_lake`, `forest_to_ruins` e `ruins_arrival`.

A decisão por rota deve pertencer a `PASS_LEITURA`, `OBSERVAR_SEM_PRODUCAO` ou `HIPOTESE_CAUSAL_REQUERIDA`. A presença de `HIPOTESE_CAUSAL_REQUERIDA` não autoriza Dev7 a testar ou alterar R6: ela apenas ativa a necessidade de hipótese ligada a nó/material/posição e aprovação explícita Dev6/R6.

## Limites de consumo

A verificação Dev7 confirma somente completude, resolução, identidade de rota e vocabulário de decisão. Não julga a qualidade artística de forma automática, não reencena rotas e não substitui o dono da região. Um bundle incompleto permanece `PENDING`; um bundle estruturalmente contraditório retorna `INVALID_INPUT`; somente um bundle completo pode seguir para reconciliação documental Dev7.

> A ferramenta de intake nunca altera o mundo, as cenas, recursos, câmaras, luzes, água, física, colisores, rotas, âncoras ou quaisquer ficheiros de produção.
