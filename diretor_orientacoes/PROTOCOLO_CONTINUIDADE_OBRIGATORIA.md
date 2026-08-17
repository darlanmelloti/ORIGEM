# Protocolo de Continuidade Obrigatória — ORIGEM

**Aplicação imediata a Dev1, Dev2, Dev3 e Dev4.** Este documento elimina a interpretação de que um commit, relatório, captura ou resposta do Diretor é um ponto de paragem.

> **Regra absoluta:** uma tarefa só termina quando a frente já leu o Git, registou a próxima tarefa do seu escopo e iniciou o ciclo seguinte. Um commit é prova de progresso; nunca é autorização para ficar parado.

## Por que a regra anterior falhava

O manual global já exigia leitura de `diretor_orientacoes/` a cada 10 minutos e validação no fim de subtarefas. Contudo, não declarava um **artefacto de continuidade obrigatório**, nem uma consequência para a ausência desse artefacto. Assim, uma frente podia publicar um estado correcto mas encerrar a execução sem deixar prova de que tinha retomado uma nova linha de trabalho.

## Encerramento obrigatório de qualquer ciclo

Depois de implementar, validar e publicar um checkpoint, cada frente deve executar, pela ordem abaixo, sem pedir confirmação:

1. Executar `git pull --rebase` ou confirmar que a branch remota está sincronizada.
2. Ler os três documentos mais recentes de `diretor_orientacoes/`, incluindo sempre a matriz cartográfica vigente e a ordem de equipa vigente.
3. Seleccionar a primeira tarefa ainda aberta **dentro do próprio escopo**.
4. Criar ou actualizar `diretor_orientacoes/CONTINUIDADE_<FRENTE>.md` com os campos obrigatórios abaixo.
5. Fazer commit/push desse marcador junto do checkpoint ou imediatamente a seguir.
6. Iniciar a próxima alteração de código, cena, QA ou pesquisa sem esperar por resposta humana.

## Formato obrigatório do marcador

```markdown
# Continuidade — <FRENTE>

- **Último checkpoint publicado:** `<commit>`
- **Validação concluída:** headless / Novo Jogo / 30 segundos / captura
- **Próxima tarefa iniciada:** `<identificador e nome>`
- **Ficheiros dentro do escopo:** `<lista>`
- **Critério de aceitação:** `<resultado observável>`
- **Próxima leitura de orientações:** `<hora UTC>`
- **Estado:** `EM EXECUÇÃO — NÃO AGUARDAR RESPOSTA`
```

A ausência de qualquer campo, sobretudo `Próxima tarefa iniciada` ou `Estado`, torna o checkpoint **incompleto** na auditoria. Não conta como trabalho parado aprovado.

## Filas contínuas por frente

| Frente | Fila obrigatória após o checkpoint actual | Limite de escopo |
|---|---|---|
| Dev1 | Soleira panorâmica Casa Voss → leitura ponte/Arco → relevo/bacia 1–6 → próxima lacuna visual Dev1. | Regiões 1–6 e Takes 1–11. |
| Dev2 | Âncoras 7–12 → silhueta Vila/Observatório → trilha → Caverna/Câmara/Hub → QA regional. | Regiões 7–12 e Takes 12–22. |
| Dev3 | Take 0 Casa Voss→12 marcos → grelha de legibilidade → auditoria de takes → próxima correcção de enquadramento. | Câmaras, takes e evidências; não altera geometria regional. |
| Dev4 / Diretor Geral | Ler os marcadores das três frentes → publicar lacuna de prioridade → actualizar matriz/ordem → iniciar a auditoria seguinte. | `diretor_orientacoes/`, coordenação e critérios transversais. |

## Dever reforçado do Dev4

Dev4 não pode fechar uma auditoria com frases como “aguardar validação”, “solicitar confirmação” ou “próxima tarefa a definir”. Ao terminar uma auditoria, deve obrigatoriamente publicar uma nova ordem numerada, indicar o proprietário e escrever no seu marcador a primeira auditoria ou brief já iniciada. Se uma frente não publicar marcador de continuidade, Dev4 abre imediatamente uma nota `BLOQUEIO_DE_CONTINUIDADE_<FRENTE>.md` e atribui a próxima tarefa objectiva; não aguarda reunião.

## Auditoria automática humana

Em cada leitura de orientações, todas as frentes verificam os quatro marcadores `CONTINUIDADE_DEV1.md`, `CONTINUIDADE_DEV2.md`, `CONTINUIDADE_DEV3.md` e `CONTINUIDADE_DEV4.md`. Um marcador com mais de 30 minutos sem novo checkpoint ou sem tarefa marcada como `EM EXECUÇÃO` é uma falha de processo e deve receber uma nova tarefa no mesmo ciclo.

## Frases proibidas como estado final

- “Aguardar instruções.”
- “Tarefa concluída; parar.”
- “Enviar ao Diretor para decidir o próximo passo.”
- “Nenhuma próxima tarefa definida.”

A única formulação válida ao concluir um checkpoint é: **“Checkpoint publicado; próxima tarefa `<ID>` já iniciada.”**
