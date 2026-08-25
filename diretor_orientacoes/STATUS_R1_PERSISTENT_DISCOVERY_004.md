# STATUS CHECKPOINT — R1 DISCOVERY PERSISTENCE 004

**Branch:** `integration/r1-r6-sprint1`  
**Responsável:** Dev1  
**Data:** 25 de agosto de 2026

## Entrega

A abertura da porta E deixou de ser apenas uma animação local. Ela agora cria o marco narrativo persistente `voss_door_opened`, ativa a consequência `road_to_orion_revealed` no Chronos e publica o evento de mundo com a transição Casa Voss → Estrada do Rio.

| Sistema | Alteração |
|---|---|
| `TimelineManager` | Regista `voss_door_opened`, consequência `road_to_orion_revealed` e passa a participar no grupo `Persist` |
| `VossHouse` | Guarda/restaura `front_door_open`, remove a colisão e folhas da porta depois do carregamento e emite o marco uma única vez |
| `WorldEvents` | Recebe `voss_door_opened` com os IDs e nomes da região atual e do próximo destino |
| `SaveManager` | Foi exercitado no slot QA 2 e o ficheiro temporário foi apagado na mesma sessão |

## Validação

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 — parser headless | PASS |
| Abertura QA da porta E | PASS |
| Evento temporal `voss_door_opened` | PASS |
| Consequência `road_to_orion_revealed` | PASS |
| Evento de mundo `WorldEvents` | PASS |
| Escrita e remoção de save QA | PASS |
| Erro fatal / script na sessão de 14 s | Nenhum |

> Esta entrega não inicia conteúdo da Região 2. O evento apenas torna a transição narrativa explícita e deixa a implementação da Estrada do Rio sob responsabilidade do Dev2.

## Próximo incremento Dev1

Quando Dev2 integrar o primeiro marco da Estrada, Dev1 conecta o destino `road_to_orion_revealed` à primeira pista opcional da rota. Até esse ponto, a Casa Voss permanece como prólogo completo, persistente e independente.
