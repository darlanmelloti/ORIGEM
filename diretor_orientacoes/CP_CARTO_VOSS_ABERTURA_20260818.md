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

### Conclusão operacional do CP-CARTO-08

A prova cartográfica Floresta–Ruínas revelou que árvores e fetos da dispersão densa invadiam a última curva do trilho de margem, ocultando a bacia. Foi introduzida uma clareira local, limitada a `z=194–232` e à proximidade da curva `_lake_shore_x`; a densidade restante da floresta e a água não foram alteradas. O limiar arqueológico das Ruínas recebeu dois vestígios verticais maiores e respectivas bases, mantendo-os fora da faixa navegável.

Os modos QA `forest_to_ruins` e `ruins_arrival` permitem inspecção reprodutível em Regiões 1–6 sem carregar módulos das Regiões 7–12. As capturas `cp_carto08_ruins_approach30.png` e `cp_carto08_ruins_tall_silhouette30.png` confirmam 30 segundos de execução sem erro de runtime e uma chegada com clareira, marco arqueológico e margem reconhecíveis. A água foi preservada como elemento lateral escuro: nenhum material, cota ou luz da bacia foi modificado.

| Critério | Resultado |
| --- | --- |
| Última curva do trilho de margem | Clareada de árvores/fetos invasivos |
| Vestígios da entrada da bacia | Silhueta vertical reforçada |
| Colisores da margem e água | Inalterados |
| Luzes dinâmicas | Nenhuma adicionada |
| Gameplay/captura QA | 30 segundos, sem erro de runtime |
| Regiões 7–12 | Sem alteração |

**Próxima tarefa já iniciada — CP-CARTO-09:** consolidar a leitura macro da sequência Casa Voss–Estrada–Arco–Floresta–Majestic–Ruínas através de uma matriz de âncoras, distâncias e evidências, identificando apenas as lacunas físicas ainda abertas para os passes seguintes. O ciclo permanece contínuo.

### Conclusão operacional do CP-CARTO-09

Foi publicada a matriz `MATRIZ_CONTINUIDADE_CARTOGRAFICA_R1_R6_20260818.md`, que consolida as seis âncoras canónicas, as distâncias directas e as últimas evidências de cada transição. A validação cruzada confirmou que todos os ficheiros de captura referidos existem e que o projecto abre em Godot 4.7.1 sem erro de parser ou carregamento de recurso.

O **CP-CARTO-10** fica formalmente iniciado: provar a leitura macro Casa Voss → Estrada do Rio → Arco das Ruínas no mundo normal, sem comprimir a distância nem regressar aos ajustes de material rejeitados. O resultado deve manter o rio lateral, o vale legível e a silhueta do Arco como destino distante.

### Conclusão operacional do CP-CARTO-10

A captura normal de 30 segundos revelou que alguns activos `stone_largeA` da soleira e do enquadramento da Casa Voss ainda usavam o material importado claro, interrompendo a leitura Casa Voss → Estrada do Rio → Arco com pedras de aspecto técnico. Uma sonda temporária identificou as instâncias próximas; a sonda foi removida antes da publicação. As rochas de soleira, detritos de integração, rochas de estrada e afloramentos de primeiro plano passaram a receber o material PBR de pedra já usado pela Casa Voss.

A comparação `cp_carto10_voss_rocks_pbr30.png` comprova a redução das massas claras para rocha escura integrada, mantendo o rio lateral, a estrada, a silhueta do Arco e a distância física. Duas abordagens sem ganho foram revertidas integralmente: omitir a variante diurna legada e retirar a faixa macro de leitura da Casa Voss. Nenhum módulo das Regiões 7–12 foi modificado.

| Critério | Resultado |
| --- | --- |
| Abertura e porta da Casa Voss | Preservadas |
| Rio e hidrologia | Inalterados |
| Lajes, colisores e escala Casa–Arco | Preservados |
| Activos claros não integrados | Corrigidos no PBR local da Casa |
| Instrumentação temporária | Removida |
| Gameplay técnico | 30 segundos, sem erro de runtime |

**Próxima tarefa já iniciada — CP-CARTO-11:** densificar estruturalmente somente as lajes iniciais da Estrada do Rio entre `z=12` e `z=30`, preservando a faixa contínua, o rio lateral e a escala até ao Arco. A comparação deve medir se a rota deixa de se ler como pedras isoladas sem repetir calibrações de material já rejeitadas.

### Conclusão operacional do CP-CARTO-11

A Estrada do Rio mantinha lajes principais a cada aproximadamente 2,92 m entre `z=12` e `z=30`; nessa primeira vista, o trajecto surgia como objectos isolados. Foram acrescentadas sete lajes intermédias, mais estreitas e com comprimento de continuidade, acompanhadas de sete volumes físicos baixos. A alteração é exclusivamente estrutural: não modifica material, faixa de solo compactado, rio, Arco, âncoras nem a escala total até ao marco arqueológico.

A captura `cp_carto11_infill30.png` confirma 30 segundos de gameplay normal sem erro de runtime. A aproximação passou a ler-se como corredor de pedra contínuo na primeira janela Casa Voss → Estrada → Arco, mantendo relva e rio lateral separados. O orçamento adicionou apenas sete colisores no primeiro segmento, sem luz dinâmica nova.

| Critério | Resultado |
| --- | --- |
| Intervalo visual inicial das lajes | Reduzido por sete lajes intermédias |
| Apoio físico | Sete colisores baixos adicionados |
| Rio e margem | Inalterados |
| Distância até ao Arco | Preservada |
| Gameplay normal | 30 segundos, sem erro de runtime |
| Regiões 7–12 | Sem alteração |

**Próxima tarefa já iniciada — CP-CARTO-12:** verificar a leitura de profundidade depois do Arco, entre a silhueta arqueológica e a entrada da Floresta Densa, usando o spawn QA estável sem repetir ajustes de FOV, câmara, água ou materiais rejeitados. O ciclo permanece contínuo.

### Conclusão operacional do CP-CARTO-12

A prova `cp_carto12_arch_forest_retry30.png` executou o spawn técnico estável Arco–Floresta com entrada real durante aproximadamente 30 segundos. O trilho de lajes, as árvores laterais, o sub-bosque e as massas rochosas confirmam a profundidade da transição depois do Arco sem cortar pelo relevo, sem revelar conteúdos das Regiões 7–12 e sem alterar FOV, posição de câmara, água ou materiais.

O levantamento do módulo confirma que os estratos estruturais já existentes cobrem o limiar entre `z=101` e `z=121,5`, enquanto a floresta regional continua a partir desse corredor. Não foi adicionada geometria redundante: a captura mostrou uma entrada aberta e escalonada, não uma parede vegetal. Esta decisão preserva a rota navegável e evita repetir candidatos rejeitados.

| Critério | Resultado |
| --- | --- |
| Travessia pós-Arco | Aprovada no spawn QA estável |
| Entrada da Floresta | Trilho, árvores e sub-bosque legíveis por planos sucessivos |
| Câmara, FOV e água | Sem alteração |
| Regiões 7–12 | Sem alteração |
| Evidência | Gameplay de aproximadamente 30 segundos e captura 960×540 |

**Próxima tarefa já iniciada — CP-CARTO-13:** validar o corredor interno Floresta Densa → Acampamento Majestic com o harness físico existente, concentrando-se em continuidade de lajes, aterramento e leitura do próximo marco sem adicionar nova iluminação nem alterar a bacia das Ruínas.

### Conclusão operacional do CP-CARTO-13

O harness passou a suportar os dois sentidos da ligação real entre o eixo da floresta e o Acampamento Majestic. A nova rota `ORIGEM_QA_ROUTE=forest_to_majestic` nasce no fim da sequência florestal, orienta Elias pelas lajes existentes no sentido de Majestic e limpa a velocidade herdada antes do teleport. A evidência `cp_carto13_forest_to_majestic30.png` confirma aproximadamente 30 segundos de deslocação real sobre a ligação física, sem cortar diagonalmente pelo terreno, sem novas luzes e sem tocar na bacia das Ruínas ou nas Regiões 7–12.

| Critério | Resultado |
| --- | --- |
| Ligação Floresta–Majestic | Percorrida no sentido cartográfico correcto |
| Lajes e apoio físico | Contínuos e estáveis na prova |
| Câmara, luzes e bacia das Ruínas | Sem alteração |
| Harness | Reutilizável nos dois sentidos da mesma rota real |
| Evidência | Gameplay de aproximadamente 30 segundos e captura 960×540 |

**Próxima tarefa já iniciada — CP-CARTO-14:** executar uma auditoria compacta do pacote das Regiões 1–6: confirmar que os modos QA não contaminam o jogo normal, contar o acréscimo de colisores CP-CARTO-11, confirmar o limite de luzes visíveis e preparar o próximo passe visual de activos sem criar nova geometria regional não validada.

### Conclusão operacional do CP-CARTO-14

A auditoria inicial encontrou 60 OmniLights declaradas na árvore procedural, uma contagem incompatível com o orçamento da GTX 1050 Ti se todas permanecessem activas. Foi substituído o corte nominal por um limitador adaptativo: a cada 500 ms, o controlador ordena as OmniLights pela distância a Elias e deixa visíveis apenas as 16 mais próximas; as três luzes secundárias da Casa Voss continuam excluídas. A medição no jogo real, com autoloads e mundo normal activos, devolveu `total_omni=18` e `visible_omni=15`, dentro do limite obrigatório.

A instrumentação de medição e o harness isolado foram removidos antes da publicação. A validação final foi executada por editor headless e por aproximadamente 30 segundos de gameplay normal na Estrada do Rio. A captura `cp_carto14_normal_limited_lights30.png` preserva a rota densificada, o Arco, o rio lateral e a leitura diurna sem erro de runtime.

| Métrica | Resultado |
| --- | --- |
| OmniLights declaradas no levantamento bruto | 60 |
| OmniLights activas no jogo real medido | 15 |
| Limite GTX 1050 Ti | ≤16 |
| Colisores auditados antes do limitador | 251 `CollisionShape3D` |
| Nós QA no jogo normal | 0 |
| Validação final | Editor headless + gameplay normal de aproximadamente 30 segundos |

**Próxima tarefa já iniciada — CP-CARTO-15:** aperfeiçoar a leitura macro da Casa Voss sem alterar a geometria canónica: identificar e corrigir somente activos próximos que ainda se leem como protótipo na tomada de abertura, começando pela silhueta da espada e por qualquer marco de pedra isolado, com comparação antes/depois e sem repetir ajustes de solo, água, FOV ou materiais rejeitados.

### Conclusão operacional do CP-CARTO-15

A silhueta de protótipo no canto inferior da tomada macro foi identificada como a espada de combate de Elias: uma lâmina e uma guarda feitas de duas caixas. A representação foi substituída por quatro volumes 3D leves — lâmina losangular afilada, guarda cilíndrica, cabo e pomo — sem luzes, colisores ou impacto no terreno. A primeira orientação, apontada em profundidade, foi corrigida para o plano da câmara; a captura final `cp_carto15_sword_orientation30.png` mostra uma espada legível, vertical e proporcional, sem ocultar a estrada nem o Arco.

| Critério | Resultado |
| --- | --- |
| Espada rectangular de protótipo | Removida |
| Silhueta nova | Lâmina, guarda, cabo e pomo tridimensionais |
| Orçamento de luzes e colisores | Sem acréscimo |
| Estrada, rio, Arco e FOV | Sem alteração |
| Evidência | Editor headless + gameplay normal de aproximadamente 30 segundos |

**Próxima tarefa já iniciada — CP-CARTO-16:** consolidar a leitura da ponte e do rio no plano médio Casa Voss → Arco, verificando se os elementos laterais comunicam profundidade sem se tornarem uma faixa ou barreira. A correcção, se necessária, será exclusivamente estrutural e fora da rota navegável.

### Conclusão operacional do CP-CARTO-16

A primeira prova de ponte usava o marco legado de coordenada negativa e não era representativa da sequência Casa Voss–Arco. Foi criado o modo QA `positive_bridge`, posicionado no próprio trilho junto de z=51 e orientado para a ponte canónica lateral em z=58. As capturas `cp_carto16_positive_bridge30.png` e `cp_carto16_positive_bridge_center30.png` confirmam a ponte de leitura, os encontros rochosos e o rio como elementos laterais do plano médio, sem ocupar a rota principal e sem criar uma barreira atravessável indevida.

A escala de profundidade foi preservada: por estar fora do eixo principal e distante do jogador, a ponte deve ler-se como uma linha estrutural lateral, não como um novo destino comprimido em primeiro plano. Não foi aplicada alteração de material, largura de água, FOV, terreno, luz ou geometria da ponte; a única adição persistente é a prova QA canónica para regressões futuras.

| Critério | Resultado |
| --- | --- |
| Ponte validada | Eixo positivo canónico, z=58 |
| Rota de Elias | Mantida na Estrada ocidental |
| Rio | Mantido lateral e não obstrutivo |
| Distância macro | Preservada; sem aproximação artificial do marco |
| Evidência | Duas capturas de 30 segundos, incluindo tomada recenterada |

**Próxima tarefa já iniciada — CP-CARTO-17:** inspeccionar a leitura de hierarquia dos marcos Casa Voss, Arco e Floresta a partir do percurso normal, com prioridade em remover apenas objectos próximos que se confundam com marcos cartográficos. Não repetir alterações de água, solo, FOV, densidade de lajes, câmara ou materiais já aceites/rejeitados.

### Conclusão operacional do CP-CARTO-17

A captura normal `cp_carto17_normal30.png` confirma uma hierarquia cartográfica estável a partir da rota inicial: a Estrada do Rio é o eixo imediato e contínuo; o Arco das Ruínas permanece o marco dominante de plano médio; e o agrupamento de árvores posterior estabelece a transição para a Floresta Densa sem converter o corredor numa parede. A espada de Elias aparece como objecto de primeiro plano, mas não intercepta o eixo da estrada ou a silhueta do Arco.

Não foi encontrada uma interferência concreta que justificasse nova alteração. Preservaram-se, portanto, a posição dos marcos, a distância real do vale, o rio lateral, a densidade de lajes, as câmaras e os materiais. O checkpoint é uma aceitação por validação, não uma nova camada decorativa.

| Plano | Leitura validada |
| --- | --- |
| Primeiro plano | Espada e lajes densificadas; caminho imediato claro |
| Plano médio | Arco das Ruínas central e reconhecível |
| Plano posterior | Árvores da Floresta Densa em estratos, sem fechar a rota |
| Profundidade macro | Mantida; sem deslocamento de marcos |

**Próxima tarefa já iniciada — CP-CARTO-18:** validar a continuidade de interacção normal Casa Voss → porta [E] → exterior → Estrada do Rio depois dos passes cartográficos, com 30 segundos de gameplay e sem usar spawns técnicos. O objectivo é confirmar que a composição aperfeiçoada permanece acessível no fluxo de jogador real.

### Conclusão operacional do CP-CARTO-18

Foi validado o ramo normal de restauro pós-prólogo que coloca Elias dentro da Casa Voss e exige a interacção [E] junto à soleira. Durante a prova, a espera cinematográfica foi acelerada apenas no ambiente efémero de captura, sem teleporte exterior, sem modificação de colisores e sem alterar a lógica de porta. A evidência `cp_carto18_door_flow30.png` mostra Elias já no exterior, sobre o eixo da Estrada do Rio e orientado para o Arco, após a interacção [E] e deslocação contínua.

A instrumentação de aceleração foi removida e a validação headless final confirmou que `VossHouse.gd` não mantém alterações transitórias. A porta normal, os seus colisores removidos no momento de abertura e o fluxo do jogador permanecem intactos.

| Critério | Resultado |
| --- | --- |
| Prólogo → controlo de Elias | Executado pelo ramo normal pós-prólogo |
| Interacção [E] | Aplicada junto à porta real |
| Saída exterior | Concluída sem parede residual |
| Continuidade para Estrada | Elias visível sobre as lajes, orientado para o Arco |
| Limpeza | Instrumentação de prova removida antes de publicar |

**Próxima tarefa já iniciada — CP-CARTO-19:** validar a legibilidade da Casa Voss como origem no olhar de retorno a partir da Estrada, preservando a porta, a montanha distante e a hierarquia Casa → Estrada → Arco. Não alterar a casa ou o prólogo sem uma regressão concreta demonstrada.

### Conclusão operacional do CP-CARTO-19

A tomada de retorno `cp_carto19_return30.png` confirma a Casa Voss como marco de origem inequívoco: a fachada e o telhado formam uma silhueta reconhecível no fim da Estrada, a rota de lajes conduz o olhar de volta à porta e a massa arbórea enquadra o edifício sem ocultá-lo. O jogador mantém, portanto, orientação nos dois sentidos: a Casa explica de onde veio; o Arco, a Estrada e a Floresta explicam para onde segue.

Não houve necessidade de alteração de geometria, iluminação, materiais, porta ou escala. A tomada QA `road_return_voss` é a única adição, isolada do jogo normal e reutilizável para detectar regressões de visibilidade da origem.

| Critério | Resultado |
| --- | --- |
| Casa Voss | Silhueta de origem clara e central |
| Estrada de retorno | Legível e fisicamente contínua |
| Vegetação de enquadramento | Periférica; não fecha a fachada |
| Porta e mundo normal | Sem alteração |
| Evidência | Captura de cena de 30 segundos a partir da Estrada real |

**Próxima tarefa já iniciada — CP-CARTO-20:** validar a leitura bidireccional final Casa ↔ Arco com duas tomadas canónicas e preparar o próximo pacote integral das Regiões 1–6, somente depois de nova execução de menu, Novo Jogo e gameplay normal sem erros.

### Conclusão operacional do CP-CARTO-20

As duas tomadas canónicas foram repetidas no estado publicado: `cp_carto20_voss_to_arch30.png` confirma Estrada contínua e Arco como destino frontal; `cp_carto20_return_to_voss30.png` confirma a Casa Voss como origem no sentido inverso. A validação de fluxo normal também foi concluída: a sequência Menu → Novo Jogo → manter [E] durante a inicialização do prólogo → controlo de Elias → deslocação por W foi executada sem variáveis QA; a captura `cp_carto20_normal_menu_hold_e30.png` mostra Elias em gameplay sobre a Estrada, com HUD activo e Arco legível.

O verificador `QA-PACKAGE-01` criou e extraiu um ZIP limpo, passou o editor headless e passou Menu/Novo Jogo durante 30 segundos. O SHA-256 exacto do ZIP distribuível é guardado separadamente em `qa_evidence_voss_vista/cp_carto20_final_package.sha256`, para que o marcador de continuidade não associe um hash intermédio a um commit posterior.

| Prova | Resultado |
| --- | --- |
| Casa → Arco | Estrada, Arco e transição de árvores legíveis |
| Estrada → Casa | Casa Voss e estrada de retorno legíveis |
| Menu → Novo Jogo → gameplay | Aprovado, 30 s, sem modo QA |
| Pacote extraído | Aprovado por QA-PACKAGE-01 |
| Log de validação | `qa_evidence_voss_vista/cp_carto20_package_verify.log` |

**Próxima tarefa já iniciada — CP-CARTO-21:** auditoria visual de marcos em distâncias macro no vale, priorizando apenas uma lacuna objectiva por ciclo e mantendo a escala cartográfica real. O pacote final desta revisão só será distribuído quando o hash do ZIP do commit publicado for registado.

### Conclusão operacional do CP-CARTO-21

A auditoria macro foi publicada em `CP_CARTO21_AUDITORIA_MACRO_E_HANDOFF_20260818.md`. As tomadas canónicas confirmam que a cadeia **Casa Voss → Estrada → Arco → Floresta** está legível nos planos próprios, mas também confirmam que Majestic, Ruínas e as Regiões 7–12 não podem ser apresentados como marcos distintos na tomada inicial sem reduzir artificialmente as distâncias. Essa lacuna deve ser resolvida pela integração de geometria real dos respectivos proprietários, nunca por painéis, teleporte de marcos ou compressão do vale.

Foi testado um mastro tridimensional de expedição no Acampamento Majestic, sem colisão e sem luz dinâmica. A comparação `cp_carto22_forest_majestic_base30.png` / `cp_carto22_forest_majestic_mast_tall30.png` não mostrou ganho perceptível na tomada canónica, pois a massa permanece ocultada pela topografia e vegetação reais. A variante foi revertida integralmente antes do checkpoint. O script regional voltou ao estado funcional e a validação headless final passou.

| Critério | Resultado |
| --- | --- |
| Hierarquia Casa → Arco | Mantida e validada |
| Escala real do vale | Preservada; nenhum marco foi aproximado |
| Mastro Majestic experimental | Revertido — sem ganho visual perceptível |
| Água, câmaras, FOV, lajes e Regiões 7–12 | Sem alteração |
| Parser Godot após reversão | Aprovado |

**Próxima tarefa já iniciada — CP-CARTO-22:** validar a linha de visão e a passagem física entre a saída do Arco, a Floresta Densa e a bifurcação real para Majestic; remover apenas uma obstrução que seja comprovada por evidência. O Dev2 recebe, em paralelo, a ordem de integrar massas reais das Regiões 7–12 nas âncoras canónicas para que a futura tomada macro possa revelar o vale completo sem falsificar a escala.
