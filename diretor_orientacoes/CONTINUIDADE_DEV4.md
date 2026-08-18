# Continuidade — Dev4

- **Último checkpoint material:** `QA-INPUT-01` — porta por `E`, pausa/retoma por `Esc`, cursor e retorno Orion por `E` verificados em sessões de 30 segundos; a correcção associada centraliza o atalho de pausa no controlador principal e sincroniza a árvore, o painel e o cursor.
- **Validação concluída:** `QA-PACKAGE-01` e `QA-INPUT-01` aprovados. A primeira valida ZIP limpo, Menu Principal → Novo Jogo e 30 segundos sem erro de autoload. A segunda valida entrada física e detectou/corrigiu a falha real do menu de pausa.
- **Próxima tarefa iniciada:** `QA-BUDGET-01` — a partir de checkout novo, contar luzes exteriores depois de Menu Principal → Novo Jogo e provar que o orçamento permanece em no máximo 16 fontes visíveis.
- **Ficheiros dentro do escopo:** `tools/qa/verify_clean_package.sh`, `tools/qa/verify_input_flow.sh`, futuras ferramentas QA, estabilidade de input, orçamento GTX 1050 Ti, transições e documentos de evidência.
- **Critério de aceitação:** logs, capturas, contagem material e commit verificável devem acompanhar cada prova. Uma tarefa sem artefacto material não pode ser marcada como concluída.
- **Estado:** `QA-BUDGET-01 EM EXECUÇÃO — NÃO AGUARDAR DEV3 NEM DIRECÇÃO`.

## Motivo objectivo de inactividade

- **Motivo objectivo de inactividade:** nenhum. Dev4 não tem dependência proprietária para QA-BUDGET-01.
- **Verificação executada:** revisão da base canónica, QA-PACKAGE-01, QA-INPUT-01, validação headless e sessões gráficas de 30 segundos.
- **Tarefa paralela Dev4 em execução:** `QA-BUDGET-01`.
- **Encadeamento obrigatório:** ao publicar QA-BUDGET-01, iniciar `QA-STATE-01` (persistência de saúde, stamina e orientação no retorno Orion) sem abrir DIR autónomo.

Dev4 deve escolher a primeira tarefa aberta da fila `QA-PACKAGE-01 → QA-INPUT-01 → QA-BUDGET-01 → QA-STATE-01 → QA-ASSET-01` antes de encerrar qualquer prova. Nenhum relatório pode declarar CINE-PAIR concluído sem commit, evidência, marcador actualizado e próxima subtarefa material em execução na branch canónica.
