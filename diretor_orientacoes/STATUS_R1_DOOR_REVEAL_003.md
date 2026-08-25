# STATUS CHECKPOINT — R1 PORTA E REVEAL 003

**Branch:** `integration/r1-r6-sprint1`  
**Responsável:** Dev1  
**Data:** 25 de agosto de 2026

## Entrega

A abertura da porta E da Casa Voss passou a ser uma pequena revelação jogável, sem retirar controlo a Elias. O jogador continua a abrir a porta por interação normal; não existe teleporte, novo colisor, parede invisível ou tomada de controlo da câmara.

| Elemento | Comportamento |
|---|---|
| Folhas da porta | Mantêm a animação de abertura existente e removem os colisores da passagem |
| Respiração de câmara | Leve aproximação e retorno ao FOV anterior, apenas se a câmara de Elias estiver ativa |
| Pulso de orientação | Sinal azul breve ao lado do limiar, fora do corredor físico |
| Cartela transitória | Apresenta “Estrada do Rio” e orienta para o Arco das Ruínas a norte |
| Harness QA | `ORIGEM_QA_INTERACT=voss_door` abre a porta e confirma o evento de rota |

## Ficheiros

| Ficheiro | Alteração |
|---|---|
| `levels/regions/r1/VossDoorReveal.gd` | Diretor isolado de cartela, pulso de orientação e FOV breve |
| `levels/VossHouse.gd` | Integra a revelação após a porta iniciar a abertura e expõe o gatilho QA |

## Validação

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 — parser headless | PASS |
| QA `ORIGEM_QA_INTERACT=voss_door` | PASS — `Casa Voss abertura=true rota=EstradaDoRio` |
| Regressões de runtime no teste de 14 s | Nenhum erro de parser, script ou fatal |

## Próximo incremento Dev1

Executar uma passagem visual em GPU do momento de abertura e, se a leitura for aprovada, substituir o sinal de QA por uma captura curta de referência para a equipa. A próxima alteração de gameplay em R1 será apenas uma pista narrativa opcional na Estrada do Rio; a rota continua propriedade do Dev2.
