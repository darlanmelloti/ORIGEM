# Auditoria Independente — CP-D2-201, Região 12

## Decisão

O pacote `CP-D2-201-R12-continuity.zip` não é aceite como checkpoint concluído. A própria captura 1600×900 confirma a rejeição estética: mostra uma plataforma plana, massa mineral dispersa e muito espaço vazio, sem a presença vertical ou a leitura de portal necessária para a Câmara do Cubo.

A auditoria também encontrou uma não conformidade técnica que o relatório não declarou. O log de gameplay declara `REGION12_RENDER_INVENTORY meshes=101 omni_lights=35`, acima do limite de **16 luzes dinâmicas visíveis** definido para o alvo GTX 1050 Ti. Assim, o CP-D2-201 não pode ser descrito como validado, ainda que o parser, a rota e o scope guard tenham passado.

| Dimensão | Evidência auditada | Decisão |
| --- | --- | --- |
| Scope Regiões 7–12 | O pacote contém `Region12TraversalScene.gd` e guard dedicado | Conforme, manter fronteira Dev1 |
| Rota e colisores | Handoffs e colisores R11/R12 presentes no log | Manter como base |
| Luzes dinâmicas | 35 `OmniLight3D` no inventário Region12 | Rejeitado; reduzir para no máximo 16 |
| Composição do portal | Captura 1600×900 vazia, baixa e sem massa vertical apoiada | Rejeitado; criar uma única massa vertical ancorada |
| Evidência 30 segundos | Vídeo e log presentes | Válido como diagnóstico, não como aceitação |

## CP-D2-202 obrigatório

Dev2 deve iniciar o CP-D2-202 sem aguardar resposta. A primeira alteração é dupla e controlada: consolidar ou desactivar luzes até ao limite de 16 e criar uma única massa vertical de portal apoiada na plataforma R12. Não é permitido voltar a reenquadrar agressivamente, preencher o vazio com geometria solta, tocar nas Regiões 1–6, ou declarar a tarefa concluída sem evidência de contagem de luzes, captura 1600×900 e 30 segundos de gameplay.

O próximo marcador só pode indicar `EM EXECUÇÃO` se incluir o ficheiro que Dev2 irá alterar, a contagem de luzes antes/depois e a posição de captura prevista.
