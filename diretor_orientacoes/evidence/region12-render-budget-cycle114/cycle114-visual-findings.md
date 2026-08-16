# Região 12 — Orçamento de Renderização, Ciclo 114

O rim azul decorativo foi desligado efectivamente no harness. O parser/runtime Godot 4.7.1 passaram sem erros, o gameplay de aproximadamente 30 segundos e o print 1600×900 foram regenerados, e a composição principal permaneceu legível.

O resultado está `REJECTED_TECHNICAL`: a amostragem oscilou entre 18 e 21 FPS, sem recuperação consistente. A próxima acção imediata é instrumentar o custo de renderização da cena e separar o limite do harness headless do custo geométrico real, sem alterar as Regiões 1–6 nem remover a pulsação temporal.
