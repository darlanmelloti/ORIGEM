# Status Checkpoint 257 — Borda de Revelação Casa Voss–Estrada–Rio–Arco

## Incremento entregue

A borda de revelação recebeu uma ponte de pedra CC0 funcional sobre o primeiro sector visível do Rio da Estrada. A ponte foi colocada fora do eixo da Estrada do Rio, preservando a rota norte Casa Voss → Estrada → Arco, mas tornando a relação transversal entre caminho, água e arqueologia reconhecível desde o sector inicial. Dois pilares baixos de ruína prendem a estrutura às margens sem criar geometria flutuante ou painéis de fundo.

O marco utiliza geometria tridimensional já presente no projecto e recebe uma superfície física própria. Não foram acrescentadas luzes dinâmicas novas. A Casa Voss mantém a soleira orgânica CP256; o Arco continua na coordenada canónica `z=48` e a ponte reforça a leitura do rio antes desse marco.

## Validação

| Verificação | Resultado | Evidência |
|---|---|---|
| Godot 4.7.1 headless | Aprovado sem parser, script ou recurso em falta | `qa_evidence_voss_vista/cp257_ponte_headless.log` |
| Novo Jogo | Aprovado | `qa_evidence_new_game/walk_30s/antes_movimento.png` |
| Exploração contínua | Aprovada durante 30 segundos sem regressão detectada | `qa_evidence_new_game/walk_30s/depois_30s_movimento.png` |
| Memória de validação | Processos Godot/Xvfb residuais removidos após o teste | Ambiente estabilizado após o QA |

## Continuidade obrigatória

O próximo ciclo não aguarda resposta: **CP 258 — Continuidade Arco–Floresta–Acampamento** já está em execução. O foco é confirmar que a saída do Arco lê a Floresta Densa como corredor com profundidade e que o Acampamento Majestic aparece como destino narrativo aberto, sem criar parede vegetal, placas ou colisores no trilho.
