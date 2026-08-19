# CP-CARTO-119 — Captura tardia e falésia R6

## Objectivo

Corrigir o protocolo de evidência para que a captura seja recolhida no 30.º segundo de execução real e atribuir a massa escura da chegada às Ruínas Submersas antes de alterar a produção.

## Validação de gameplay real

O harness `run_dev1_cp245_route.sh` foi corrigido no ambiente de QA para capturar a janela Xvfb no 30.º segundo real. A execução total manteve 36 segundos, com a tecla de avanço sustentada entre os segundos 10 e 30. A captura obtida mede **1600×900** e mostra a chegada após esse período de gameplay.

> Evidência: `/home/ubuntu/qa_evidence_dev1_cp245/ruins_arrival_cp119_true30_xvfb/ruins_arrival_36s.png`

## Auditoria causal da falésia

O raio foi reposicionado para o centro real da massa escura na evidência tardia, em vez da coordenada do painel anterior. O primeiro colisor encontrado foi `ColisorRochaDeMargem_24`, em `(16.17834, 0.137543, 251.5766)`.

A escala da rocha 24 foi reduzida reversivelmente de 0,19 para 0,09 e a rota voltou a ser executada por 36 segundos com captura tardia. A falésia escura permaneceu visualmente equivalente; portanto a rocha não é a causa suficiente e a alteração foi revertida integralmente.

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay da chegada R6 | 36 s, PASS |
| Captura tardia | PASS, 1600×900 no segundo 30 |
| Raio da falésia | `ColisorRochaDeMargem_24` identificado |
| Redução causal da rocha | REJECTED_VISUAL; revertida |
| Alteração de produção | Nenhuma |

## Decisão

O protocolo de evidência tardia passa a ser o método obrigatório dos próximos testes Dev1. A investigação da falésia R6 permanece aberta para uma auditoria de material/normal da malha de terreno, sem repetir testes de árvores, sombras, UI, nem da Rocha de Margem 24.
