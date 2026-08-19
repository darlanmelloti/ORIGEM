# CP-D5-084 — Matriz de fronteira Dev5/Dev1

**Propósito:** permitir que o Dev1 avalie contratos QA Dev5 sem interpretar uma prova isolada como autorização para alterar a produção.

| Item QA Dev5 | Marco | Pode ser entregue ao Dev1 | Condições obrigatórias de integração | Bloqueio actual |
|---|---:|---|---|---|
| Sistema de aterramento por raycast | R1–R6 | Sim, como utilitário | Preservar X/Z; aplicar apenas à altura; validar no relevo regional | Não ligar automaticamente a todos os props |
| Contratos de altura | R1–R6 | Sim, como referência | Confirmar proprietário do terreno e colisor real | Não substituir altura canónica sem revisão |
| Ponte modular e travessia Elias | R2 | Sim, como referência técnica | Revalidar no Rio de produção; manter passagem e material regional | Ponte GLB leve permanece rejeitada |
| Corredor R3 e alvo físico Z=92 | R3 | Sim, como contrato espacial | Preservar alvo físico e transição para R4 | Arco estrutural permanece rejeitado |
| Vegetação aterrada / corredor Elias | R4 | Sim, como limites LOD e passagem | Um PBR focal; três médias; seis leves; trilho aberto | Sem parede ou portal florestal |
| Pavilhão e corredor Elias | R5 | Sim, como contrato de folga | Confirmar cenário Majestic e ausência de nova luz dinâmica | Não promover pavilhão QA sem revisão estética |
| Baliza R6, folga e handoff R7 | R6 | Sim, como referência de rota | Manter mínimo de 4 m; respeitar fronteira Dev2 em R7 | Sem cais em lajes ou geometria Dev2 |
| Elias em terceira pessoa | R1–R6 | Sim, como apresentação provisória | Conservar câmara externa e contrato de colisão | Aguardar activo humano rigado aprovado |

## Operação de integração

> O Dev1 decide a promoção de cada item e executa a integração dentro dos módulos R1–R6. O Dev5 não altera esses módulos; fornece contratos, previews, capturas e limites auditáveis. Um item só muda de “referência técnica” para “integrado” depois de parser, gameplay regional ≥30 segundos, captura e ausência de regressões.

## Próxima tarefa automática

**CP-D5-085 — Auditoria de compatibilidade de contratos.** Confirmar que as referências entregáveis acima continuam dentro da fronteira Dev5 e que os cenários QA associados permanecem executáveis após as actualizações da branch.
