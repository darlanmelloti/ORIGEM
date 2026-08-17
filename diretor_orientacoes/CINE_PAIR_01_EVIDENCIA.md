# CINE-PAIR-01 — Evidência Física e Visual do Corredor Orion

**Estado:** diagnóstico partilhado Dev3 + Dev4 concluído; escolha da alteração única seguinte em execução.

## Validação executada

A sonda temporária foi executada em duas sessões independentes de 30 segundos, com a câmara de Elias, FOV 64 e o percurso físico existente. Não foram observados erros de parse ou runtime. O orçamento observado é de **3 luzes dinâmicas**, abaixo do limite de 16.

| Ponto | Posição efectiva da câmara | Vector frontal | Intersecção frontal | Intersecções laterais | Luzes |
| --- | --- | --- | --- | --- | --- |
| Soleira | `(0.013, 1.511, 0.386)` | `(-0.201, 0.106, 0.974)` | Nenhuma até 20 m | Nenhuma até 8 m | 3 |
| Profundidade | `(-1.988, 1.510, 10.027)` | `(-0.157, 0.120, 0.980)` | Nenhuma até 20 m | Nenhuma até 8 m | 3 |

## Leitura das capturas

A telemetria confirma que o eixo escolhido não encontra parede física próxima: a sensação de bloqueio é **puramente composicional e luminosa**, não uma falha de colisão ou de direcção da câmara. A soleira mostra textura de rocha muito próxima e um vazio central sem piso legível; na profundidade, a mesma massa lateral domina e a orientação de avanço deixa de ser reconhecível.

> A próxima alteração não deve repetir alargamento de perfil, FOV, deslocamento lateral de câmara, marcadores isolados, neblina, emissão do piso ou luz de profundidade isolada, todos já rejeitados no diagnóstico CP-CINE-56.

## Decisão em curso

Dev3 seleccionará uma intervenção de **orientação de superfície contínua**, e Dev4 verificará que ela preserve os três limites: rota sem colisão nova, três ou menos luzes locais e execução estável por 30 segundos. A sonda será removida antes do commit permanente.


## Decisão CINE-PAIR-02 — Reversão

A subdivisão do sobrepiso e a variação de cor por vértice foram tecnicamente válidas e não acrescentaram luzes, colisores ou objectos separados. Contudo, nas capturas de soleira e profundidade o ganho não foi perceptível: o vazio central continuou a dominar e a faixa não se distinguiu como superfície natural de orientação. A alteração será revertida e a sonda Dev4 será removida antes do próximo commit.

> **Novo candidato rejeitado:** orientação material do piso por cor de vértice como solução isolada da legibilidade Orion.
