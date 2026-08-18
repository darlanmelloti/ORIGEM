# CP-CARTO-46 — Controlo Especular da Espada

**Branch:** `feature/cine07-final`  
**Escopo:** materiais PBR da lâmina, guarda e pomo em `entities/player/Player.gd`.  
**Fronteira:** sem alterações de geometria, danos, stamina, animação, rota física, luzes ou módulos das Regiões 7–12.

## Alteração aceite

A primeira redução de brilho ainda deixava a lâmina a reflectir o céu como uma faixa azul-clara no canto da câmara. O segundo passe usa aço envelhecido de menor metalicidade e alta aspereza, com bronze escurecido na guarda e pomo. A espada mantém leitura de arma real e a silhueta de quatro componentes, mas deixa de competir com o trilho cartográfico.

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Gameplay real | **30 segundos aprovados** via `ORIGEM_QA_ROUTE=forest_to_ruins` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto46_sword_1600x900.png` |
| Lâmina | **Aço frio mate; reflexo do céu controlado** |
| Guarda e pomo | **Bronze escurecido, sem brilho de protótipo** |
| Combate e stamina | **Sem alterações** |
| Regiões 7–12 | **Sem alterações** |

## Continuidade

O CP-CARTO-46 é aceite. O CP-CARTO-45 continua aberto para a identificação causal dos pequenos props claros da bacia R6; não foram promovidas alterações de relva ou fetos sem ganho demonstrável.
