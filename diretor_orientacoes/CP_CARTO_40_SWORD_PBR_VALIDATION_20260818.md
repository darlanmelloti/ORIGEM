# CP-CARTO-40 — Material PBR da Espada de Elias

**Branch:** `feature/cine07-final`  
**Escopo:** `entities/player/Player.gd`, apenas os materiais da lâmina, guarda e pomo da espada de quatro componentes.  
**Fronteira:** não foram alterados dano, stamina, alcance, animação, interacções, rota física, luzes nem módulos das Regiões 7–12.

## Alteração aceite

A lâmina de primeira pessoa reflectia o céu diurno como uma faixa branca/ciano, competindo com a leitura do corredor cartográfico. O passe substitui o aço excessivamente polido por aço frio envelhecido, com albedo mais escuro, metallic reduzido e roughness maior. A guarda e o pomo passam de dourado brilhante para bronze envelhecido. A geometria de quatro componentes permanece a mesma.

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Gameplay real | **30 segundos aprovados** via `ORIGEM_QA_ROUTE=forest_to_ruins` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto40_sword_1600x900.png` |
| Leitura da lâmina | **Aço metálico discreto, sem branco/ciano estourado** |
| Guarda e pomo | **Bronze envelhecido, contraste contido** |
| Combate, stamina e animação | **Sem alterações** |
| Regiões 7–12 | **Sem alterações** |

## Continuidade

O CP-CARTO-40 é aceite porque melhora materialmente a leitura de primeira pessoa sem comprometer a silhueta ou os sistemas de combate. A tarefa seguinte regressa ao espelhamento cartográfico R1–R6: auditar os marcadores azuis da margem e preservar apenas os que tiverem função física ou narrativa demonstrável.
