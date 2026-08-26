# Dev7 — Validação R6 Pós-Reconciliação Canónica 014

| Campo | Resultado |
|---|---|
| **Head canónico integrado** | `8b5397f5` |
| **Conflitos de merge** | Nenhum |
| **Evidências Dev7 preservadas** | Confirmadas após merge |
| **Parser Godot** | **PASS** |
| **Gate regional R6** | **PASS** |
| **Rota `forest_to_ruins`** | **PASS** |
| **Auditoria global de luz** | **PASS** |
| **Formato Git contra base** | **PASS** |
| **Comparativos R6 / produção** | Não executados / não modificada |

## Reconciliação

A branch Dev7 integrou o novo head canónico sem conflito. A atualização contém a composição arqueológica de plano médio Dev6/R6 e os módulos R4 associados, mas não substituiu as evidências Dev7 do checkpoint controlado. As referências de segurança anteriores permanecem disponíveis para recuperação dos commits locais.

## Validação local

O parser Godot passou no estado reconciliado. O gate R6 aprovou os contratos regionais, as rotas canónicas e, em particular, `forest_to_ruins`. A auditoria global de luz também passou. O `git diff --check` contra a integração canónica não reportou problemas de formato.

> Esta validação confirma compatibilidade técnica do checkpoint Dev7 com o novo head canónico. Ela não aprova uma variante visual R6, não altera a rejeição da captura 003 e não substitui a autorização explícita de Dev6/R6 necessária para qualquer novo teste comparativo ou mutação de produção.

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `parser.log` | Parser Godot após merge. |
| `r6_regional_gate.log` | Gate R6, contratos e rotas. |
| `light_budget.log` | Resultado da auditoria global de luz. |
| `light_budget/` | Logs de importação e runtime da auditoria. |

## Próximo marco

A publicação da reconciliação Dev7 só ocorre depois da verificação final de escopo e referência remota. A CI já aprovada para `833e01f2` é evidência da ponta anterior; qualquer publicação deste conjunto reconciliado seguirá a política normal, sem bypass, force-push ou execução manual agressiva.
