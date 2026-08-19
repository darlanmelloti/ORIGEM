# CP-D5-048 — Checklist de integração Elias R5/R6

## Finalidade

Esta checklist transforma a matriz CP-D5-047 em passos operacionais para revisão de Dev1. Ela é documental: **não altera `Player.gd`, módulos regionais, câmaras de produção ou colisores de produção**.

| Área | Teste obrigatório | Evidência Dev5 | Aceitação | Reversão |
|---|---|---|---|---|
| Câmara | Confirmar uma única câmara de viewport activa e `follow_camera.current=false` | CP-D5-045 e CP-D5-046 | Câmara QA/produção explicitamente proprietária | Conflito de câmaras ou troca involuntária |
| Identidade | Confirmar `EliasThirdPersonPresentation` e referências tipadas | CP-D5-043 e CP-D5-046 | Nenhum nome ou proxy alternativo em runtime | Reverter qualquer referência ambígua |
| Colisão | Inspeccionar cápsula do actor e colisor do marco antes da integração | CP-D5-041 a CP-D5-043 | Sem penetração, queda ou bloqueio indevido | Remover a integração e restaurar último commit aprovado |
| Percurso R6 | Testar Majestic → margem R6 por pelo menos 30 segundos | CP-D5-042 e CP-D5-043 | Folga mínima de 4,00 m; dois ciclos QA sem bloqueio | Bloqueio, desvio ou folga insuficiente |
| Percurso R5 | Testar floresta → Majestic → margem por pelo menos 30 segundos | CP-D5-043 e contrato R5 | Sem queda, colisão ou perda de trajecto | Reverter a integração R5 sem tocar R6 |
| Grounding | Confirmar raycast e preservação de X/Z canónico | CP-D5-022, CP-D5-023 e CP-D5-041 | Apenas Y é ajustado pelo terreno | Objecto suspenso ou X/Z deslocado |
| Performance | Contar luzes dinâmicas e validar orçamento | CP-D5-040 e CP-D5-046 | Mundo integrado ≤16 luzes dinâmicas | Remover luz sem orçamento |
| Produção | Confirmar proprietário antes de qualquer alteração | CP-D5-044 e matriz CP-D5-047 | Dev1 mantém `Player.gd` e módulos regionais | Bloquear e reverter alteração fora da fronteira |

## Sequência de revisão Dev1

Dev1 deve escolher **uma única rota**, R5 ou R6, e manter a outra como referência QA. Em seguida, deve validar câmara, colisão, grounding, portas, salto, stamina e travessia física por pelo menos 30 segundos. A aceitação requer logs sem erros, coordenadas cartográficas preservadas e orçamento de luzes respeitado. A integração só pode avançar após a revisão explícita do proprietário regional.

> Dev5 entrega candidatos, contratos e evidência. Dev1 decide a integração efectiva no jogador principal e nos módulos de produção.

## Critérios de bloqueio

A integração deve ser bloqueada se surgir conflito de câmara, queda do actor, penetração em colisor, folga inferior a 4,00 m, desvio X/Z, regressão de performance ou qualquer modificação directa não autorizada em `Player.gd`/R1–R6. Nesses casos, a reversão deve restaurar o último commit Dev5 aprovado, sem contornar o teste através de alterações de produção.

## Próxima tarefa

Ao publicar esta checklist, activar CP-D5-049 no mesmo ciclo.
