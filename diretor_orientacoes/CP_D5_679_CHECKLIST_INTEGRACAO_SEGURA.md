# CP-D5-679 — Checklist de Integração Segura Gamma

## Finalidade

Este checklist converte a auditoria de fronteiras Gamma num procedimento operacional para qualquer futura promoção de candidatos. A existência de todos os itens não constitui autorização automática de integração; a aprovação deve ser explícita pelos proprietários regionais e pelos revisores responsáveis.

| Verificação | Critério de passagem | Estado |
|---|---|---|
| Contrato espacial | Âncora cartográfica e X/Z preservados | Obrigatório |
| Grounding | Raycast com erro máximo de `0,05 m` | Obrigatório |
| Sequência | R4→R5→R6 e suporte R5→R6 | Obrigatório |
| Visual | Correspondência mínima de 85% ao storyboard | Revisão Dev3 |
| Atmosfera | Fog R4 coerente com transição e escala | Revisão Dev3/Dev6 |
| Água e revelação | Água R6 legível e luz abissal controlada | Revisão Dev3/Dev6 |
| Hardware | Máximo de 16 luzes dinâmicas | Auditoria Dev4 |
| Parser | Godot 4.7.1 sem erros | Auditoria Dev4 |
| Gameplay | Sessão contínua de 30–60 s | Auditoria Dev4/Dev1 |
| Fronteiras | Sem referências indevidas a produção | Dev5/Dev4 |
| Rollback | Commit e candidato reversíveis isoladamente | Dev5 |
| Aprovação | Proprietário regional e revisores confirmam | Obrigatório |

## Procedimento de promoção

Primeiro, executar o preview isolado e preservar o log de parser e a sessão QA. Em seguida, comparar âncoras e telemetria com o contrato Gamma. Depois, solicitar revisão visual, técnica e ambiental. Só após as aprovações deve ser criada uma alteração de integração separada, com rollback explícito e nova regressão do corredor R1–R6.

Até essa promoção, os candidatos permanecem em `levels/dev5/` e a condição `PRODUCTION_MODULES_CHANGED=false` deve continuar verdadeira. O checklist é compatível com o pacote Gamma actualmente publicado e não altera qualquer módulo regional.

**STATUS_CODE: CHECKLIST_READY / SAFE_INTEGRATION / CP-D5-679.**
