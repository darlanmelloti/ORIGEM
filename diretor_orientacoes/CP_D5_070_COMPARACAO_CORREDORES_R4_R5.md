# CP-D5-070 — Comparação de corredores R4/R5

**Escopo:** comparação de dois harnesses QA existentes em `levels/dev5/`. Não altera as regiões de produção, a IA, `Player.gd` ou a UI do mapa.

## Evidência comparada

| Critério | R4 — Floresta Densa | R5 — Acampamento Majestic | Resultado |
|---|---|---|---|
| Elias | Apresentação em terceira pessoa | Apresentação em terceira pessoa | Conforme |
| Câmara | Externa; câmara Elias inactiva | Externa; câmara Elias inactiva | Conforme |
| Aterramento | 6/6 candidatos por raycast | Pavilhão por raycast | Conforme |
| Corredor | `5,20 m`, folga mínima `2,75 m` | Corredor `X=-80`, folga `5,45 m` | Conforme |
| Vegetação | `wall_of_trees=false`, `forest_portal=false` | Não cria barreira vegetal | Conforme |
| Luzes | Uma direccional QA | Uma direccional QA | Dentro do orçamento |
| Execução | 3 ciclos em 36 segundos | 2 ciclos em 36 segundos | Conforme |

## Revisão visual

A captura R4 mostra Elias no corredor aberto com as árvores colocadas lateralmente, preservando profundidade mas sem painel vegetal ou portal. A captura R5 mostra Elias separado do pavilhão Majestic por espaço livre suficiente. As duas imagens são **provas técnicas de escala e folga**, não aprovação estética dos biomas de produção.

## Conclusão

Os corredores R4 e R5 cumprem os contratos QA de passagem, grounding e câmara. Permanecem pendentes de uma integração decidida pelo Dev1 e de validação cinematográfica dentro das cenas de produção.

## Próxima tarefa automática

**CP-D5-071 — Auditoria de reversão de candidatos.** Confirmar que os harnesses R4, R5 e R6 não criam dependências de produção e que cada candidato pode ser removido sem afectar os módulos regionais.
