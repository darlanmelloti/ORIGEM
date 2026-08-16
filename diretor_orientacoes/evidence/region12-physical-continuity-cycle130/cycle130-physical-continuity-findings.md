# Região 12 — Continuidade Física da Soleira, Ciclo 130

Foi integrado no builder principal o collider invisível da soleira orgânica (`ColisaoSoleiraGatewayCupula`), alinhado com a borda base da entrada e com camada/máscara de colisão 1. A geometria continua a ser exclusivamente CC0/orgânica; o collider não adiciona geometria visível.

O check directo do script, o parser completo e o runtime Godot 4.7.1 passaram sem erros. Gameplay de aproximadamente 30 segundos e print 1600×900 foram regenerados. O harness manteve 83–85 draw calls e 20–22 FPS. Estado: `PASSED`. Regiões 1–6 não foram modificadas. Próxima acção imediata: commitar e avançar para o próximo refinamento dentro das Regiões 7–12.
