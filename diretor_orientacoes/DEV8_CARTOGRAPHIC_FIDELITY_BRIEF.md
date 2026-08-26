# ORIGEM — Briefing Dev8: Fidelidade Cartográfica e Legibilidade Espacial

> **Issue canónica:** #393
> **Branch:** `dev8/cartographic-fidelity`
> **Papel:** auditoria gráfica-cartográfica. Dev8 mede e documenta; não altera o mundo de produção sem uma hipótese causal, a autorização do dono regional e a cadeia completa de gates.

## Missão

O mapa oficial já possui âncoras espaciais canónicas e posições artísticas no canvas 800×600. A contribuição Dev8 é garantir que a relação entre estas três coisas permanece legível e coerente:

| Camada | Autoridade | O que Dev8 verifica |
|---|---|---|
| Mundo físico | Rotas, Player, colisores e regiões R1–R6 | A posição real do jogador e a orientação no percurso. |
| Cartografia | `levels/CartographicAnchors.gd` | Coerência entre âncora, destino seguinte e posição do marcador no mapa. |
| Leitura gráfica | `ui/menus/CartographicMapUI.gd` e capturas reais | Marcadores legíveis, orientação sem ambiguidade e ausência de salto visual indevido. |

## Limites absolutos

Dev8 **não pode** alterar `CartographicAnchors.gd`, `CartographicMapUI.gd`, `scripts/main.gd`, `Player`, câmaras, rotas, luzes, água, colisores, geometria regional, `ForestLakeRegion.gd`, `TempleLevel.gd` ou módulos R1–R6. Também não cria placas, setas no mundo, painéis, fundos falsos, névoa plana, partículas ou atalhos de mapa.

Qualquer sugestão de produção deve terminar num relatório de handoff para o proprietário do módulo. Não deve ser implementada pelo Dev8.

## Primeira tarefa ativa

| Campo | Valor |
|---|---|
| `task_id` | `DEV8-CARTOGRAPHIC-FIDELITY-BASELINE-001` |
| Tipo | QA observacional e de leitura, sem mutação de produção. |
| Resultado | Matriz das âncoras 1–6, captura de mapa pelo jogo e telemetria de rota para cada transição reconhecida. |
| Decisões admitidas | `COERENTE`, `OBSERVAR`, `HIPOTESE_CAUSAL_PARA_DONO_REGIONAL`. |

A baseline deve conferir Casa Voss, Estrada do Rio, Arco, Floresta Densa, Majestic e Ruínas Submersas. Ela deverá usar somente rotas reconhecidas: `road_to_arch`, `arch_to_forest`, `forest_to_majestic`, `majestic_to_lake`, `forest_to_ruins` e `ruins_arrival`.

## Critérios obrigatórios

1. Parser Godot 4.7.1 limpo e `git diff --check` antes de cada publicação.
2. Capturas reais por Xvfb, 1600×900, abertas pela cena de jogo; sem renderer dummy para PNG final.
3. Para cada captura: rota reconhecida, posição `X/Z`, destino, identificador da âncora, posição do marcador no canvas e yaw de Elias.
4. Não admitir uma evidência produzida por teleporte manual fora de uma rota reconhecida.
5. Executar a porta regional correspondente; se a entrega for exclusivamente QA transversal, executar a CI cumulativa antes de solicitar integração.
6. Manter exactamente uma tarefa `ACTIVE` no contrato Dev8 após cada entrega.

## Continuidade e Git

Antes de criar ou publicar: `git fetch origin --prune`, verificar ahead/behind com `origin/integration/r1-r6-sprint1`, preservar commits exclusivos e reconciliar com merge explícita. É proibido `push --force`, reset destrutivo ou ultrapassar a política de branch. As execuções CI devem enfileirar; nunca cancelar um run em curso.

> A melhoria de um "mapa real" só é válida quando a cartografia confirma o mundo físico, e não quando o mapa força o jogador a acreditar numa rota que não existe.
