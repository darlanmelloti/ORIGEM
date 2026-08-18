# CP-CARTO — Abertura da Casa Voss e Leitura do Vale

## Objectivo

Reduzir a obstrução visual artificial na primeira leitura do vale, preservando a saída física da Casa Voss, a escala cartográfica real e a cadeia espacial **Casa Voss → Estrada do Rio → Arco das Ruínas**.

## Alteração aprovada

O `TerracoDeRevelacaoDaCasaVoss` e os degraus associados eram exclusivamente visuais, não suportavam a deslocação de Elias e introduziam uma massa rectangular cinzenta na soleira. A chamada de construção do miradouro foi removida. A porta, o terreno exterior e o corredor de saída não foram alterados.

A captura sem o miradouro mostrou uma soleira mais aberta: as lajes do percurso, a margem e a silhueta distante do Arco permanecem visíveis sem a plataforma rectangular a competir com a Casa Voss.

## Validação

| Verificação | Resultado |
| --- | --- |
| Godot 4.7.1, validação headless | Aprovada |
| Novo Jogo e sessão de 30 segundos | Aprovados sem erros de runtime |
| Porta `E` e rota exterior | Mantidas pela correcção física anterior |
| Luzes dinâmicas | Sem novas luzes |
| Fronteira regional | Alteração limitada à Casa Voss / Região 1 |

Evidência: `qa_evidence_voss_vista/cp_cartographic_voss_open_30s.png`.

## Candidatos rejeitados

A calibração de altura, escurecimento e variante sem iluminação directa do material de água não melhorou a leitura do curso; a última variante introduziu um brilho ciano artificial. Todas foram revertidas. O próximo ciclo deve tratar um marco físico de profundidade, não repetir os ajustes do shader hídrico.

## Próxima tarefa já iniciada

**CP-CARTO-02 — Arco das Ruínas:** medir a silhueta arqueológica no horizonte da saída Casa Voss e reforçar apenas a sua massa tridimensional apoiada, sem aproximar o marco nem invadir as Regiões 4–12.

## CP-CARTO-02 — Arco das Ruínas

A captura válida após `ORIGEM_QA_SKIP_OPENING=1` confirmou que o Arco já se lê como marco vertical a partir da Estrada. O contraforte lateral real foi **revertido**: não alterou a silhueta percepcionada à distância e acrescentaria detalhe sem benefício claro.

Evidência: `qa_evidence_voss_vista/cp_carto02_arch_buttress_qa_skip.png`.

### Próxima tarefa já iniciada

**CP-CARTO-03 — Continuidade Casa Voss–Estrada:** substituir a leitura fragmentada de lajes isoladas por uma ligação de solo contínua, mantendo a estrada e o rio separados, sem criar nova luz e sem alterar a distância física até ao Arco.

## CP-CARTO-03 — Continuidade Casa Voss–Estrada

A revisão estrutural confirmou que a faixa já existe como malha contínua de 4,15 m, mas a elevação discreta acima do terreno e a redução de contraste das lajes **não alteraram a leitura** na captura de 30 segundos. O enquadramento continuou a ler a rota como pedras individuais sobre solo indistinto. A variante foi revertida integralmente: não há mudança de material, altura, colisores, hidrologia ou luzes publicada.

| Verificação | Resultado |
| --- | --- |
| Godot 4.7.1, validação headless | Aprovada |
| Novo Jogo + percurso contínuo de 30 segundos | Aprovados sem erro de runtime |
| Faixa elevada e lajes com contraste reduzido | Rejeitada — ganho visual não perceptível |
| Rio, colisores e distância até ao Arco | Preservados |
| Luzes dinâmicas acrescentadas | 0 |

Evidências: `qa_evidence_voss_vista/cp_carto03_roadbed_headless.log`, `qa_evidence_voss_vista/cp_carto03_roadbed_30s.log` e `qa_evidence_voss_vista/cp_carto03_roadbed_30s.png`.

### Próxima tarefa já iniciada

**CP-CARTO-04 — Profundidade Arco–Floresta Densa:** verificar, a partir da rota física depois do Arco, se a entrada na Região 4 é lida como corredor tridimensional contínuo. O passe limita-se a observação e, apenas se a cadeia estiver ilegível, a uma correcção estrutural apoiada no terreno; não deve repetir as calibrações de material, elevação de faixa, água ou escala das lajes rejeitadas.

## CP-CARTO-04 — Profundidade Arco–Floresta Densa

Foi criado o modo técnico `ORIGEM_QA_ROUTE=arch_to_forest` em `TempleLevel.gd`. O modo coloca Elias em `(-9, y, 107)`, virado para o marco cartográfico da **Floresta Densa** em `(-9, 116)`, e não altera o arranque nem o percurso normal. Quando esse modo é usado, o mundo de QA limita-se às Regiões 1–6; as Regiões 7–12 permanecem intactas e continuam a ser carregadas em qualquer sessão normal.

A validação headless confirmou o spawn e não detectou erros de parser, recursos ou runtime. A captura gráfica no llvmpipe continua limitada pela construção procedural da cena antes de o temporizador de 30 segundos do sandbox completar; esta limitação não é assumida como prova visual. O próximo passe permanece **em execução**: reduzir o custo de inicialização somente no modo QA, sem remover geometria de produção, até produzir a captura física do limiar Arco–Floresta.

| Verificação | Estado |
| --- | --- |
| Godot 4.7.1 headless | Aprovado |
| Spawn `arch_to_forest` em runtime headless | Aprovado |
| Regiões 7–12 em jogo normal | Não alteradas |
| Captura visual do limiar no llvmpipe | Em execução — aquecimento excede a janela útil |

Evidências: `qa_evidence_voss_vista/cp_carto04_arch_forest_headless.log`, `qa_evidence_voss_vista/cp_carto04_arch_forest_headless_runtime.log` e `qa_evidence_voss_vista/cp_carto04_arch_forest_stable30.png`.

### Conclusão operacional do CP-CARTO-04

A prova foi concluída no mundo integrado das Regiões 1–6. O modo `ORIGEM_QA_ROUTE=arch_to_forest` agora agenda o spawn no primeiro frame disponível depois de a região existir, elimina a velocidade interna acumulada de Elias e limita o mundo de QA às Regiões 1–6. Nenhuma dessas condições é activada no jogo normal.

A estabilidade física foi reforçada em duas camadas: `Player.gd` limita passos físicos excepcionalmente grandes no renderizador de compatibilidade e `TerrainPatch.gd` mantém uma malha visual inalterada, uma malha de colisão dedicada e recuperação discreta apenas se a cápsula ficar abaixo do relevo analítico. A captura **`cp_carto04_arch_forest_immediate_walk30.png`** comprova Elias apoiado no terreno ao avançar pelo limiar Arco–Floresta; a stamina permanece cheia, sem erro de runtime. A captura normal **`cp_carto04_normal_after_physics30.png`** confirma que a Estrada do Rio, o Arco e a imagem aprovada da Casa Voss não sofreram regressão durante 30 segundos.

| Critério | Resultado |
| --- | --- |
| Parser Godot 4.7.1 | Aprovado |
| Mundo normal Casa Voss–Arco | Aprovado em 30 segundos |
| Spawn técnico Arco–Floresta | Aprovado |
| Travessia física no limiar | Aprovado |
| Regiões 7–12 | Sem alterações de produção |
| Orçamento de luzes | Sem novas luzes dinâmicas |

**Próxima tarefa já iniciada — CP-CARTO-05:** corrigir a leitura visual do limiar Arco–Floresta sem mudar a câmara nem a geografia: identificar e remover a lâmina ciano plana periférica, reduzir a repetição imediata de lajes e preservar a profundidade criada por árvores, contrafortes e trilho físico. A evidência do CP-CARTO-04 não encerra o ciclo.

### Conclusão operacional do CP-CARTO-05

A lâmina periférica observada no limiar Arco–Floresta foi identificada como uma falha estrutural do `RiverRoadJourney.gd`: um triângulo da água reutilizava o bordo `x0` no segmento seguinte. A malha passou a usar quatro vértices coerentes por segmento. Como reforço de profundidade, o leito do rio afunila gradualmente entre `z=82` e `z=112`, de 14,0 m para 3,8 m, e três agrupamentos ribeirinhos reais foram introduzidos na margem oeste. Não foi alterado o material da água, a cota da água, a câmara, o eixo do trilho, o Arco ou as Regiões 7–12.

A captura `cp_carto05_arch_forest_narrow_river30.png` mostra a água mantida como elemento lateral subordinado; o trilho de lajes, os contrafortes e as árvores passam a conduzir a leitura para a Floresta. A captura normal `cp_carto05_normal30.png` comprova que a composição Casa Voss–Estrada–Arco permanece estável durante 30 segundos.

| Critério | Resultado |
| --- | --- |
| Malha do Rio da Estrada | Corrigida, sem triângulo diagonal |
| Lâmina ciano no limiar | Reduzida a leitura lateral de rio, sem competir com o trilho |
| Travessia Arco–Floresta | Aprovada em 30 segundos |
| Jogo normal Casa Voss–Arco | Aprovado em 30 segundos |
| Câmaras e âncoras cartográficas | Inalteradas |
| Regiões 7–12 | Sem alteração |

**Próxima tarefa já iniciada — CP-CARTO-06:** aprofundar a leitura de entrada da Floresta Densa por estratos reais de vegetação baixa e rocha, sem criar parede de árvores, sem reduzir a largura do trilho e sem mexer na água ou no raccord de câmara. O desenvolvimento permanece contínuo.

### Conclusão operacional do CP-CARTO-06

A entrada Arco–Floresta recebeu um estrato contínuo, mas não linear, de seis núcleos reais de feto e rocha entre `z=104` e `z=121,5`. Todos permanecem fora de 3,40 m do eixo do trilho, sem colisores e sem novas luzes. A escala dos fetos foi reforçada apenas depois da primeira captura ter mostrado ganho insuficiente; a segunda prova mantém o corredor aberto, aumenta a leitura de solo vivo e evita a formação de uma parede vegetal.

As provas `cp_carto06_arch_forest_understory_scale30.png` e `cp_carto06_normal30.png` confirmam Godot 4.7.1 sem erros de runtime, 30 segundos de travessia no limiar e 30 segundos de jogo normal sem regressão entre Casa Voss, Estrada do Rio e Arco.

| Critério | Resultado |
| --- | --- |
| Estrato de feto/rocha no limiar | Aprovado; seis agrupamentos irregulares |
| Corredor navegável | Preservado; sem colisores novos |
| Parede de árvores | Não criada |
| Luzes dinâmicas | Nenhuma adicionada |
| Jogo normal Casa Voss–Arco | Aprovado em 30 segundos |
| Regiões 7–12 | Sem alteração |

**Próxima tarefa já iniciada — CP-CARTO-07:** verificar a leitura do Acampamento Majestic e da chegada às Ruínas Submersas como sequência espacial única. O passe deve privilegiar silhuetas, margem e continuidade física, sem alterar os módulos das Regiões 7–12.

### Conclusão operacional do CP-CARTO-07

A auditoria da sequência Majestic–Ruínas encontrou uma descontinuidade material no conector do Acampamento Majestic: 29 lajes separadas por cerca de 2,7 m excediam a cobertura de 2,18 m dos respectivos colisores. O conector passou a usar 41 lajes; a separação longitudinal fica agora abaixo da largura dos colisores, criando uma faixa física ininterrupta desde `(-78, 178)` até ao eixo florestal `x≈-2,5`.

O harness `majestic_to_lake` foi acelerado sem alterar o jogo normal: carrega somente Regiões 1–6, reinicia a velocidade de Elias antes do teleport e orienta a primeira perna para a ligação real ao trilho. A sonda temporária foi removida antes da publicação. A validação técnica passou em Godot 4.7.1; a entrada W foi recebida, Elias encontrava-se apoiado e começou a mover-se no sentido positivo de X. O ritmo reduzido observado é limitado ao `llvmpipe` do sandbox, não a um bloqueio de colisão.

| Critério | Resultado |
| --- | --- |
| Conector Majestic–trilho | Densificado de 29 para 41 lajes |
| Cobertura de colisores | Contínua no eixo longitudinal |
| Queda no spawn técnico | Corrigida com reposição de velocidade |
| Gameplay de prova | 30 segundos com W, sem erro de runtime |
| Água, lago e câmaras | Inalterados |
| Regiões 7–12 | Sem alteração |

**Próxima tarefa já iniciada — CP-CARTO-08:** validar a aproximação final às Ruínas Submersas a partir do trilho de floresta, priorizando a silhueta de chegada e a legibilidade da margem, sem repor ou alterar a água e sem introduzir obstáculos na rota.
