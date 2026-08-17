# CP-CINE-48 — Handoff Físico Garganta Orion → Interior

## Resultado

O gatilho invisível `GatilhoFisicoInteriorOrion` deixou de ser apenas um marcador de QA. Ao detectar Elias, preserva a sua posição de retorno, orientação, saúde e stamina no autoload `OrionTransitionState` e inicia a cena independente `res://scenes/orion_interior.tscn`. A cena interior cria Elias com a mesma lógica de controlo, colisão, câmara, lanterna, espada, saúde e stamina. O retorno fica disponível por **E** no raio físico da entrada interior.

O Cube de Orion, o altar e a luz Chronos não fazem parte da cena interior neste checkpoint. Por isso, o artefacto não aparece na garganta exterior, nem é revelado durante o primeiro corredor subterrâneo.

| Critério | Resultado |
|---|---|
| Entrada pelo volume físico exterior | Validada por `ORION_HANDOFF_READY` |
| Entrada e retorno QA, uma vez cada | Validados em 30 segundos |
| Sintaxe e carregamento Godot 4.7.1 | Aprovados |
| Runtime independente do corredor, 30 segundos | Aprovado sem erros |
| Cube, altar e emissão Chronos no corredor | Ausentes |
| Orçamento de luzes locais | 2 luzes sem sombra |

## Evidência

A captura `cp_cine48_handoff_validated.png` confirma que a cena após o handoff é o corredor rochoso interior, sem céu e sem artefacto exposto. O registo `cp_cine48_entry_return_30s.log` contém exactamente um `ORION_HANDOFF_READY` e um `ORION_RETURN_READY` durante a prova de 30 segundos.

## Próximo ciclo já iniciado

**CP-CINE-49 — Ante-câmara do santuário.** O próximo bloco deverá acrescentar um desvio físico legível após a curva do corredor, ainda sem introduzir o Cube ou o altar. A composição deve manter a rota central livre, não usar paredes primitivas e não elevar o orçamento de luzes acima do limite definido.
