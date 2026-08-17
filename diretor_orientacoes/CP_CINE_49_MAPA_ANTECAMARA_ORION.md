# CP-CINE-49 — Mapa da Ante-câmara Orion

## Ponto de partida

O corredor independente termina na última secção curva, aproximadamente no eixo local `z=7,4`, deslocado para oeste pela curvatura progressiva. Este ponto não deve receber o Cube nem o altar. A ante-câmara começa depois de uma curva curta, removendo a leitura directa do artefacto a partir da entrada.

| Zona | Alcance local aproximado | Função | Estado narrativo |
|---|---:|---|---|
| Soleira | z 0,4–1,0 | Entrada e retorno para a garganta | Sem sinal Chronos |
| Corredor | z 1,0–7,4 | Travessia inicial de Elias | Luz neutra de percurso |
| Ante-câmara | z 7,4–12,0 | Pausa espacial antes do santuário | Sem Cube nem altar |
| Santuário futuro | após z 12,0 | Revelação do Cube de Orion | Bloqueado até ciclo posterior |

## Regras de implementação

A ante-câmara deve prolongar a mesma malha contínua e o mesmo colisor físico do corredor, alargar apenas a parede exterior da curva e manter o piso navegável. A composição não pode usar caixas, painéis, uma segunda esfera de abóbada, céu visível, ou rochas importadas com pivô não aferido. O cenário mantém duas luzes locais sem sombras; qualquer alteração deve substituir, não acumular, luzes.

## Critérios CP-CINE-49

A primeira amostra será preservada apenas se a captura demonstrar uma parede de fundo legível, uma mudança espacial depois da curva e uma rota central livre. Antes da publicação será obrigatório executar a validação Godot e um runtime de 30 segundos na cena independente.
