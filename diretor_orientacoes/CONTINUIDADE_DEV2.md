# Continuidade — Dev2

- **Último checkpoint auditado:** `CP-D2-201 — Região 12`; não aceite. A evidência passou parser, scope e rota, mas mostrou composição vazia e `35` OmniLights, acima do limite GTX 1050 Ti.
- **Base preservada:** cadeia física R7–R12, handoffs R11/R12 e colisores de travessia são válidos; o Dev2 não reinicia nem altera Regiões 1–6.
- **Próxima tarefa iniciada:** `CP-D2-202 — portal vertical apoiado e orçamento Region12`. O ficheiro proprietário é `levels/Region12TraversalScene.gd` no checkout Dev2 das Regiões 7–12.
- **Primeira alteração material obrigatória:** consolidar/desactivar luzes até `≤16` e criar uma única massa vertical de portal, ancorada na plataforma R12, sem geometria solta nem reenquadramento agressivo.
- **Captura prevista:** 1600×900 a partir da trajectória R11 → Soleira R12 → Hub R12, com o portal a ocupar uma porção vertical legível do enquadramento.
- **Critério de aceitação:** Godot headless, scope guard R7–R12, inventário de luzes `≤16`, 30 segundos de gameplay, captura 1600×900 e commit verificável.
- **Estado:** `CP-D2-202 EM EXECUÇÃO — NÃO AGUARDAR RESPOSTA`.

## Encadeamento obrigatório

1. Se a contagem continuar acima de 16, corrigir o orçamento antes de qualquer polimento adicional.
2. Se a massa vertical não passar a leitura da captura, reverter só essa massa, manter o orçamento e testar uma variante estrutural única.
3. Depois da prova, actualizar este marcador com a alteração concreta e abrir `CP-D2-203` antes do push terminar.
4. Nenhum relatório, ZIP ou “próximo passo definido” substitui alteração material, evidência e commit na branch Dev2.
