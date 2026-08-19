# CP-D5-007 — Fichas de integração dos candidatos Dev5

**Estado:** proposta técnica; nenhuma integração autorizada nesta branch.  
**Autoridade espacial:** `CartographicAnchors.gd`.  
**Proprietário de produção:** Dev1 / branch cinematográfica das Regiões 1–6.

> O Dev5 constrói e valida candidatos em cenas isoladas. A decisão de posicionar qualquer candidato no mundo jogável pertence exclusivamente ao proprietário R1–R6, após verificação do mapa, colisores, menu e gameplay.

## Resumo de decisão

| Candidato Dev5 | Marco do mapa | Estado QA | Recomendação | Bloqueio de integração |
|---|---:|---|---|---|
| Ponte de Pedra Arqueada | 2 — Estrada do Rio | Aprovada, 36 s e captura interna | Rever como substituição ou complemento de leitura da ponte existente | Não alterar `RiverRoadJourney.gd` sem comparação A/B no eixo z≈58 |
| Anexo Casa Voss | 1 — Casa Voss | Aprovado, 36 s e captura interna | Rever como edificação periférica, nunca substituição da casa jogável | Não alterar `VossHouse.gd` sem garantir porta E, prólogo e saída exterior |

## Ficha A — Ponte de Pedra Arqueada

| Campo | Especificação |
|---|---|
| Âncora cartográfica | Marco 2: `ESTRADA_RIO_INICIO=(-21,4; 12)`; leitura positiva da ponte no corredor R1–R3 em z≈58 |
| Referência actual | `RiverRoadJourney.gd`, raiz `PonteDeLeituraDoValePositivo` |
| Proposta de uso | Objecto de primeiro plano ou variante de leitura; não duplicar a ponte actual no mesmo eixo |
| Geometria visual | 7 lajes arqueadas, 2 encontros, 18 aduelas, 4 apoios e 10 parapeitos descontínuos |
| Triângulos teóricos | **516** em primitivas visuais; colisores não adicionam triângulos renderizados |
| Materiais | Pedra, pedra envelhecida e musgo (3) |
| Luzes dinâmicas | 0 |
| Colisão | `StaticBody3D` por laje do tabuleiro |
| Evidência | `StoneBridgeLandmarkPreview.tscn`, 36 segundos; `CP_D5_002_PONTE_MARCO2_QA.md` |
| Teste de aceitação Dev1 | Comparar A/B a partir do spawn `positive_bridge`; preservar a passagem jogável e só promover se a leitura arqueada melhorar ≥85% |

## Ficha B — Anexo de Casa Voss

| Campo | Especificação |
|---|---|
| Âncora cartográfica | Marco 1: `CASA_VOSS=(-22; 8)` |
| Referência actual | `VossHouse.gd`, `HOUSE_ORIGIN` e a sequência de saída de Elias |
| Proposta de uso | Edificação periférica de povoado, afastada da porta principal e da linha Casa→Estrada |
| Geometria visual | Fundação, paredes espessas, entrada real, vigas, telhado de duas águas, soleira e chaminé |
| Triângulos teóricos | **180** em primitivas visuais |
| Materiais | Reboco, madeira e telhado (3) |
| Luzes dinâmicas | 0 |
| Colisão | Fundação e paredes com colisores próprios; entrada permanece aberta na cena QA |
| Evidência | `VossWaystationPreview.tscn`, 36 segundos; `CP_D5_006_CASA_VOSS_ANEXO_QA.md` |
| Teste de aceitação Dev1 | Inserir apenas numa cópia QA da Casa Voss, confirmar menu→Novo Jogo, porta E, 30+ segundos fora da casa e ausência de bloqueio do corredor |

## Limites de integração

A aprovação desta proposta **não é autorização para merger automático**. Dev5 não altera `VossHouse.gd`, `RiverRoadJourney.gd`, `TempleLevel.gd`, `Player.gd` ou qualquer módulo R7–R12. Qualquer integração exige uma review com uma única alteração causal, parser Godot 4.7.1, gameplay real mínimo de 30 segundos, captura e push próprio do proprietário R1–R6.

## Fila Dev5 após a ficha

A próxima tarefa Dev5 permanece dividida em duas frentes não conflituosas: o CP-D5-005 fica bloqueado até a obtenção de um humano rigado com licença documentada; o CP-D5-008 pode criar apenas um novo candidato de objecto 3D em cena QA, sem tocar no mundo principal.
