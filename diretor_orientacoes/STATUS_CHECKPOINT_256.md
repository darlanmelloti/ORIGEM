# Status Checkpoint 256 — Soleira Panorâmica Casa Voss

## Incremento

Foi acrescentada a função `_build_voss_panoramic_threshold()` a `levels/VossHouse.gd`. A saída ganhou seis pedras orgânicas baixas e dois fetos laterais, aterrados pelo relevo local da Casa Voss. A soleira prolonga visualmente o vão da porta até ao eixo físico já existente da Estrada do Rio, sem acrescentar colisores próprios, estreitar a porta `[E]` ou criar degraus que possam prender Elias.

A estrada visível da abertura foi ligada à sequência de construção da Casa Voss. A sua malha acompanha a altura do `TerrainPatch`, enquanto a Estrada do Rio continua a ser a autoridade de percurso a partir de `z=10`.

## Evidências de validação

| Verificação | Resultado | Evidência |
|---|---|---|
| Godot 4.7.1 headless | Aprovado, sem erro de parser, script ou recurso | `qa_evidence_voss_vista/cp256_soleira_headless.log` |
| Novo Jogo + exploração | Aprovado por 30 segundos | `qa_evidence_new_game/walk_30s/` |
| Captura inicial | Aprovada como prova de carregamento do prólogo e horizonte | `antes_movimento.png` |
| Captura após 30 segundos | Aprovada como prova de continuidade física da rota | `depois_30s_movimento.png` |

## Avaliação

A soleira satisfaz o objectivo físico imediato: a porta abre, Elias não fica bloqueado e a transição para a Estrada do Rio permanece contínua. A leitura panorâmica completa dos 12 marcos ainda é uma lacuna de composição partilhada, já atribuída a Dev1, Dev2 e Dev3 pela matriz CP255; este checkpoint não declara essa visão como concluída.

## Próxima tarefa iniciada

**CP 257 — Preparar a borda de revelação Casa Voss–Estrada do Rio:** concentrar a composição na relação ponte/rio/Arco, removendo qualquer leitura de horizonte vazio e mantendo a Casa Voss apenas como moldura lateral. A implementação deve usar os marcos físicos existentes e não pode reintroduzir painéis, planos de fundo ou formas rectangulares provisórias.
