# STATUS CHECKPOINT 331 — Abertura limpa e restituição controlada

**Estado:** concluído e pronto para publicação.

## Objectivo

Eliminar a contaminação visual da abertura da Casa Voss por elementos técnicos legados — incluindo o contentor `Geometry`, tablets, o Cubo Orion, emissões Chronos e protótipos do santuário — sem os remover da exploração normal posterior.

## Intervenção aplicada

`levels/VossHouse.gd` passou a resolver a raiz da cena de forma resiliente: usa `current_scene` quando disponível e recorre a `root/Main` nas instâncias de QA. Isto impede que a limpeza da abertura seja ignorada em testes onde a cena foi instanciada sem `current_scene`.

A abertura oculta explicitamente `Geometry`, `Interactables`, o protótipo `InteriorDoSantuario` e grupos de sinais Chronos durante o take. A filtragem também cobre materiais emissivos aplicados directamente à malha, não apenas material overrides. A janela de QA foi isolada do tempo do jogador e ampliada para 300 segundos de simulação, impedindo que o llvmpipe restaure marcadores antes do frame capturado aos 18 segundos. O prólogo normal permanece com 35 segundos e o gesto de salto com `E` não foi alterado.

## Validação

| Verificação | Resultado | Evidência |
|---|---:|---|
| Sintaxe Godot 4.7.1 | Aprovada | `qa_evidence_voss_vista/cp331_headless_final.log` |
| Inventário de emissores durante QA | Aprovado: zero emissores ciano técnicos visíveis | `qa_evidence_voss_vista/cp331_opening_emission_audit_pass2.log` |
| Frame de abertura aos 18 s | Capturado | `qa_evidence_voss_vista/cp331_clean_frame_final.png` |
| Gameplay normal | Aprovado: processo permaneceu activo durante 30 s | `qa_evidence_voss_vista/cp331_gameplay_30s.log` |
| Restituição após handoff QA | Aprovada: `Geometry` e `Interactables` visíveis; câmara de Elias actual | `qa_evidence_voss_vista/cp331_restore_audit_final.log` |

> A auditoria de runtime é a evidência determinística de que não existem materiais emissivos azuis técnicos visíveis durante a abertura QA. O frame é preservado como verificação visual complementar.

## Limites preservados

A alteração está confinada a `VossHouse.gd`, dentro da Região 1. Não foram alterados módulos, geometria ou câmaras das Regiões 7–12. Não foram criadas luzes dinâmicas.

## Próximo ciclo já iniciado — CP 332

Comparar a tomada recuada da Casa Voss com a referência cartográfica para escolher uma única melhoria macro não repetida, priorizando a legibilidade simultânea de Casa, rio, Estrada do Rio e Arco das Ruínas sem comprimir as distâncias físicas do vale.
