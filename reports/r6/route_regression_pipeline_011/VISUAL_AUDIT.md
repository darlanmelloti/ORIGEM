# Auditoria Visual — Pipeline de Regressão R6 011

## Observação inicial

A primeira execução da pipeline capturou ainda o ecrã de arranque do motor, embora a telemetria e a composição runtime já fossem válidas. Essa imagem não foi aceite como evidência visual da rota.

## Correção aplicada

O script `tools/qa/capture_r6_arrival_runtime.sh` passou a aguardar um período configurável `ORIGEM_QA_CAPTURE_SETTLE_SECONDS`, com valor predefinido de 12 segundos e mínimo de 4 segundos, após a confirmação de spawn antes de realizar a captura.

## Verificação visual pós-correção

A recaptura de `ruins_arrival` em `1600×900` mostra a cena runtime carregada, com terreno, relevo distante, estela, elementos arqueológicos e céu visíveis. A captura já não apresenta o ecrã de arranque do motor.

> Conclusão: a pipeline deve ser reexecutada com o período de estabilização ampliado para substituir todas as três capturas inicialmente preservadas e produzir evidência visual runtime consistente para as rotas R6.

## Revisão das rotas estabilizadas

As capturas estabilizadas de `forest_to_ruins` e `majestic_to_lake` confirmam que o ecrã mostra a cena runtime e não a abertura do motor. Ambas preservam leitura de terreno, relevo, marcos e sequência de lajes físicas; a telemetria correspondente aprovou sem desvio da baseline.

Há, porém, uma observação visual concreta para a próxima frente artística R6: as vistas ainda expõem um terreno muito aberto, objetos isolados e lajes com leitura de protótipo. Esta é uma dívida visual de produção, não uma falha da pipeline QA. A tarefa atual de regressão não altera o mundo; qualquer melhoria deverá ser um incremento R6 próprio, modular, cartograficamente ancorado e sujeito ao orçamento fixo de quatro luzes.
