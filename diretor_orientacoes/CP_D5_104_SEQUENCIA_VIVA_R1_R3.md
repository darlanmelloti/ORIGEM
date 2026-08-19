# CP-D5-104 — Sequência Viva R1→R3

## Objectivo

Integrar os candidatos vivos R1, R2 e R3 em ordem, mantendo Casa Voss, Estrada do Rio e Arco legíveis e fisicamente conectados no mapa cartográfico.

| Troço | Integração | Teste mínimo |
|---|---|---|
| R1→R2 | Anexo/horta laterais; ponte modular e fauna afastada | `road_return_voss`, 36 s |
| R2→R3 | Margem vegetal e ponte sem bloquear a estrada | `road_to_arch`, 36 s |
| R3→R4 | Ruínas laterais e flora sem arco estrutural | `arch_to_forest`, 36 s |

## Regras

Cada troço entra em commit reversível separado. A ordem é R1, depois R2, depois R3. Reverter apenas o último troço que bloquear rota, ocultar um marco ou reduzir a leitura de profundidade. Não alterar porta, `Player.gd`, módulos R7–R12 ou o alvo físico do Arco em z≈92.

> A fauna é ambiental e nunca bloqueante; árvores e ruínas ficam fora do corredor. O mapa cartográfico continua a ser a autoridade espacial.
