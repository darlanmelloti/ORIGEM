# DIR-118 — Transição e Legibilidade do Marco Seguinte

## Objectivo activo

Auditar a leitura da transição da Bacia das Ruínas Submersas para o portão de handoff da Vila Elevada, sem alterar módulos das Regiões 7–12. Este documento é a evidência material de início do DIR-118; não é um relatório de encerramento.

## Grelha inicial de transição

| Elemento | Âncora de saída | Âncora de chegada | Proprietário | Evidência disponível | Verificação de retorno |
|---|---|---|---|---|---|
| Bacia das Ruínas Submersas | `RUINAS_SUBMERSAS`, Região 6 | trilho Dev1 antes de `VILA_ELEVADA` | Dev1 | CP259: limiar com vestígios emergentes; CP260: vista de handoff | Repetir a rota no próximo QA de handoff e confirmar que o eixo central está livre. |
| Portão de handoff | limite `z<285`, Região 6 | spawn Dev2 em `VILA_ELEVADA` | Dev1 para o lado sul; Dev2 para o lado norte | CP260: estelas e vestígios laterais Dev1; contrato cartográfico existente | Dev2 valida a continuidade 7→9 e devolve captura 16:9. |
| Vila Elevada | porta de entrada no portão | marco 7 do mapa | Dev2 | módulo `HighlandRegion.gd` e ordem CP-D2-006 publicados | Dev3 recaptura 0C com a mesma lente depois de integração publicada. |

## Acção de auditoria já iniciada

Dev4 acompanha a prova por clique de 30 segundos corrigida no CP261 e verifica que a primeira vista entra no mundo, não no menu. Dev1 executa CP262 para Casa–Estrada–Arco; Dev2 mantém CP-D2-006 para a leitura panorâmica 7→9; Dev3 executa Takes 1–3 enquanto conserva a recaptura 0C pronta.

> **Próxima verificação já agendada:** depois da próxima alteração Dev1 ou Dev2, comparar a mesma lente Dev3 contra o Passe 0B e actualizar esta grelha com o primeiro marco que se tornar reconhecível.
