# Região 12 — Ressonância Recessiva no Builder, Ciclo 128

A luz de ressonância recessiva validada no harness foi integrada em `OrionDestinationRegion.gd`, com sombra desactivada, alcance 2.8 m e pulsação temporal de amplitude 0.055. O primeiro check revelou uma indentação excessiva na chamada `dome.add_child(heart_light)`; a linha foi corrigida imediatamente e o check directo do script passou.

A validação completa Godot 4.7.1 passou sem `SCRIPT ERROR`, `Parse Error` ou `Invalid assignment`. Gameplay de aproximadamente 30 segundos e print 1600×900 foram regenerados. O harness permaneceu em 83–85 draw calls e 21–22 FPS. A alteração está limitada ao builder e à evidência da Região 12; Regiões 1–6 não foram modificadas. Estado: `PASSED`. Próxima acção imediata: commitar e avançar para o próximo passe de estabilidade/legibilidade da Região 12.
