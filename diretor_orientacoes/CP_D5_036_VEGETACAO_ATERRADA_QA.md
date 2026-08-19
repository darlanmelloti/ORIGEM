# CP-D5-036 — Validação da vegetação média aterrada R4/R5

## Resultado

O harness remoto `GroundedVegetationR4R5Preview.tscn` foi validado por 36 segundos. As 12 instâncias foram aterradas por raycast Y sobre dois patches físicos inclinados, com preservação explícita de X/Z. O log reporta `grounded=true` e `xz_preserved=true` para todos os candidatos.

| Grupo | Quantidade | Resultado |
|---|---:|---|
| R4 | 6 | Aterrado; corredor central de 5,2 m preservado |
| R5 | 6 | Aterrado; leitura do pavilhão e rota futura livres |
| Total | 12 | `grounded_count=12` |
| Luzes dinâmicas adicionadas pelos objectos | 0 | Apenas uma luz do harness |
| Parede de árvores | Não | Distribuição nos bordos |
| Módulos de produção alterados | Não | QA isolado |

A sessão terminou com código 0 e sem `SCRIPT ERROR`, `Parse Error`, `Invalid call` ou `Invalid get` do Dev5. O aviso FSR1 é do renderer headless Compatibility. A captura gráfica foi solicitada e caiu no fallback seguro quando a imagem headless não estava disponível; isso não constitui aprovação visual.

## Próxima acção

Abrir o CP-D5-037 para a próxima auditoria/ficha QA ou melhoria de fundação permitida, mantendo R4/R6 pendentes de viewport gráfico válido.
