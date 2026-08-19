# CP-CARTO-118 — Aproximação às Ruínas Submersas: auditoria causal

## Evidência recolhida

A rota `forest_to_ruins` concluiu 36 segundos de gameplay e produziu uma captura de chegada R6. A auditoria identificou uma massa escura rectangular que degrada a leitura do destino, além de formas auxiliares legadas no lado esquerdo.

Foram executadas comparações QA reversíveis: ocultação de árvores 66, 72 e 76, remoção diferida da árvore 76, isolamento de sombras direccionais, projecção por ponto, projecção por caixa envolvente e raio físico. A caixa de `ArvoreDaFloresta_76` sobrepõe o pixel central testado, mas a sua remoção total não altera a massa rectangular observada. O raio físico não encontrou colisor no alvo. Não existe, portanto, uma causa de produção demonstrada que possa ser removida com segurança.

## Decisão

A instrumentação QA foi revertida integralmente. Nenhuma geometria, água, árvore, colisor ou luz de produção foi alterada. A lacuna permanece **REJECTED_VISUAL / NÃO ATRIBUÍDA** e requer rastreio de composição por uma frente de renderização ou activo, sem repetir as hipóteses já excluídas.

| Verificação | Resultado |
|---|---|
| Gameplay `forest_to_ruins` | 36 s, PASS |
| Captura de aproximação R6 | Gerada, 1920×1080 |
| Testes causais de árvores | Rejeitados |
| Teste sem sombras direccionais | Rejeitado |
| Alteração de produção | Nenhuma |
| Decisão visual | REJECTED_VISUAL |

**Evidência basal:** `/home/ubuntu/qa_evidence_dev1_cp245/forest_to_ruins_cp118/forest_to_ruins_36s.png`
