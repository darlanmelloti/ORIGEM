# CP 238 — Handoff Monumental Bacia → Vila Elevada

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** lado Dev1 da transição Região 6 → Região 7; nenhum módulo regional Dev2 foi alterado.

## Alteração

O portão de handoff deixou de depender de pilares rectangulares visíveis. As duas colunas passaram a utilizar o activo de ruína `stone_tallC.glb`, aplicado com variações subtis de escala, inclinação e orientação. Os colisores baixos continuam independentes e preservam integralmente o vão central do portão.

| Critério | Resultado |
|---|---|
| Leitura monumental | Colunas de ruína orgânicas e arqueológicas. |
| Ligação cartográfica | Mantida na âncora `VILA_ELEVADA` em `(140, y, 352)`. |
| Percurso físico | Abertura central livre, com colisores laterais simples. |
| Região 7 | Não modificada. |
| Orçamento técnico | Sem luzes ou partículas adicionais. |

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 239 — Auditoria final da rota cartográfica Dev1.** O próximo ciclo consolidará a relação entre as seis regiões implementadas, o marcador de Elias e a passagem para Dev2, listando apenas prioridades visuais que permaneçam dentro do escopo Dev1.
