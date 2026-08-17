# CP-CINE-16 — Reversão do Kit Aterrado

O CP-CINE-16 aplicou os offsets de pivô medidos no CP-CINE-15 e eliminou a escala vertical nas paredes. Apesar disso, a captura isolada continuou a revelar geometria que parece suspensa. A causa deixou de ser apenas o pivot: os modelos `cliff_cave_rock.glb` e `stone_largeB.glb` possuem uma silhueta, orientação e largura que não formam uma parede de corredor quando são dispostos no talude do Vale.

O kit não foi integrado. Os scripts e harnesses temporários foram removidos e a base Orion voltou a validar em Godot headless.

| Critério | Resultado |
|---|---|
| Offsets de pivô medidos aplicados | Sim |
| Activos visualmente aterrados no corredor | Não |
| Integração na rota Orion | Não realizada |
| Reversão técnica | Aprovada |

## CP-CINE-17 já iniciado

A próxima frente não reutilizará este kit para a Caverna Orion. Deve separar o problema em dois activos: um piso de corredor gerado por malha procedural com colisão idêntica e uma parede de rocha de perfil lateral construída com a mesma malha. A geometria deve ser gerada a partir da altura do terreno e da sua secção transversal, em vez de depender dos pivôs dos GLBs existentes. Só depois de uma amostra visual curta, sem elementos suspensos, poderá ser aplicada no interior Orion.
