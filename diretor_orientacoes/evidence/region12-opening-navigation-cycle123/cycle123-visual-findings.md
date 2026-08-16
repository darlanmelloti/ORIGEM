# Região 12 — Navegação da Abertura, Ciclo 123

As colisões invisíveis dos dois jambas verticais foram implementadas efectivamente e validadas no harness. O parser/runtime Godot 4.7.1 passaram sem erros; gameplay de aproximadamente 30 segundos e print 1600×900 foram regenerados. O vão central permanece aberto, a soleira continua atravessável e a silhueta orgânica não sofreu alterações visuais.

O resultado está `PASSED` para a navegação da abertura. A instrumentação mantém 83–85 draw calls e 20–22 FPS no harness headless, por isso o orçamento GTX 1050 continua pendente. A próxima acção imediata é commitar esta verificação e iniciar o próximo passe de estabilidade do percurso.
