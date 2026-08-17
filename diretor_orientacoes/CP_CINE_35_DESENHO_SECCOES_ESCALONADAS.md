# CP-CINE-35 — Desenho de Secções Interiores Escalonadas

A auditoria identificou que as silhuetas de rocha aprovadas nas Regiões 1–6 são usadas em **escala moderada, contacto explícito com o terreno e afastamento do eixo navegável**. O activo `cliff_cave_rock` não será reutilizado: os CPs anteriores demonstraram incompatibilidade do seu pivô para a boca Orion.

O desenho seguinte aplica os mesmos princípios dentro de um volume totalmente fechado, mas sem colocar activos isolados como paredes de caverna.

| Plano | Leitura | Regra física |
|---|---|---|
| Primeiro | Piso mineral irregular contínuo | Mesma malha do colisor, sem degraus soltos |
| Médio | Dois contrafortes baixos e assimétricos | Fundidos lateralmente na secção, nunca suspensos |
| Fundo | Curva de saída deslocada 18° | Cria profundidade sem revelar altar ou Cube |
| Teto | Arco baixo em três segmentos contínuos | Fecha o céu sem utilizar uma esfera lisa |
| Luz | Preenchimento âmbar único, 0 sombras | Permite ler chão, paredes e curva sem Chronos |

A próxima amostra não será uma sala: terá apenas 9 m de profundidade útil e uma curva física no fundo. A aceitação exige três leituras no mesmo frame — piso, parede lateral e continuidade no fundo — além de ausência de céu e de objectos suspensos.
