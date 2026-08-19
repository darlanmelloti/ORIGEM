# CP-D5-077 — Matriz de travessia QA R2–R6

**Finalidade:** concentrar os contratos técnicos de passagem avaliados pelos harnesses Dev5. Esta matriz não aprova visualmente nenhum cenário de produção e não autoriza integração automática pelo Dev1.

| Região | Harness | Contrato de aterramento | Folga / percurso | Câmara | Luzes QA | Estado técnico | Estado visual |
|---|---|---|---|---|---|---|---|
| R2 — Estrada | `EliasStoneBridgeTraversalPreview` | Ponte modular em `(-21,4,28)` | Tabuleiro contínuo; `0,21 m` sobre mínimo `0,20 m` | Externa | 1 direccional | Aprovado | Não promovido |
| R3 — Arco | `EliasArchCorridorPreview` | Plano QA isolado | Eixo `Z=70→103`; alvo físico do Arco `Z=92` | Externa | 1 direccional | Aprovado | Não promovido |
| R4 — Floresta | `EliasForestClearancePreview` | 6/6 vegetais por raycast | Corredor `5,20 m`; folga mínima `2,75 m` | Externa | 1 direccional | Aprovado | Não promovido |
| R5 — Majestic | `EliasMajesticClearancePreview` | Pavilhão por raycast | Corredor `X=-80`; folga `5,45 m` | Externa | 1 direccional | Aprovado | Não promovido |
| R6 — Ruínas | `EliasR6ClearancePreview` | Baliza por raycast em `(52,260)` | Folga `6,05 m` contra mínimo `4,00 m` | Externa | 1 direccional | Aprovado | Não promovido |

## Regras comuns verificadas

| Regra | Resultado |
|---|---|
| Apresentação correcta | Elias em terceira pessoa |
| Câmara interna de Elias | Inactiva nos harnesses comparados |
| Limite de luzes | Sem Omni/Spot; uma direccional QA por cena |
| Produção | `production_modules_changed=false` ou isolamento equivalente |
| Escopo | Ficheiros apenas em `levels/dev5/`, `assets/models_dev5/` ou `entities/player/third_person/` |
| Rejeições preservadas | Sem arco estrutural, ponte GLB leve ou cais de lajes cúbicas |

> **Leitura correcta:** os resultados aprovam contratos técnicos de QA. A qualidade cinematográfica, a integração de colisores regionais e a promoção para cenas de produção continuam sob revisão do Dev1.

## Próxima tarefa automática

**CP-D5-078 — Auditoria de lacunas cartográficas.** Confrontar a matriz com as âncoras R1–R6 e escolher o marco com menor cobertura Dev5 para uma melhoria de fundação permitida.
