# STATUS CHECKPOINT — R1 INTERACTIVE CLUES 005

**Branch:** `integration/r1-r6-sprint1`  
**Responsável:** Dev1  
**Data:** 25 de agosto de 2026

## Entrega

A Casa Voss passou a ter três pistas opcionais e persistentes, aproveitando objetos já existentes no cenário. O objetivo é dar contexto ao jogador antes de sair da casa, sem converter R1 num tutorial obrigatório nem alterar o conteúdo sob responsabilidade do Dev2.

| Objeto | Revelação inicial | Função narrativa |
|---|---|---|
| Mesa de Tomás | Carta sobre a luz azul, as pedras e o Arco | Justifica a rota pela Estrada do Rio |
| Mapa da Montanha | Percurso Casa Voss → Estrada → Arco → Floresta | Dá orientação espacial sem mini-mapa obrigatório |
| Ferramentas de Miguel | Pó das encostas de Orion e desaparecimento | Introduz o mistério das cavernas |

As três pistas usam o mesmo fluxo de interação já adotado pelo jogador. A primeira leitura é mais detalhada e leituras posteriores usam texto curto. O estado de leitura é salvo pelo `SaveManager` através do grupo `Persist` do controlador `VossHouse`.

## Ficheiros

| Ficheiro | Alteração |
|---|---|
| `levels/VossHouse.gd` | Dados, estado persistente e API de pistas da Casa Voss |
| `scripts/main.gd` | Liga Mesa de Tomás, Mapa da Montanha e Ferramentas de Miguel ao EventBus do jogador |

## Validação

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 — parser headless | PASS |
| QA `ORIGEM_QA_INTERACT=voss_clues` | PASS |
| Mesa de Tomás | PASS — primeira leitura emitida |
| Mapa da Montanha | PASS — primeira leitura emitida |
| Ferramentas de Miguel | PASS — primeira leitura emitida |
| Erro fatal / script na sessão de 12 s | Nenhum |

## Fronteira de equipa

As pistas apontam para a Estrada do Rio e o Arco das Ruínas, mas não criam objetos, NPCs, combates ou objetivos dentro de R2/R3. A geometria e os gatilhos de progressão dessas regiões continuam propriedade de Dev2 e Dev3.
