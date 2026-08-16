# CP 235 — Legibilidade de Marcadores Cartográficos

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** interface de mapa e apresentação dos marcos Dev1.

## Alteração

Os dois marcadores que ligam cartografia e mundo físico receberam uma passagem de contraste para leitura consistente a 1920×1080.

| Marcador | Tratamento visual |
|---|---|
| `ELIAS` | Ponto azul maior, rebordo dourado e texto com contorno escuro. |
| Destino de rota | Ponto âmbar maior e texto com contorno escuro. |

O resultado preserva a gravura do mapa, sem cobrir a legenda, os pontos numerados ou a composição territorial. A hierarquia agora diferencia claramente a posição presente de Elias do próximo destino de exploração.

## Validação

| Prova | Resultado |
|---|---|
| Captura de mapa 1920×1080 | Marcadores legíveis e não sobrepostos. |
| Arranque headless Godot 4.7.1 | Aprovado |
| Mapa aberto após Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 236 — Auditoria de continuidade de água e bacia.** O próximo ciclo regressa ao mundo físico para verificar se a leitura do rio, ponte, cascatas e Bacia Central mantém a topologia mostrada no mapa, sem alterar o território Dev2.
