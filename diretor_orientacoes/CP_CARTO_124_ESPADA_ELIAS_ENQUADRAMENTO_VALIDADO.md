# CP-CARTO-124 — Apresentação da espada de Elias validada

## Objectivo

Reduzir a obstrução do mundo cartográfico pela espada de primeira pessoa, preservando o mesmo `SwordPivot`, o mesmo `CombatRay` e a lógica de ataque de Elias.

## Ajuste promovido

A espada passou de `position=(0.54, -0.64, -1.10)` e escala `0.82` para `position=(0.84, -0.84, -1.50)` e escala `0.52`. A rotação foi afinada para manter a arma no canto inferior direito, em vez de atravessar a leitura de R6.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay de chegada R6 | 36 segundos |
| Evidência no segundo 30 | PASS, 1600×900 |
| Modelo da espada | Preservado e visível |
| Obstrução do mundo | Reduzida materialmente |
| Raycast de combate | Não modificado |

> Evidência: `/home/ubuntu/qa_evidence_dev1_cp245/ruins_arrival_cp124_sword_production/ruins_arrival_36s.png`

## Decisão

**PROMOVIDO.** A apresentação da espada deixa o vale, a encosta e a silhueta das Ruínas Submersas mais legíveis, sem remover a presença da arma de Elias.
