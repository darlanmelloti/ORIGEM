# CP-CINE-51B — Conflito de Câmara no Corredor Orion

As três vistas CP-CINE-51 não representaram a exploração real de Elias. Embora o corpo do jogador fosse reposicionado, a câmara estática `CameraInteriorOrion` continuou marcada como actual, sobrepondo-se à `Camera3D` criada no nó `Player`. Por isso, as imagens fixaram o mesmo enquadramento de parede e não mediram a leitura da rota.

A correcção será limitada à prioridade de câmara: a câmara estática continuará a existir como apoio técnico, mas ficará inactiva no fluxo jogável. A câmara de Elias assumirá explicitamente a visualização após o jogador ser criado e restaurado. Nenhuma malha, material, luz, Cube ou conteúdo narrativo será alterado.
