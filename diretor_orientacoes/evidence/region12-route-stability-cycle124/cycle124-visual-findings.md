# Região 12 — Estabilidade de Colisões, Ciclo 124

As camadas e máscaras de colisão foram fixadas explicitamente em 1 para o marcador, a soleira e os jambas laterais. O parser/runtime Godot 4.7.1 passaram sem erros; o gameplay de aproximadamente 30 segundos e o print 1600×900 foram regenerados. A composição e o vão central permanecem íntegros.

O resultado está `PASSED` para a estabilidade da rota. A instrumentação mantém 83–85 draw calls e 20–22 FPS no harness headless; o alvo GTX 1050 continua pendente. A próxima acção imediata é commitar a estabilidade e iniciar o próximo passe visual da Região 12 sem interromper a produção.
