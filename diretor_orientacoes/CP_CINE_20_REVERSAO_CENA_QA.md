# CP-CINE-20 — Reversão da Cena QA Própria

A cena `.tscn` independente foi construída com `Camera3D`, ambiente, luz e uma malha procedural com colisor correspondente. O Godot confirmou que a câmara da cena estava activa, mas a captura X11 continuou a receber uma viewport preta. Como o ambiente demonstra imagens válidas apenas quando inicia `scenes/main.tscn`, esta não é uma base confiável de comparação visual.

A cena e o controlador QA foram removidos. Não existem alterações persistentes no mundo Orion.

| Critério | Resultado |
|---|---|
| Cena Godot e câmara inicializadas | Sim |
| Viewport capturada com conteúdo | Não |
| Evidência visual para aprovar corredor | Não |
| Alteração no jogo principal | Nenhuma |

## CP-CINE-21 já iniciado

A próxima validação de interior deve usar exclusivamente `scenes/main.tscn`, com um estágio QA que muda apenas a posição da câmara no mundo já renderizável. O protótipo de corredor só poderá ser avaliado quando esta matriz de captura principal estiver confirmada; até lá, a entrada Orion CP-CINE-11 permanece a base publicada.
