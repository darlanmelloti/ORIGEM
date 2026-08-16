# CP 236 — Continuidade Hídrica Rio → Bacia Central

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Regiões 2–6; nenhuma geometria ou activo das Regiões 7–12 foi alterado.

## Alteração

Foi criado o `AfluenteCartograficoRioParaBacia`: uma faixa de água procedural, sem colisores e sem luzes adicionais, que prolonga a leitura do Rio da Estrada até à margem ocidental da Bacia das Ruínas Submersas.

| Elemento | Implementação |
|---|---|
| Início do afluente | Continuação visual do rio em `z=163`. |
| Chegada | Margem oeste da Bacia Central em `z=224`. |
| Material | Mesmo material de água do lago. |
| Física | Sem colisores; não altera o trilho jogável. |
| Orçamento GTX 1050 Ti | Sem novas luzes dinâmicas ou partículas. |

A mudança aproxima a hidrologia do mundo físico à cartografia, onde o curso ribeirinho converte-se na bacia central antes da Vila Elevada.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Estabilidade pós-Novo Jogo | 50 segundos aprovados |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

> A automação gráfica llvmpipe tem uma janela temporal limitada; a prova de exploração foi antecipada para iniciar logo após a activação do mundo e continua a conter os 30 segundos completos exigidos.

## Próximo incremento autónomo

**CP 237 — Silhuetas de relevo da Bacia Central.** O próximo ciclo verificará se as margens e os promontórios das Ruínas Submersas preservam a leitura do lago central, das cascatas e da subida para a Vila Elevada mostrada na cartografia.
