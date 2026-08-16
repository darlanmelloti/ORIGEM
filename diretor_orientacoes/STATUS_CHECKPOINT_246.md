# CP 246 — Portão Orgânico para a Vila Elevada

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Região 6, interface autorizada de handoff para a Região 7.

## Alteração

A direcção visual da Bacia Central para a Vila Elevada foi refinada no lado Dev1 da fronteira. As bases e a verga rectangulares do portão foram substituídas por instâncias do kit de colunas de ruína, escaladas e inclinadas de modo irregular. O portão mantém dois pilares e uma abertura central clara, mas passa a ser lido como arquitectura colapsada coerente com o Arco das Ruínas e com a cartografia da Vila Elevada no patamar oriental.

| Critério | Resultado |
|---|---|
| Bases do portão | Rocha de ruína orgânica |
| Verga | Três fragmentos arqueológicos orgânicos |
| Abertura jogável | Preservada pelos colisores dos pilares |
| Luzes | Nenhuma luz adicional; sinal âmbar existente preservado |
| Escopo Dev2 | Não alterado |

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

> Os avisos de `.uid` observados no editor são metadados regeneráveis do Godot e não erros de jogo; não foram versionados.

## Próximo incremento autónomo

**CP 247 — Auditoria de colisores no handoff.** O próximo ciclo verificará explicitamente que a abertura central do portão e o trilho Dev1 permanecem transitáveis depois do passe orgânico.
