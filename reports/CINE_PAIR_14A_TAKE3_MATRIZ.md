# CINE-PAIR-14A — Matriz de Recaptura do Take 3 Normal

## Estado operacional

**EM EXECUÇÃO MATERIAL.** Esta matriz foi criada no checkout Dev3 recuperado antes de qualquer checkpoint, ZIP ou relatório final. O seu objectivo é verificar o Take 3 normal com a câmara canónica preservada, sem alterar terreno, colisores, água, vegetação ou módulos proprietários Dev1/Dev2.

## Contrato de tomada

| Elemento | Parâmetro bloqueado | Evidência exigida |
|---|---|---|
| Câmara | FOV e orientação canónicos do Take 3; sem reenquadramento especulativo | Log de posição, rotação e FOV |
| Cenário | Só leitura das Regiões 7–12; sem alterações regionais | Scope guard limpo |
| Luzes | Máximo 16 luzes dinâmicas visíveis | Inventário de luzes no take |
| Gameplay | Sessão contínua | Mínimo de 30 segundos reais |
| Imagem | Captura tardia | 1600×900 no segundo 30 |

## Matriz de avaliação

A recaptura será avaliada pela leitura ordenada dos seguintes planos: aproximação, garganta, contrafortes, acesso à câmara e ocultação do Cubo antes da revelação. A observação de lacunas deve ser entregue como pedido específico ao proprietário regional; não autoriza o Dev3 a modificar geometria.

## Próxima acção material já aberta

Criar e executar a sonda `tools/qa/dev3_take3_camera_matrix.gd`, registando posição, rotação, FOV, luzes visíveis e fronteira R7–R12. Depois da execução, iniciar a lista de evidências `CINE-PAIR-14B` antes da publicação do checkpoint.
