# Status Checkpoint 258 — Bifurcação Floresta Densa → Acampamento Majestic

## Incremento entregue

Foi criada a `BifurcacaoFisicaParaMajestic` em `levels/ForestLakeRegion.gd`. A nova estela baixa de direcção, acompanhada por três pedras aterradas e um feto, marca o desvio oeste que liga o Trilho da Floresta Densa às lajes físicas do Acampamento Majestic. O marcador está fora do eixo central, não recebe colisor próprio e não acrescenta luzes ao orçamento de GTX 1050 Ti.

A alteração reforça o espelho cartográfico entre os marcos 4 e 5: Floresta Densa permanece como corredor aberto e o Acampamento passa a ter um ponto de leitura física antes da sua massa de tendas, fogueira e estela narrativa.

## Validação

| Verificação | Resultado | Evidência |
|---|---|---|
| Godot 4.7.1 headless | Aprovado sem parser, script ou recurso em falta | `qa_evidence_voss_vista/cp258_majestic_marker_headless.log` |
| Novo Jogo | Aprovado | `qa_evidence_new_game/walk_30s/antes_movimento.png` |
| Exploração contínua | Aprovada durante 30 segundos sem regressão detectada | `qa_evidence_new_game/walk_30s/depois_30s_movimento.png` |
| Orçamento de luzes | Preservado; nenhuma luz dinâmica foi criada | revisão de implementação CP258 |

## Próxima tarefa iniciada

**CP 259 — Leitura da Bacia das Ruínas Submersas:** reforçar o primeiro ponto de vista entre Acampamento Majestic e Ruínas Submersas através de marcos de margem, água e ruína emergente já previstos pela cartografia, sem reduzir a largura do trilho ou alterar áreas Dev2.
