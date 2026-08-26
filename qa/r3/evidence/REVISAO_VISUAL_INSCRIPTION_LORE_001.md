# Revisão Visual — DEV3-R3-INSCRIPTION-LORE-003

A primeira captura integrada foi gerada em 1600×900 pelo script `capture_r3_inscription_lore.gd`. A prova técnica passou, mas a leitura visual não satisfaz ainda o objetivo de evidência.

| Aspeto observado | Resultado | Correção necessária |
|---|---|---|
| Interface narrativa | O prólogo e a mensagem de salto permanecem visíveis. | Executar a captura no modo técnico de rota para suprimir a narrativa e a UI de prólogo. |
| Orientação do texto | A inscrição existente é vista pelo verso; o texto surge espelhado. | Orientar as novas etiquetas das placas para o lado de aproximação do percurso. |
| Enquadramento | Os pilares dominam o quadro e ocultam as placas laterais. | Usar uma câmara lateral baixa que leia uma placa, o vão livre e a transição para a floresta. |
| Corredor físico | O vão central permanece visualmente livre. | Preservar; nenhuma geometria ou colisor deve ser acrescentado. |

> A captura não é aceite como evidência final. A tarefa continua com correção de orientação e novo enquadramento, mantendo o módulo exclusivamente em `levels/regions/r3/` e `qa/r3/`.

## Revisão 2

A orientação da placa oeste foi corrigida: `O RIO GUARDA / O QUE A PEDRA CALA` está agora legível no plano lateral, e o vão continua livre. A segunda placa permanece lateral e validada tecnicamente, embora parcialmente ocultada pelo pilar neste enquadramento. A interface de prólogo persistiu porque a variável de rota foi definida dentro do processo já iniciado; a captura final deve receber `ORIGEM_QA_ROUTE=arch_to_forest` no ambiente do processo Godot. A composição será aceite quando a interface desaparecer e o enquadramento técnico mantiver a placa legível com corredor desobstruído.

## Revisão 3 — aceite

A captura final foi executada com `ORIGEM_QA_ROUTE=arch_to_forest` e as camadas `CanvasLayer`/`Control` ocultadas apenas para evidência técnica. Não há UI persistente no quadro. A placa oeste é legível, permanece fora da faixa central e é enquadrada com a silhueta do Arco e o corredor que conduz à floresta. A segunda placa é mantida como leitura complementar lateral e é confirmada pelo harness integrado; não é forçada para o centro do enquadramento, preservando a passagem e a leitura de R4.
