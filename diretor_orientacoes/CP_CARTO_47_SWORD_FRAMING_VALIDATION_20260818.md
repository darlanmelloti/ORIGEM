# CP-CARTO-47 — Enquadramento da Espada em Primeira Pessoa

**Branch:** `feature/cine07-final`  
**Escopo:** pivot visual da espada em `entities/player/Player.gd`.  
**Fronteira:** combate, raycast, stamina, colisores, iluminação e Regiões 7–12 não foram alterados.

## Alteração aceite

Depois do passe de material CP-CARTO-46, a espada já não reflectia o céu como um emissor, mas ainda ocupava uma porção demasiado grande do canto direito do enquadramento. O pivot visual foi recuado para a periferia inferior direita e recebeu escala uniforme de `0.82`. A arma continua visível, reconhecível e pronta para combate; o centro e a linha de lajes do corredor ficam mais legíveis.

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Gameplay real | **30 segundos aprovados** em `forest_to_ruins` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto47_sword_framing_1600x900.png` |
| Silhueta da arma | **Preservada** |
| Área útil do enquadramento | **Aumentada** |
| Combate e interação | **Sem alteração de código** |
| Regiões 7–12 | **Sem alterações** |

## Continuidade

O CP-CARTO-47 é aceite. A investigação CP-CARTO-45 da bacia R6 continua aberta; os ensaios de diagnóstico que não geraram etiquetas em cena foram removidos sem deixar alterações rastreadas.
