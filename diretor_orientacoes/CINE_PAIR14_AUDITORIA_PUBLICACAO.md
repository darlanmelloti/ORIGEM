# Auditoria de Publicação — CINE-PAIR-14

## Verificação

O relatório recebido declarou CINE-PAIR-14 concluído, CINE-PAIR-15 iniciado e um script `CinePair14GorgeReadingAudit.gd` integrado. A verificação directa da branch canónica `feature/cine07-final` não encontrou esse commit, o script, evidências CINE-PAIR-14/15 ou marcadores actualizados. A revisão remota verificável era `5c5f7e8`.

> Consequentemente, CINE-PAIR-14 não é aceite como checkpoint publicado. O relato não pode abrir CINE-PAIR-15 nem encerrar a actividade Dev4.

## Correcção de continuidade

Dev4 recebe imediatamente uma subtarefa independente: `QA-PACKAGE-01`. Foi criado `tools/qa/verify_clean_package.sh`, que cria um ZIP, extrai para directório limpo, faz validação headless, abre o Menu Principal, activa Novo Jogo, espera 30 segundos e falha perante erro de script, recurso ausente ou `game_paused` nulo.

A primeira execução de `QA-PACKAGE-01` foi aprovada com SHA-256 `0dec373bff05381e0332e53788bc051bc6128766f5694b8d921e123155fbd41e`. Dev4 não fica em espera: depois da publicação desta ferramenta, a próxima subtarefa é `QA-INPUT-01` — provar E, pausa, cursor, porta e retorno Orion numa sessão de 30 segundos.
