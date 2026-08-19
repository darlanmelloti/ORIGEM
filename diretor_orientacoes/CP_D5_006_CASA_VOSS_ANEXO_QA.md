# CP-D5-006 — Anexo tridimensional Casa Voss: validação isolada

**Branch:** `feature/dev5-cartographic-world-third-person`  
**Escopo:** biblioteca `levels/dev5/` e cena QA isolada.  
**Decisão:** **aprovado como candidato Dev5**, sem integração no mapa de produção.

## Intenção cartográfica

O marco 1 do mapa oficial representa a Casa Voss como um conjunto habitado. Esta cena cria uma edificação auxiliar independente, destinada a aumentar a leitura de povoado quando a integração futura for revista pelo proprietário das Regiões 1–6. Não substitui `VossHouse.gd`, a porta existente, o prólogo ou a casa jogável.

## Objecto validado

| Elemento | Estado |
|---|---|
| Fundação e paredes | Geometria volumétrica com colisores próprios |
| Entrada | Abertura frontal, soleira e lintel de madeira; não é uma fachada plana |
| Estrutura | Quatro vigas de canto e cobertura de duas águas física |
| Orçamento | Três materiais, uma luz direccional QA, nenhuma luz dinâmica local |
| Integração em Casa Voss | Bloqueada até revisão Dev1 |

A cena `VossWaystationPreview.tscn` permanece isolada e é a única consumidora da biblioteca durante este checkpoint.

## Validação

> O parser Godot 4.7.1 passou. A sessão QA ficou activa por 36 segundos, com captura interna gravada após 30 frames. A imagem confirma volume, abertura e cobertura de duas águas em 3D.

A evidência local encontra-se em `qa_evidence_dev5_voss/voss_waystation.png` e no respetivo log de 36 segundos.

## Elias em terceira pessoa

A apresentação QA de Elias recebeu melhorias de silhueta: colete aberto, cinto e fivela, cabelo assimétrico, bolsa lateral e espada com punho. Continua a ser uma **proxy técnica**, sem substituição de `Player.gd` e sem ser apresentada como o modelo artístico final. A integração de um humano rigado continua dependente de um ficheiro GLTF/GLB recuperável e da respectiva licença/atribuição.

## Próxima tarefa activa

**CP-D5-007 — Auditoria de proposta de integração.** O Dev5 prepara somente uma ficha de colocação para a ponte e para o anexo, contendo âncora cartográfica, distância, triângulos, colisores e proprietário R1–R6. Nenhum objecto Dev5 entra em produção antes da aprovação de integração.
