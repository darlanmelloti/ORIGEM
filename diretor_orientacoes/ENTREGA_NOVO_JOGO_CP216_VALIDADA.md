# ORIGEM — Entrega CP 216: Novo Jogo Validado

**Branch:** `feature/dev1-gameplay-core`  
**Estado de distribuição:** aprovado somente após fluxo gráfico de Novo Jogo e exploração de 30 segundos.

## Correcções incluídas

| Módulo | Correcção |
|---|---|
| `TempleLevel.gd` | Substituição de `trail_mat` inexistente por `stone_mat` e declaração explícita de `moss_mat` para as pedras de base do portão de transição. |
| `RiverRoadJourney.gd` | Substituição da referência `ROCK` inexistente por `RUIN_ROCK` na ecologia da curva sul. |
| `VossHouse.gd` | Entrega de controlo mais robusta após o prólogo, incluindo câmara de Elias, ponto seguro de recuperação e modo de QA isolado para validar a transição sem afectar a execução normal. |

## Prova obrigatória de entrega

| Critério | Resultado |
|---|---|
| Novo Jogo accionado a partir do menu | ✅ Aprovado |
| Erros de parser ou símbolos não declarados | ✅ Nenhum no fluxo gráfico |
| Prólogo concluído em modo QA de validação | ✅ Aprovado |
| Cenário visível após a transição | ✅ Aprovado |
| Movimento exploratório por 30 segundos | ✅ Aprovado |
| Processo Godot activo ao fim da prova | ✅ Aprovado |
| Fronteira Regiões 1–6 | ✅ Mantida |

As capturas pontuais antes e depois do movimento mostram a mudança de enquadramento no vale, com floresta, montanha, ruínas e percurso visíveis. A validação usa o renderizador de compatibilidade no ambiente llvmpipe para evitar a sobrecarga da gravação contínua; a execução final do jogador continua a seleccionar o renderizador no próprio Godot.

> O ZIP desta entrega só foi criado depois desta validação. Deve ser extraído numa pasta limpa antes de importar `project.godot` no Godot 4.7.1.
