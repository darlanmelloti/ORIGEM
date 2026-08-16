# Região 12 — Continuidade Física, Ciclo 121

A colisão invisível foi adicionada efectivamente ao marcador único de rota, preservando a navegação física sem geometria visual greybox. O parser/runtime Godot 4.7.1 passaram sem erros; o gameplay de aproximadamente 30 segundos e o print 1600×900 foram regenerados. A instrumentação manteve 83–85 draw calls e 19–22 FPS.

O resultado está `PASSED` para a continuidade física e a integridade visual. O FPS permanece `FPS_TARGET_PENDING` no harness headless. A próxima acção imediata é commitar este incremento e iniciar o próximo passe de verificação do percurso entre base, soleira e abertura.
