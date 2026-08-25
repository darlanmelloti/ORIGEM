# STATUS — GOVERNANÇA CI E BLOQUEIO DE MERGE 020

**Branch protegida:** `integration/r1-r6-sprint1`  
**Check obrigatório:** `ORIGEM Regional Gate`  
**Data:** 25 de agosto de 2026  
**Coordenação:** Dev1

## Estado aplicado

A branch de integração passou a exigir o check agregado **ORIGEM Regional Gate** com `strict=true`. Assim, uma pull request precisa estar atualizada com a integração e obter resultado verde da esteira regional antes do merge.

A proteção bloqueia force pushes e eliminações, e exige que conversas de revisão sejam resolvidas. Não existe proteção anterior sobrescrita; a branch estava sem regras antes desta configuração.

| Controlo | Configuração |
|---|---|
| Status check obrigatório | `ORIGEM Regional Gate` |
| Branch atualizada antes do merge | Sim |
| Force push | Bloqueado |
| Eliminação da branch | Bloqueada |
| Conversas sem resolver | Bloqueiam merge |
| Revisão obrigatória | Não, nesta primeira configuração |

## Check agregado

A workflow `ORIGEM Regional Continuous Gate` agora termina no job estável `ORIGEM Regional Gate`. Este job aprova apenas se todas as regiões selecionadas passarem nos parsers, contratos e rotas QA. É este nome estável que a proteção GitHub exige.

> O desenvolvimento continua livre nas branches regionais. A restrição existe apenas para impedir que regressões cheguem à integração comum sem validação.
