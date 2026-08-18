# Correcção de Arranque do Pacote — 18 de Agosto de 2026

## Incidente reportado

O vídeo do teste mostrou a interrupção no arranque com a mensagem:

> `Invalid access to property or key 'game_paused' on a base object of type 'Nil'.`

O rastreamento apontou para `res://_autoloads/GameManager.gd` durante a ligação ao sinal `EventBus.game_paused`.

## Causa corrigida

A configuração de autoloads usava referências `uid://` para EventBus, GameManager, SaveManager e outros gestores. Embora o workspace local resolvesse esses UIDs, um projecto recém-extraído pode reconstruir o mapa de UIDs numa ordem diferente; além disso, três UID declarados no ficheiro de projecto não tinham ficheiros `.uid` correspondentes na pasta `_autoloads`.

A configuração foi substituída por caminhos `res://` explícitos e portáveis. QuestManager, InventoryManager e TimelineManager agora apontam para os seus módulos reais em `core/`. O GameManager também passou a procurar EventBus no nó canónico `/root/EventBus`, com fallback de pausa seguro caso a árvore de autoloads esteja temporariamente incompleta.

## Validação de entrega

A validação foi realizada sobre uma cópia nova do projecto, sem `.godot` e sem `.git`, para reproduzir as condições de uma extracção do ZIP. O editor carregou sem erros; o menu abriu; `Novo Jogo` foi activado por teclado; e o mundo permaneceu em execução por 30 segundos sem `game_paused` nulo, erro de script ou falha de recurso. A captura final confirma gameplay no mundo da Casa Voss com o prólogo activo.

## Regra de pacote

Qualquer novo ZIP deverá ser produzido apenas depois da validação numa cópia recém-extraída, com autoloads directos por `res://`, Menu Principal → Novo Jogo e pelo menos 30 segundos de gameplay.
