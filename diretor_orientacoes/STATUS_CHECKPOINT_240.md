# CP 240 — Projecção Cartográfica Calibrada

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Sistema de mapa e Regiões 1–6; sem alteração de módulos das Regiões 7–12.

## Alteração

A interface deixou de converter coordenadas 3D por uma grelha rectangular genérica. O registo `CartographicAnchors` passou a conter as coordenadas 2D dos 12 marcos no canvas do mapa oficial e uma interpolação ponderada pelas âncoras geográficas. A posição de Elias e os destinos passam, assim, a coincidir com a posição desenhada de cada marco.

| Elemento | Antes | Agora |
|---|---|---|
| Posição de Elias | Projecção linear aproximada | Calibrada pelos marcos cartográficos |
| Destino Estrada do Rio | Posição aproximada no rodapé | Sobre o marco 2 desenhado |
| Destinos seguintes | Dependentes da mesma grelha genérica | Correspondência no mapa oficial |
| Fonte de verdade | UI | `CartographicAnchors.gd` |

## Evidência visual

A captura de Novo Jogo confirma simultaneamente o marcador **ELIAS** sobre a Casa Voss e **RUMO À ESTRADA DO RIO** sobre o marco 2, no mapa aberto a 1920×1080.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Mapa aberto | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 241 — Auditoria de exactidão dos destinos Dev1.** O próximo ciclo verificará a progressão do marcador de destino para cada marco da rota sem depender de coordenadas dispersas.
