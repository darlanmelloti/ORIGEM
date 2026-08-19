# CP-D5-008 — Pavilhão Majestic: validação QA isolada

**Branch:** `feature/dev5-cartographic-world-third-person`  
**Âncora de destino:** Marco 5 — `ACAMPAMENTO_MAJESTIC=(-88; 178)`  
**Estado:** **aprovado como candidato QA**; integração em `ForestLakeRegion.gd` bloqueada.

## Objecto tridimensional

O mapa oficial mostra o Acampamento Majestic como um conjunto humano identificável, com tendas e estrutura de permanência. O candidato Dev5 é um pavilhão de campanha em volume real: estrado elevado, quatro postes cilíndricos, cumeeira, dois planos de lona inclinados, painéis laterais e banco interior. A entrada fica livre; não há painel de fundo, outdoor ou luz dinâmica.

| Critério | Resultado |
|---|---|
| Geometria | Tridimensional, com cobertura de duas águas e profundidade interior |
| Materiais | Madeira e lona; materiais locais da biblioteca Dev5 |
| Luzes dinâmicas | 0 |
| Colisores | Estrado e banco com colisores próprios |
| Produção R5 | Intocada |
| Cena QA | `MajesticPavilionPreview.tscn` |

## Validação

> O parser Godot 4.7.1 passou sem erro. A cena permaneceu activa por 36 segundos; a captura interna foi gravada após 30 frames e confirma a leitura volumétrica da tenda e a abertura frontal.

A evidência local encontra-se em `qa_evidence_dev5_majestic/majestic_pavilion.png` e no log de sessão correspondente.

## Limite de integração

Este resultado não autoriza a inserção automática no Acampamento Majestic. Dev1 deve primeiro comparar o candidato com o conjunto actual de R5, verificar a escala do mapa, a rota física R4→R5→R6, orçamento de colisores e gameplay completo. O pavilhão só entra em produção mediante um passe de integração próprio.

## Continuidade

O próximo estado Dev5 prepara a documentação para revisão Dev1. O activo humano rigado de Elias continua separado e bloqueado até existir ficheiro GLTF/GLB recuperável com licença documentada.
