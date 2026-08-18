# Checklist Pareada Dev4–Dev2 — Integração R6→R7

**Estado:** pronta para execução quando o Dev2 publicar a subida R7 reconciliada.  
**Fronteira:** Dev1 mantém exclusivamente as Regiões 1–6; Dev2 mantém exclusivamente as Regiões 7–12. Esta checklist não autoriza qualquer alteração directa de geometria da Região 7 pelo Dev1 ou Dev4.

## Entrada obrigatória do Dev2

| Evidência | Critério de entrada |
| --- | --- |
| Commit ou bundle Dev2 | Deve conter a subida física R7 a partir da margem R6 e não reescrever o histórico publicado. |
| Scope guard | Deve confirmar alterações apenas nas Regiões 7–12. |
| Captura 1600×900 | Deve mostrar trilha, entrada R7 e destino posterior sem marcador QA visível. |
| Gameplay | Deve demonstrar pelo menos 30 segundos de deslocação real sem queda, bloqueio ou portal vazio. |

## Execução contínua do Dev4

1. Actualizar referências sem `force-push` e criar uma branch de integração a partir da ponta Dev2.
2. Carregar o mundo integrado apenas para QA, sem modificar módulos regionais de produção.
3. Executar a travessia R6→R7 com a mesma posição de saída aprovada na margem das Ruínas.
4. Medir luzes Omni visíveis, colisores e erros de runtime; o limite é **16 luzes dinâmicas visíveis**.
5. Se houver falha, devolver ao Dev2 uma ordem objectiva com posição, activo, captura e critério de aceitação. O Dev4 não abre um DIR autónomo enquanto a falha estiver aberta.
6. Após a correcção Dev2, recapturar exactamente a mesma tomada e repetir gameplay de 30 segundos.

## Critério de aceitação

A integração passa apenas quando a margem R6, a primeira subida R7 e o próximo marco se leem como um único corredor tridimensional, fisicamente transitável, com profundidade real e sem compressão do mapa cartográfico.

> Um relatório, captura ou commit nunca encerra a fila. Cada validação concluída abre a primeira lacuna observável seguinte no marcador `CONTINUIDADE_DEV4.md` ou no documento de entrega Dev2 correspondente.

## Próxima acção automática

Quando o Dev2 publicar CP-D2-214, iniciar a branch de integração e a prova R6→R7 antes de qualquer auditoria transversal nova.

---

**Autor:** Equipa ORIGEM — coordenação Dev1/Dev4  
**Data:** 18 de agosto de 2026
