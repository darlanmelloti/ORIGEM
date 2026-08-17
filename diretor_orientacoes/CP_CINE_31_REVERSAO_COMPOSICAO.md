# CP-CINE-31 — Reversão da Primeira Composição Interior

A composição inicial foi rejeitada após a captura pela cena principal. Embora piso e colisores tenham funcionado, a vista revelou céu e paredes de caixa, não uma caverna física. Isto não cumpre o padrão visual do projecto e não será mantido como sala jogável.

A reversão preserva apenas o trabalho já validado no CP-CINE-30: soleira e Secção 01 físicas, inicialmente ocultas e activadas pelo gatilho exterior. Foram removidos da tentativa a luz ambiente e o estágio QA de câmara interior.

| Elemento | Decisão |
|---|---|
| Soleira/colisão CP-CINE-30 | Preservadas |
| Luz ambiente CP-CINE-31 | Revertida |
| Câmara QA da soleira | Revertida |
| Paredes primitivas como composição | Não aprovadas |
| Cube/altar no exterior | Continuam bloqueados |

## CP-CINE-32 já iniciado

O próximo ciclo deixa de tentar compor o interior no mesmo espaço do terreno aberto. Será projectado um volume subterrâneo isolado, com teto e paredes em geometria contínua, que só poderá ser apresentado se a captura não expuser céu, intersecções ou formas de greybox.
