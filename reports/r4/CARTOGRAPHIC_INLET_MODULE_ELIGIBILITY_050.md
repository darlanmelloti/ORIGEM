# ORIGEM — Auditoria de Elegibilidade Modular do Afluente Cartográfico R4 050

**Tarefa:** `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-ELIGIBILITY-050`
**Estado:** Auditoria QA aprovada; nenhuma candidata autorizada para produção

## Reconciliação canónica

A integração canónica R1–R6 foi adoptada antes da auditoria. O contrato integrado confirmou que transparência, cota, largura e `cull_back` são variantes rejeitadas para a lâmina partilhada `LaminaDoAfluenteCartografico`. A variante local de material, incompatível com essa decisão, foi removida de `ForestLakeRegion.gd`, dos módulos e das provas locais, restaurando a fábrica lacustre canónica sem modificar água R6, iluminação, rota, câmara, física ou âncoras.

> **Decisão:** esta auditoria não autoriza produção. A água e o material lacustre continuam sob responsabilidade conjunta R6, e qualquer futura composição externa exige aprovação explícita R4/R6, uma causa identificada e comparação runtime nova.

## Inventário QA de margem existente

A prova isolada `verify_r4_cartographic_inlet_module_eligibility.gd` instanciou a região em QA, sem adicionar, mover, ocultar ou materializar nós. Foram inventariados apenas activos R4 existentes que ficam fora da clareira Orion e cumprem a distância mínima ao trilho.

| Activo existente | Propriedade | Z | Distância ao trilho | Estado |
|---|---|---:|---:|---|
| `RaizExpostaFlorestal_14` | Dev4/R4 existente | 183,44 | 8,75 m | Inventariada; não autorizada |
| `RaizExpostaFlorestal_15` | Dev4/R4 existente | 187,61 | 9,20 m | Inventariada; não autorizada |

As duas referências são apenas candidatas espaciais de inventário. Não demonstram ganho visual, não constituem proposta de ocultação e não podem ser alteradas sem uma tarefa distinta, aprovação de propriedade R4/R6 e par de capturas runtime no mesmo enquadramento de `arch_to_forest`.

## Exclusões verificadas

| Restrição | Resultado |
|---|---|
| Lâmina partilhada sem override local | Aprovada |
| Material lacustre canónico presente | Aprovada |
| Luzes ou colisores dentro do afluente | Nenhum encontrado |
| Clareira Orion `Z≈126–151` | Excluída do inventário |
| Corredor físico R4 | Activos inventariados a `≥8 m` |
| Água, quatro luzes e handoff R6 | Sem alteração |
| Produção nesta tarefa | Nenhuma alteração adicional |

## Validação

| Verificação | Resultado |
|---|---|
| Prova QA de elegibilidade | `[ORIGEM_R4_INLET_050_OK]` com 2 itens inventariados |
| Parser Godot headless | Aprovado |
| Auditoria de orçamento | `[QA-BUDGET-01] result=PASS` |
| Porta R4 | `[GATE:R4] PASS` |
| Porta R6 | `[GATE:R6] PASS` |
| `arch_to_forest` | Aprovada |
| `forest_to_majestic` | Aprovada |
| `forest_to_ruins` | Aprovada |

O aviso de `material` nulo eventualmente exibido ao encerrar harnesses headless é ruído conhecido do backend dummy após verificações concluídas com sucesso. Não foram observados erros de parser, script, shader ou falhas fatais.

## Sucessão

A tarefa activa seguinte é `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-OWNERSHIP-CHECK-051`. Ela é exclusivamente QA documental: deve confirmar a matriz de responsabilidade R4/R6, a causa e o roteiro de captura para qualquer candidata futura, sem criar, mover, instanciar, materializar ou ocultar nós e sem alterar `ForestLakeRegion.gd`, materiais, água, luzes, rota, câmara, âncoras ou física.
