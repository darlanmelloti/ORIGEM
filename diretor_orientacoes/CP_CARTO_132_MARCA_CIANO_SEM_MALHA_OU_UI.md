# CP-CARTO-132 — Marca ciano da saída: malha e interface excluídas

## Investigação

A auditoria de caixas envolventes não encontrou qualquer `MeshInstance3D` visível cujo volume cobrisse o pixel do componente azul residual. A comparação seguinte ocultou todas as `CanvasLayer` e todos os `Control` activos depois de o nível estar carregado.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay Casa Voss→Estrada | 36 segundos |
| Captura tardia | 1600×900 no segundo 30 |
| Caixa de malha causal | Nenhuma identificada |
| Interface/HUD | Excluídos |
| Marca azul | Persistiu |

> Evidência sem interface: `/home/ubuntu/qa_evidence_dev1_cp245/voss_to_road_cp132_no_ui/voss_to_road_no_ui_36s.png`

## Decisão

**NÃO ATRIBUÍDA.** A marca azul não pertence a uma malha com caixa projectável nem à interface activa. As sondas QA foram revertidas sem alteração de produção. A investigação deve ficar suspensa até existir uma sonda de renderização por camada; o próximo refinamento volta à legibilidade ambiental mensurável.
