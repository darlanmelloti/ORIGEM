# STATUS CHECKPOINT 348 — Dev6 R6: recuperação auditada e orçamento de luz

**Data:** 2026-08-26
**Região:** R6 — Ruínas Submersas
**Responsável:** Dev6 / integração técnica Dev1
**Branch canónica:** `dev6/r6-submerged-ruins`

## Situação da entrega declarada

A alegada entrega `3a6f9c8` em `feature/dev6-r6-submerged-ruins` não foi localizada em nenhuma referência local, remota ou pela API do repositório. A feature publicada `feature/dev6-environment-art` não tem histórico comum com a integração, não contém o módulo isolado afirmado e tem o construtor `_build_submerged_ruins()` idêntico ao da integração. Consequentemente, nenhuma alteração não verificável foi integrada.

## Correção aprovada

A auditoria runtime do mundo encontrou nove focos pertencentes à R6: duas luzes mundiais e sete sob a hierarquia do lago. A correção `DEV6-R6-LIGHT-BUDGET-001` preserva bacia, água, domo, pilares, estela e filetes 3D da cascata, removendo somente luz submersa lateral, balizas de três marcos e brilho adicional da estela.

A sonda `qa/regions/inspect_r6_light_budget.gd` confirma o estado final:

```text
[ORIGEM_R6_LIGHT_AUDIT] world=2 lake_omni=2 lake_spot=0 r6_total=4
```

## Verificações concluídas

| Prova | Resultado |
|---|---|
| Parser Godot 4.7.1 | Aprovado |
| Porta R6 completa | Aprovada |
| Orçamento R6 em runtime | Aprovado: quatro luzes |
| Rotas | `forest_to_ruins`, `majestic_to_lake`, `ruins_arrival` aprovadas |
| Contrato regional | Aprovado |
| Água e cascata | Mantidas como geometria/volume 3D sem nova emissão excessiva |

## Continuidade Dev6

O contrato `DEV6_R6_CONTINUOUS_WORK.md` está em `ACTIVE` com a tarefa `DEV6-R6-SHORE-HANDOFF-002`. A esteira agora exige contrato válido em toda aprovação R6, mantém uma única issue `[Dev6 Continuous]` e encerra itens obsoletos quando o `task_id` avançar.

A próxima tarefa constrói a leitura física da futura transição R6→R7 por sinais arqueológicos assimétricos e continuação das lajes, sem iniciar R7, acrescentar luzes ou comprometer as rotas existentes.
