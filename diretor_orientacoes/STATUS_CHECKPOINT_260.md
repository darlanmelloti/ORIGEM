# Status Checkpoint 260 — Vista da Bacia para a Vila Elevada

## Incremento entregue

A última vista Dev1 da Bacia recebeu dois vestígios laterais de ruína antes do limite técnico da Região 7. As peças mantêm o eixo central `x=140` livre, enquadram a subida para o portão e reforçam que a Vila Elevada é a continuação espacial prevista no mapa oficial. Toda a geometria nova está em `z<285`, portanto permanece na responsabilidade Dev1 e não altera módulos, câmaras ou conteúdos das Regiões 7–12.

## Validação

| Verificação | Resultado | Evidência |
|---|---|---|
| Godot 4.7.1 headless | Aprovado sem parser, script ou recurso em falta | `qa_evidence_voss_vista/cp260_handoff_headless.log` |
| Novo Jogo | Aprovado | `qa_evidence_new_game/walk_30s/antes_movimento.png` |
| Exploração contínua | Aprovada durante 30 segundos sem regressão detectada | `qa_evidence_new_game/walk_30s/depois_30s_movimento.png` |
| Fronteira Dev1/Dev2 | Preservada; novos vestígios em `z<285` | auditoria CP260 |

## Próxima tarefa iniciada

**CP 261 — Auditoria integrada Casa Voss → Portão da Vila:** consolidar as âncoras 1–6, os pontos de orientação e as evidências de continuidade para preparar a recaptura cinematográfica Dev3 sem alterar a Região 7.
