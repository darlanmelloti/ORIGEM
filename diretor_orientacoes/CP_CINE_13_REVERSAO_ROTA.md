# CP-CINE-13 — Reversão da Rota Interior Provisória

A auditoria confirmou que a ligação entre a boca da Caverna Orion, em `z=548`, e a Câmara do Cube, em `z=562`, não possui ainda um corredor interior com colisores próprios. Foi testada uma primeira rota de três lajes com contrafortes laterais. As capturas da soleira e da secção intermédia mostraram lajes elevadas e massas de rocha suspensas, por isso a solução não atingiu o limiar visual exigido.

A rota foi revertida integralmente antes de qualquer publicação. A base regressou à entrada volumétrica CP-CINE-11 e passou novamente a validação Godot headless. Não ficou no ramo qualquer laje, colisor ou contraforte provisório.

| Critério | Resultado |
|---|---|
| Entrada Orion do CP-CINE-11 | Preservada |
| Rota com chão e colisores próprios | Ainda pendente |
| Geometria suspensa no corredor | Revertida |
| Validação headless após reversão | Aprovada |

## CP-CINE-14 já iniciado

A solução seguinte deve começar por um kit de secções de corredor com malha e colisão unificados, testado isoladamente antes da integração no mapa. Não serão reutilizadas lajes em caixa, esferas de ocultação ou rochas escaladas sem aterramento. Só depois de a secção de corredor passar o teste visual e físico de 30 segundos será integrada entre a Caverna Orion e a Câmara do Cube.
