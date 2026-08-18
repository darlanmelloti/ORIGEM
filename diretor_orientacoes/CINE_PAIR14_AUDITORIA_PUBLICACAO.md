# Auditoria de Publicação — CINE-PAIR-14

## Verificação

O relatório recebido declarou CINE-PAIR-14 concluído, CINE-PAIR-15 iniciado e um script `CinePair14GorgeReadingAudit.gd` integrado. A verificação directa da branch canónica `feature/cine07-final` não encontrou esse commit, o script, evidências CINE-PAIR-14/15 ou marcadores actualizados. A revisão remota verificável era `5c5f7e8`.

> Consequentemente, CINE-PAIR-14 não é aceite como checkpoint publicado. O relato não pode abrir CINE-PAIR-15 nem encerrar a actividade Dev4.

## Correcção de continuidade

Dev4 recebe imediatamente uma subtarefa independente: `QA-PACKAGE-01`. Foi criado `tools/qa/verify_clean_package.sh`, que cria um ZIP, extrai para directório limpo, faz validação headless, abre o Menu Principal, activa Novo Jogo, espera 30 segundos e falha perante erro de script, recurso ausente ou `game_paused` nulo.

A primeira execução de `QA-PACKAGE-01` foi aprovada com SHA-256 `0dec373bff05381e0332e53788bc051bc6128766f5694b8d921e123155fbd41e`. Dev4 não fica em espera: depois da publicação desta ferramenta, a próxima subtarefa é `QA-INPUT-01` — provar E, pausa, cursor, porta e retorno Orion numa sessão de 30 segundos.


## QA-INPUT-01 — execução material Dev4

A primeira execução da ferramenta de entrada revelou um defeito real: o cursor ficava visível depois de `Esc`, mas o painel de pausa não era apresentado. A origem estava na concorrência entre o atalho de `Esc` em `scripts/main.gd` e o `PauseMenu`, além da ausência de pausa efectiva da árvore. A correcção tornou o controlador principal processável durante pausa, centralizou nele a leitura de `Esc` e sincronizou `PauseMenu.open()`/`close()` com `SceneTree.paused` e o modo do rato.

A captura final `qa_input01_pause.png` mostra o painel **PAUSA** visível, o fundo escurecido, o cursor visível e o botão **Continuar** focado. A execução `QA-INPUT-01` também concluiu as sessões de porta por `E`, pausa/retoma e retorno Orion por `E` sem erros de parse, acesso nulo ou carregamento de recurso. Esta execução substitui a alegação anterior sem evidência do CINE-PAIR-14 e confirma que a tarefa independente do Dev4 gerou uma correcção de gameplay real.

A próxima tarefa Dev4 deve iniciar **QA-BUDGET-01**: validar, a partir de um checkout novo, que a regra de máximo de 16 luzes exteriores continua válida depois do carregamento do menu e do Novo Jogo. Ela não depende de uma alteração de Dev3.
