# QA Cartográfico — Prova Ampla Casa Voss→Estrada→Arco

**Branch:** `feature/cine07-final`  
**Escopo:** validação R1–R3; nenhuma alteração a módulos R7–R12.  
**Data:** 18 de agosto de 2026.

## Resultado da prova

A captura através de `ORIGEM_CAPTURE_TAKE=1` foi **rejeitada**: embora a câmara tenha sido activada, a imagem permaneceu negra no ambiente OpenGL de QA e não pode servir como evidência visual.

A prova foi repetida com o fluxo de jogo normal, usando `ORIGEM_QA_SKIP_OPENING=1` e Novo Jogo automático. Sem deslocar o jogador depois do spawn, a câmara de Elias manteve a orientação física calculada para o Arco. A captura resultante confirma a estrada de lajes, a silhueta do Arco das Ruínas no eixo e a continuidade do vale até às elevações mais distantes.

| Critério | Resultado |
| --- | --- |
| Sessão real | **30 segundos concluídos** |
| Erros de script, parse ou crash | **Nenhum detectado** |
| Captura útil | `/home/ubuntu/qa_evidence_voss_vista/cp_carto32_road_to_arch_stationary_1600x900.png` |
| Estrada física | **Legível** |
| Arco das Ruínas | **Legível como destino frontal** |
| Tomada cinematográfica `ORIGEM_CAPTURE_TAKE` | **Rejeitada** até a correção de harness; não usar como evidência |

## Próxima fila

A prova macro R1–R3 passa como verificação espacial, mas não encerra o polimento artístico: a ponte/rio e as massas laterais ainda devem ser avaliados numa tomada de movimento controlado. Antes de alterar geometria, a próxima tarefa é tornar o harness cinematográfico utilizável em OpenGL QA ou substituir a sua captura por uma câmara de jogador já aprovada.

> Nenhuma captura ou relatório é um ponto de paragem. A próxima validação deve manter Casa Voss, a Estrada e o Arco no mesmo eixo físico, sem aproximar artificialmente os marcos cartográficos.
