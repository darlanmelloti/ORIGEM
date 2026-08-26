# Dev7 — Auditoria de Integração e Política de CI 008

| Campo | Estado verificado |
|---|---|
| **Branch Dev7** | `dev7/visual-playable-physics` em `49557b91` |
| **PR de integração** | [#380](https://github.com/darlanmelloti/ORIGEM/pull/380) — aberta |
| **Branch base** | `integration/r1-r6-sprint1` |
| **Estado de merge exposto** | `BLOCKED` |
| **Mergeabilidade exposta** | `MERGEABLE` |
| **Bypass administrativo** | Não utilizado; proibido neste ciclo |
| **Auto-merge** | Não utilizado; indisponível segundo a coordenação |
| **Produção R6** | Não modificada |

## CI comum validada

A CI comum executada no commit `7678f22` concluiu com sucesso. Os check runs consultados confirmam `success/completed` para o orçamento global de luz e para as portas regionais R2, R3, R4, R5 e R6. O conjunto também inclui a determinação de regiões afetadas e o fluxo de próxima tarefa ativa dos times regionais.

| Check validado em `7678f22` | Resultado |
|---|---|
| `Orçamento global de luz` | **SUCCESS** |
| `Porta regional R2` | **SUCCESS** |
| `Porta regional R3` | **SUCCESS** |
| `Porta regional R4` | **SUCCESS** |
| `Porta regional R5` | **SUCCESS** |
| `Porta regional R6` | **SUCCESS** |
| `Determinar regiões afetadas` | **SUCCESS** |

Esta aprovação confirma o estado comum do commit de reconciliação de registo. Ela não autoriza a variante arqueológica R6 rejeitada nem muda a proibição de comparativos e produção.

## Política de integração da base

A proteção de `integration/r1-r6-sprint1` exige estritamente o contexto `ORIGEM Regional Gate`. A API de leitura não expõe revisão obrigatória nem restrições por utilizador, e `enforce_admins` está desativado. A PR #380, no entanto, informa `BLOCKED` e não associa checks ao seu head atual. Isso é suficiente para manter a integração parada de forma segura, mas não justifica qualquer alteração de proteção, bypass ou tentativa de merge manual.

> Dev7 não contorna política de branch. A continuação permitida é publicar evidência QA e acompanhar a associação de CI ao head da PR; integração exige que a plataforma aceite o gate obrigatório no head elegível.

## Condições para integração legítima

| Condição | Estado atual | Ação Dev7 permitida |
|---|---|---|
| Head Dev7 contém head canónico | Confirmado na reconciliação anterior. | Manter a branch atualizada. |
| `ORIGEM Regional Gate` no head elegível da PR | Não exposto para o head atual da PR. | Acompanhar; não simular, reescrever ou contornar. |
| Política de branch satisfeita | Não confirmada pela plataforma. | Não integrar. |
| Bypass ou auto-merge | Não permitido/indisponível. | Não tentar. |
| Hipótese visual R6 aprovada por Dev6/R6 | Não recebida. | Não criar comparativo ou produção. |

## Continuidade Dev7

Enquanto a PR permanece bloqueada, Dev7 continua limitado a auditoria documental e verificação somente de leitura. A taxonomia pós-canónica permanece estável: cinco vestígios de entrada distintos e quinze meshes abrangidos pelas quatro categorias históricas. A captura 003 continua rejeitada para produção e nenhuma mutação R6 foi introduzida neste ciclo.

## Fontes internas e de plataforma

| Fonte | Finalidade |
|---|---|
| `gh run list --commit 7678f22` | Estado do workflow comum aprovado. |
| `gh api .../commits/7678f22/check-runs` | Check runs individuais aprovados. |
| `gh pr view 380` | Estado bloqueado e head atual da PR. |
| `gh api .../branches/integration/r1-r6-sprint1/protection` | Política de gate estrito da base, somente leitura. |
| `R6_POSTCANONICAL_REGISTRY_AUDIT_007.md` | Invariância de identidade R6 sem comparativo. |
