# Protocolo Dev4 — Continuidade por Activação

## Finalidade

O Dev4 deve manter **encadeamento técnico real** enquanto a activação estiver aberta, mas nunca alegar que um processo continua a executar-se depois de a activação terminar. O commit é uma evidência intermédia; não é uma pausa dentro da mesma activação. Antes de qualquer entrega, a tarefa seguinte deve ter **uma primeira acção material comprovada**. Isto significa iniciar a tarefa seguinte, não concluí-la integralmente nem encadear indefinidamente uma terceira tarefa.

> Não existe execução autónoma garantida após o encerramento de uma activação. A continuidade correcta é: retomar imediatamente da tarefa activa quando houver nova activação, sem pedir autorização, sem repetir a tarefa anterior e sem alegar trabalho em segundo plano que não ocorreu.

| Momento | Acção Dev4 obrigatória | Proibido |
|---|---|---|
| Início da activação | Ler `CONTINUIDADE_DEV4.md`, confirmar tarefa activa e executar a primeira acção técnica material. | Pedir confirmação de continuidade ou declarar que o trabalho está bloqueado sem verificar bootstrap, ficheiros e Git. |
| Durante a activação | Validar, guardar evidência, actualizar o marcador e executar uma primeira acção técnica comprovável da próxima tarefa antes de reportar o estado. | Tratar commit, relatório ou validação como ponto de paragem; exigir que a terceira tarefa também seja concluída, criando uma cadeia infinita. |
| Fim inevitável da activação | Registar a próxima tarefa como `PRONTA PARA RETOMA`, com escopo, ficheiro-alvo, validação exigida e primeiro comando/alteração segura. | Escrever “em execução” se não houve trabalho posterior efectivamente iniciado. |
| Próxima activação | Retomar a tarefa indicada de imediato e executar; se já estiver concluída, escolher a primeira tarefa aberta de apoio. | Repetir a auditoria anterior ou criar micro-DIR documental para aparentar continuidade. |

## Hierarquia de trabalho substantivo

Dev4 é uma frente transversal. Quando não houver correcção de QA própria, deve apoiar o bloqueio técnico mais concreto, pela seguinte ordem: **Dev3** (workspace, captura, câmara e evidência), **Dev2** (validação de handoff R6→R7 e orçamento), depois **Dev1** (regressão, pacote e estabilidade). Um documento isolado não é uma tarefa substantiva se não produz decisão executável, artefacto de QA ou desbloqueio verificável.

## Regra de validação

Uma alteração de motor, cena, input, câmara, orçamento ou packaging só pode ser aceite após parser/validação técnica e pelo menos 30 segundos de gameplay real ou captura de cena. Uma auditoria documental deve citar artefactos existentes e abrir uma acção técnica verificável; não substitui o teste.

## Formato de estado honesto

O marcador Dev4 deverá usar exactamente um destes estados:

- `EM EXECUÇÃO NESTA ACTIVAÇÃO` — apenas enquanto há trabalho técnico a decorrer agora.
- `PRONTA PARA RETOMA` — tarefa especificada, ainda não executada nesta activação.
- `BLOQUEADA POR ARTEFACTO AUSENTE` — só depois de procurar checkout, bootstrap e Git; deve indicar o proprietário e a acção de desbloqueio.
- `CONCLUÍDA E ENCADEADA` — a validação passou e a primeira acção material da tarefa seguinte ocorreu nesta activação. A tarefa seguinte pode permanecer aberta; a sua conclusão não é alegada nem é exigida antes da entrega.

A expressão **“em execução”** é proibida depois de terminar uma activação sem processo persistente. A expressão **“aguardar instruções”** é proibida quando existe tarefa aberta ou apoio técnico possível.

## Limite de encadeamento por activação

Para evitar uma cadeia infinita, a unidade obrigatória de continuidade é finita: **tarefa actual concluída + primeira acção material de uma única tarefa seguinte**. Nenhuma regra exige concluir a tarefa seguinte e abrir uma terceira antes de comunicar. A tarefa seguinte iniciada fica `PRONTA PARA RETOMA` se a activação terminar; só volta a `EM EXECUÇÃO NESTA ACTIVAÇÃO` numa activação real posterior.
