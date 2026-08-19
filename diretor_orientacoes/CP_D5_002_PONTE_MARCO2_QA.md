# CP-D5-002 — Ponte de Pedra do Marco 2: validação isolada

**Branch:** `feature/dev5-cartographic-world-third-person`  
**Escopo:** módulo novo em `levels/dev5/`; sem alteração em `RiverRoadJourney.gd` ou no mundo de produção.  
**Decisão:** **aprovada como candidato de integração**, ainda bloqueada para integração até revisão do proprietário R1–R6.

## Objectivo

Validar uma ponte tridimensional real que traduza o marco 2 — Estrada do Rio/Ponte de Pedra — do mapa cartográfico. O objecto deveria ser reconhecível como travessia arqueada, ter uma superfície física própria e não recorrer a plano, billboard, luz dinâmica ou geometria regional existente.

## Implementação validada

| Elemento | Implementação | Limite Dev5 |
|---|---|---:|
| Tabuleiro | 7 lajes arqueadas com `StaticBody3D` próprio | Físico e contínuo |
| Encontros | 2 massas de pedra com cobertura discreta de musgo | 0 luzes |
| Arcos | 18 aduelas laterais e 4 apoios de margem | 3 materiais |
| Parapeitos | 10 blocos descontínuos, sem vedar a passagem | 0 luzes |
| Materiais | Pedra, pedra envelhecida e musgo | 3 materiais |

A cena QA `StoneBridgeLandmarkPreview.tscn` coloca a ponte sobre água de teste e margens simples, mantendo o objecto isolado do corredor de produção.

## Validação

> A validação do Godot 4.7.1 passou sem erro de parser. A sessão gráfica permaneceu activa durante 36 segundos; a captura interna do viewport foi gravada com êxito e a ponte permanece visível como marco arqueado sobre a água.

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | Passou |
| Sessão QA | 36 segundos, encerramento controlado do processo gráfico |
| Captura interna | `qa_evidence_dev5_bridge/stone_bridge_refined.png` |
| Luzes dinâmicas do objecto | 0 |
| Alteração em `RiverRoadJourney.gd` | Nenhuma |
| Alteração em regiões Dev2 | Nenhuma |

## Próxima acção

O Dev5 não integra a ponte no mundo principal. A próxima tarefa isolada é **CP-D5-003/004**: manter e melhorar a apresentação de Elias em terceira pessoa apenas em QA, enquanto a integração de qualquer objecto no mapa real depende de revisão técnica conjunta com a frente R1–R6.
