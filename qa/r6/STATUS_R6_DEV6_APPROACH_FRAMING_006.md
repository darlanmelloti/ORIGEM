# ORIGEM — DEV6-R6-APPROACH-FRAMING-006

**Estado:** concluída sem alteração de produção
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas

## Conclusão da auditoria

A revisão usou capturas Xvfb 1600×900 em `gl_compatibility`, varredura de orientação e uma comparação com a base anterior à entrega SHORELINE-005. A captura pós-correção mostra a água, a margem, as lajes e os vestígios R6. A base anterior teve carregamento visual instável no mesmo protocolo e não forneceu comparação de pixel determinística.

Por esta razão, não foi atribuída uma nova causa de produção. Não se alteraram água, cota do terreno, luz, shader, emissão, colisores, lajes, estela, handoff ou R7. A decisão preserva o princípio de não adicionar geometria quando a lacuna é de observabilidade do protocolo de captura.

## Verificações finais

| Verificação | Resultado |
|---|---|
| `git diff --check` | Aprovado |
| Parser Godot 4.7.1 | Aprovado |
| Orçamento R6 | Quatro luzes aprovado |
| Handoff R6→R7 | Aprovado |
| `forest_to_ruins` | Aprovada |
| `majestic_to_lake` | Aprovada |
| `ruins_arrival` | Aprovada |
| Alteração de produção | Nenhuma |

## Próxima tarefa ACTIVE

`DEV6-R6-RUNTIME-CAPTURE-PROTOCOL-007`: criar uma sonda QA R6 determinística para recolher uma captura pós-carregamento da chegada e registrar os nós de composição presentes no campo de teste. A tarefa não pode alterar gameplay, câmera de produção, R7, luzes, shaders, emissão, colisores ou âncoras cartográficas.
