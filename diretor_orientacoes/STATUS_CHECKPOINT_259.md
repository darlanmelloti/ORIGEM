# Status Checkpoint 259 — Limiar das Ruínas Submersas

## Incremento entregue

Foi adicionado o `LimiarDasRuinasSubmersas` à aproximação física da Bacia. Dois vestígios de pilar, com bases rochosas irregulares e vegetação baixa, enquadram a primeira leitura do lago no fim do trilho vindo do Acampamento Majestic. A abertura central mantém-se livre: as lajes e os seus colisores continuam a ser a única passagem autorizada até à margem ocidental.

O incremento reforça o marco 6 no espelho do mapa através de geometria real, água já existente e ruínas emergentes. Não foram criados painéis, atalhos visuais, colisores novos na rota nem luzes dinâmicas adicionais.

## Validação

| Verificação | Resultado | Evidência |
|---|---|---|
| Godot 4.7.1 headless | Aprovado sem parser, script ou recurso em falta | `qa_evidence_voss_vista/cp259_bacia_headless.log` |
| Novo Jogo | Aprovado | `qa_evidence_new_game/walk_30s/antes_movimento.png` |
| Exploração contínua | Aprovada durante 30 segundos sem regressão detectada | `qa_evidence_new_game/walk_30s/depois_30s_movimento.png` |
| Orçamento de luzes | Preservado; nenhuma luz dinâmica foi criada | revisão de implementação CP259 |

## Próxima tarefa iniciada

**CP 260 — Enquadramento da Bacia para a futura Vila Elevada:** auditar e fortalecer a última leitura Dev1 da margem e do portão de handoff Região 6 → 7, preservando a fronteira que impede Dev1 de alterar módulos das Regiões 7–12.
