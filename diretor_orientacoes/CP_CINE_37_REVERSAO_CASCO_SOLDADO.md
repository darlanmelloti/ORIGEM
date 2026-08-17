# CP-CINE-37 — Reversão do Casco Soldado

A malha única soldada removeu as frestas de céu no viewport real, confirmando que o perímetro contínuo é tecnicamente viável. Contudo, a captura continuou a não distinguir piso, parede e profundidade de maneira suficiente para uma leitura interior aceitável. A amostra não é integrada.

A implementação QA foi removida. O ganho técnico fica documentado: a futura solução precisa de conservar malha contínua e fundo selado, mas incluir iluminação direccional legível, variação material PBR e um enquadramento que revele plano de solo e desvio de rota.

## CP-CINE-38 já iniciado

O próximo ciclo deixa de experimentar geometria às cegas. Irá comparar o interior desejado com uma referência visual de caverna/ruína de baixa luz e produzir uma matriz de materiais, direcção de luz e câmara antes de construir o bloco seguinte.
