# Manual Operativo Definitivo: Fronteira Exclusiva Takes 1–10 e Ciclo Contínuo (ORIGEM)

## 1. Alinhamento de Fronteira Estrita (Sem Sobreposição)
Para evitar qualquer duplicação de esforço, a sequência oficial de cenários e mapas do jogo (baseada no roteiro de 10 Takes e 5 Atos) fica rigorosamente dividida entre a equipa:

- **Desenvolvedor Principal (`feature/dev1-gameplay-core`)**:
  - **Âmbito Exclusivo: Takes 1 a 5 (Ato I e Ato II)**
  - *Cenas*: Quarto e sala da Casa Voss, memória com o avô junto à espada e ruínas, o presente interrompido, os visitantes de Majestic (MJ-12), a espada a responder e a porta exterior interativa (`[E] Abrir porta`).
  - *Estado Base*: Checkpoint 114 concluído (`0cb6117`) e pronto para polimento final do prólogo e transição para o vale.

- **Novo Desenvolvedor (`feature/dev2-mountain-canyon`)**:
  - **Âmbito Exclusivo: Takes 6 a 10 (Ato III, Ato IV e Ato V)**
  - *Cenas*: A estrada junto à casa, o arco monumental, a bifurcação da floresta, a ponte de madeira e encosta, a vila elevada e o observatório, a subida final da montanha, a entrada da caverna, a galeria das três eras e a câmara profunda do **Orion Cube**.
  - *Ordem Absoluta*: **O novo desenvolvedor está estritamente proibido de tocar no Take 5 (caverna de entrada).** O seu trabalho arranca diretamente a partir do **Take 6 (Estrada, Arco e Floresta)** em direção ao topo da montanha.

---

## 2. Nova Dinâmica Temporal e de Auditoria Contínua

### A. Cadência do Desenvolvedor (Leitura, Execução e Commit)
- **Leitura da Pasta de Orientação (A cada 10 minutos)**: O programador deve interromper temporariamente a codificação, abrir a pasta partilhada no GitHub (`diretor_orientacoes/`) para verificar se a direção inseriu alguma nova directiva, instrução ou correção de bugs, e alinhar o seu trabalho antes de prosseguir.
- **Ciclo de Execução e Evidências (A cada 30 minutos)**: Cada tarefa executada deve ser validada em **Godot 4.7.1 (Forward+)** com rácio estrito para a **GTX 1050**. Ao concluir ou atingir o marco de 30 minutos:
  1. Executar o teste local (`F5`).
  2. Capturar um **print de alta resolução**.
  3. Gravar um **take de gameplay de aproximadamente 30 segundos** com movimento de câmara.
  4. Fazer o **commit e push imediato** na respetiva branch.
- **Regra de Continuidade Absoluta**: **O programador nunca para.** Se concluir uma tarefa antes de 30 minutos, faz o commit antecipado, lê as orientações na pasta partilhada e **continua imediatamente** para o Take seguinte.

### B. Cadência da Direção (Análise e Feedback)
- **Auditoria a Cada 20 Minutos**: Sempre que houver novas submissões ou commits acessíveis, a direção analisa o código, testa a jogabilidade através do vídeo de gameplay e verifica se o ambiente traduz fielmente a atmosfera cinematográfica e a sequência da história.
- **Direcionamento Cirúrgico**: Se o cenário divergir da referência visual (por exemplo, ecrã preto, geometrias planas ou escala incorreta), a direção emite a correção imediata para o ciclo seguinte.
