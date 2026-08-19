# ORIGEM — Relatório de Conhecimento Partilhado para Desenvolvimento Contínuo

**Versão:** 1.0  
**Data:** 19 de agosto de 2026  
**Finalidade:** onboarding técnico, artístico e operacional de todos os colaboradores do ORIGEM.  
**Autoridade espacial:** mapa cartográfico oficial `MAP.webp`.  
**Autoridade de continuidade:** `diretor_orientacoes/CONTINUIDADE_*.md` e os checkpoints publicados.

> **Princípio fundador:** o mapa cartográfico não é decoração nem minimapa; é a autoridade espacial do mundo real. Cada marco deve conservar posição relativa, distância, direcção de chegada, leitura no horizonte e ligação física jogável.

---

## 1. O que estamos a construir

ORIGEM é um RPG de acção em Godot 4.7.1 com combate de espada, exploração em terceira pessoa a médio prazo, progressão narrativa e viagem temporal. A referência de ambição é um mundo de fantasia aberto, denso e legível, no qual a descoberta decorre da geografia e não de indicadores artificiais.

O projecto começou como um protótipo procedural de temple/vale e evoluiu para um corredor regional cartografado. A principal aprendizagem é que a qualidade não depende de adicionar objectos isolados: depende de transformar **distância, topologia, massa, rotas e marcos** em relações consistentes entre mapa, gameplay e câmara. Um arco, uma casa ou uma montanha só têm valor quando ajudam o jogador a compreender onde está, para onde vai e o que existe além do horizonte.

| Pilar | Regra de implementação | Consequência prática |
|---|---|---|
| Cartografia | O mapa oficial é a fonte de verdade | Não aproximar marcos apenas para caber no take |
| Mundo real | Sem outdoors ou painéis para resolver profundidade | Usar geometria, silhuetas, terreno e camadas reais |
| Jogabilidade | Toda rota importante tem de ser fisicamente percorrível | Validar colisão, chão, porta, salto e stamina |
| Direcção artística | Realismo orgânico, não greybox prolongado | Evitar caixas/cilindros visíveis como solução final |
| Desempenho | Alvo: GTX 1050 Ti | Máximo de 16 luzes dinâmicas simultâneas |
| Qualidade | Evidência antes de promoção | Parser + 30 s/36 s de gameplay + captura + avaliação |

---

## 2. Mapa cartográfico e fronteiras de trabalho

A topologia do jogo está dividida em doze marcos. As Regiões 1–6 pertencem ao mundo cinematográfico/base; as Regiões 7–12 pertencem à frente de montanha. Nenhum colaborador deve interpretar um take cinematográfico como permissão para editar fora da sua fronteira espacial. [1] [2]

| Região | Marco no mapa | Âncora canónica (X, Z) | Frente proprietária | Leitura obrigatória |
|---:|---|---|---|---|
| 1 | Casa Voss | (-22, 8) | Dev1 / cinematográfica | origem, interior, porta E, saída para o vale |
| 2 | Estrada do Rio | (-21,4, 12) | Dev1 / cinematográfica | corredor físico e direcção norte |
| 3 | Arco das Ruínas | (-16,741, 48) | Dev1 / cinematográfica | marco arqueológico no fim do eixo de lajes |
| 4 | Floresta Densa | (-9, 116) | Dev1 / cinematográfica | profundidade lateral sem parede de árvores |
| 5 | Acampamento Majestic | (-88, 178) | Dev1 / cinematográfica | desvio ocidental e massa de campamento |
| 6 | Ruínas Submersas | (60, 252) | Dev1 / cinematográfica | bacia, ruínas, chegada e transição futura |
| 7 | Vila Elevada | Dev2 | Dev2 | entrada física após R6 |
| 8 | Observatório | Dev2 | Dev2 | centro elevado/visível em profundidade |
| 9 | Trilha da Montanha | Dev2 | Dev2 | subida física ao maciço |
| 10 | Caverna do Orion | Dev2 | Dev2 | boca de caverna legível |
| 11 | Câmara do Orion Cube | Dev2 | Dev2 | destino de câmara/cubo |
| 12 | Hub Temporal | Dev2 | Dev2 | nó terminal temporal |

A escala de produção não é uma cópia literal de pixels do mapa. O Arco, por exemplo, tem âncora cartográfica em Z=48, mas alvo físico projectado em aproximadamente Z=92. Esta projecção é válida porque preserva direcção, separação e leitura macro. Alterar esse número sem uma prova de regressão quebra o eixo Casa Voss → Estrada → Arco. [2]

---

## 3. Arquitectura Godot que todos devem conhecer

O projecto usa **Godot 4.7.1** com renderizador OpenGL Compatibility no ambiente de validação. O modo Forward+ é instável em llvmpipe; não usar um resultado exclusivo de Forward+ como prova de que uma alteração funciona no pacote base. O jogador actual é `entities/player/Player.gd`; o nome correcto e único do protagonista é **Elias**. A apresentação de Elias em terceira pessoa na Dev5 é, por enquanto, uma fundação QA isolada e não substitui o jogador principal nem autoriza alterações em `Player.gd` sem revisão. [2]

| Módulo | Responsabilidade | Regra de alteração |
|---|---|---|
| `levels/CartographicAnchors.gd` | âncoras, orientação X/Z e estados de destino | alterar somente com prova cartográfica |
| `levels/TempleLevel.gd` | orquestração do mundo e harnesses QA | não deixar sondas QA permanentes sem documentar |
| `levels/VossHouse.gd` | Casa Voss, prólogo e porta | validar abertura E e saída exterior |
| `levels/RiverRoadJourney.gd` | Casa/Estrada/Arco e corredor do rio | preservar Arco físico em Z≈92 |
| `levels/ForestLakeRegion.gd` | Floresta, Majestic e Ruínas | proprietário R4–R6; não tocar R7+ |
| `levels/TerrainPatch.gd` | relevo e colisão regional | nunca alterar altura/água sem causa isolada |
| `ui/menus/CartographicMapUI.gd` | mapa UI e destino actual | tem de consumir a mesma regra X/Z do mundo |
| `levels/dev5/` | candidatos, auditorias e cenas QA isoladas | não é produção; integração só após revisão Dev1 |

### Harnesses QA reconhecidos

Use apenas rotas implementadas no orquestrador. Nomes inventados geram evidência inválida. As rotas já confirmadas incluem `road_to_arch`, `arch_to_forest`, `forest_to_majestic`, `majestic_to_lake`, `ruins_arrival`, `forest_to_ruins` e `road_return_voss`. O ambiente usa `ORIGEM_QA_AUTOSTART_NEW_GAME=1`, `ORIGEM_QA_SKIP_OPENING=1` e `ORIGEM_QA_ROUTE=<rota>` quando apropriado. [2]

---

## 4. Método de validação: não promover sem evidência

A regra de qualidade mais importante do ORIGEM é simples: **uma ideia não é uma melhoria porque foi programada; só é melhoria se uma evidência comparável a demonstrar.** Cada alteração aceita passa por validação técnica, uma sessão de gameplay real de pelo menos 30 segundos (normalmente 36) e captura interna/viewport quando o Xvfb mostrar apenas o splash.

| Etapa | Pergunta | Resultado aceitável |
|---|---|---|
| Parser | O Godot carrega todo o projecto? | `--headless --editor --quit` sem erro de parser |
| Fluxo público | O menu entra no mundo? | Menu → Novo Jogo sem falhas de recurso/carga |
| Gameplay | O jogador mantém controlo, chão e rota? | 30–36 s sem queda, bloqueio ou erro fatal |
| Imagem | A mudança melhora a leitura em comparação com a base? | ganho perceptível ≥85% do objectivo |
| Reversão | Se não melhora, o mundo volta exactamente ao estado anterior? | sonda removida, UIDs limpos, decisão documentada |
| Publicação | A evidência é rastreável? | commit, push, marcador de continuidade e relatório |

### Limitações conhecidas do ambiente

O llvmpipe pode encerrar após sessões gráficas longas e o Xvfb pode não encaminhar foco de teclado para Godot. A mensagem `XGetInputFocus ... window of 1` torna uma sequência literal de E/W inconclusiva, mas não prova falha de porta. Nesses casos, usar o harness exterior e inspeccionar `open_front_door()`/colisores em vez de declarar uma regressão fictícia. A captura interna `ORIGEM_QA_VIEWPORT_SNAPSHOT` evita a evidência inválida do splash Xvfb. [2]

---

## 5. Lições cartográficas comprovadas

A régua X/Z foi criada porque uma direcção baseada só em Z falhava no desvio para o Acampamento Majestic. O destino agora recebe a posição completa `Vector2(X, Z)`: no ramo oeste aponta para Majestic; na chegada a R6 devolve **CHEGADA ÀS RUÍNAS**, e só depois comunica a passagem futura sob controlo Dev2. Esta correção é um modelo para futuras funções: decisões cartográficas devem usar a topologia real, não uma aproximação de uma dimensão. [2]

A continuidade R5→R6 tinha uma lacuna curta entre o conector Majestic e as lajes da margem. Ela foi corrigida com `LigacaoFisicaMajesticParaMargem`, seis lajes tridimensionais e colisores baixos, validados em movimento. O objectivo não era encher o mapa de decoração, mas fechar uma rota que o mapa já afirmava existir. [2]

| Decisão aprovada | Razão | Preservar |
|---|---|---|
| Clareira focal do Arco em Z=72–92 | coníferas da Floresta Densa ocultavam o marco 3 | árvores laterais e massa posterior permanecem |
| Ligação física Majestic→Margem | eliminou lacuna topológica R5→R6 | lajes, colisores baixos e direcção X/Z |
| Chegada R6 no mapa UI | evitou instrução errada para regressar ao Majestic | etiqueta `CHEGADA ÀS RUÍNAS` |
| Cascata R6 com filetes 3D | eliminou leitura de painel/outdoor azul | água sem emissão excessiva |
| Captura interna de viewport | elimina splash falso no QA | apenas sob variável de ambiente |

---

## 6. Hipóteses rejeitadas: não repetir sem nova causa

As reversões são conhecimento acumulado. Elas poupam tempo e impedem que o projecto entre num ciclo de mudanças estéticas sem causalidade. Abaixo está a lista operacional abreviada; antes de alterar um destes elementos, o colaborador deve indicar o novo nó causal, a hipótese mensurável e a comparação proposta. [2]

| Área | Hipótese já rejeitada | Regra para o futuro |
|---|---|---|
| Estrada/Arco | alterar água para revelar ponte lateral | a água é faixa visual, mas não torna a ponte legível |
| Arco | recuar vegetação lateral da Estrada ou transição Arco→Floresta | essas raízes não eram a oclusão causal |
| Floresta | relva tridimensional lateral, parede de pinheiros, portal estrutural | evitar tufos esparsos e paredes de árvores |
| Majestic | ampliar/recuar estela, cairn direccional, mastro | não criaram leitura focal suficiente |
| Ruínas | balizas, emissão de água, altura do leito, lajes escuras, cais primitivo | manter água não emissiva e procurar ruína real de melhor qualidade |
| Vegetação ribeirinha | variantes de fetos e recuos sem causa | não retestar sem nó específico |
| QA Dev5 | ponte GLB branca leve, arco de blocos, portal de troncos, cais de lajes | candidatos QA rejeitados não entram em produção |

---

## 7. Activos e orçamento técnico

Antes de inserir activos no mundo, medir triângulos, materiais e colisores importados. A auditoria Dev5 confirmou que nem todo activo leve é visualmente adequado, e que alguns activos aparentemente pequenos são demasiado caros para dispersão ampla. [3]

| Activo auditado | Triângulos | Materiais | Uso recomendado |
|---|---:|---:|---|
| `bridge_stone.glb` | 252 | 2 | muito leve, mas rejeitado como marco por silhueta branca/fraca |
| `stone_largeA.glb` | 80 | 1 | margens, encontros e pequenos pontos de escala |
| `tree_detailed_dark.glb` | 402 | 3 | plano médio e dispersão moderada |
| `tree_default_dark.glb` | 114 | — | alternativa leve, a validar artisticamente |
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | apenas árvore focal isolada até LOD comprovado |
| `fern_02_1k.gltf` | 6.232 | 4 | primeiro plano raro; nunca dispersão de massa |

Na amostra QA com um pinheiro focal, três árvores detalhadas, uma alternativa leve e dois fetos, o total foi 27.208 triângulos sem luzes dinâmicas. Essa amostra demonstrou profundidade lateral sem parede florestal, mas também mostra por que pinheiros PBR e fetos devem ser controlados por distância e LOD. [3]

### Limites de trabalho actuais

1. Manter até 16 luzes dinâmicas simultâneas; a abertura Casa Voss usa uma luz local e o handoff validado usa quatro. [2]
2. Não tratar colisão como propriedade implícita de GLB/GLTF. Os activos auditados não traziam colisores importados; criar `StaticBody3D`/`CollisionShape3D` apenas onde a rota exigir.
3. Uma árvore PBR alta por composição QA é a regra até existir LOD e teste de densidade. Árvores leves e rochas servem para criar profundidade sem fechar o trilho.
4. O mesmo activo não deve aparecer em filas rectas, alturas idênticas ou alinhamentos que revelem proceduralidade.

---

## 8. Elias: presente e futuro em terceira pessoa

Elias é o único nome de jogador. A imagem de referência deve ser usada como **direcção artística** — casaco/coleto escuro, camisa clara, cabelo assimétrico, cinto, espada lateral e silhueta humana — e não como uma textura plana aplicada ao jogo.

A frente Dev5 criou `EliasThirdPersonPresentation` e `EliasThirdPersonPreview` como fundação isolada: corpo 3D provisório, câmara QA externa, parser e sessão de 36 segundos. Esta base não é o modelo final nem deve ser ligada directamente a `Player.gd`. A integração real requer um GLB/FBX humano **rigado**, licenciado, com animações e orçamento confirmado. O download externo deve ser considerado bloqueado até existir ficheiro recuperável; esse bloqueio não interrompe as tarefas de mundo, QA, colisão ou cartografia.

---

## 9. Colaboração Git e continuidade sem paragem

Cada frente tem uma branch e um marcador de continuidade. O Git não é apenas arquivo: é o contrato de trabalho da equipa. O erro mais comum foi transformar uma tarefa terminada em motivo de espera. A regra correcta é a seguinte:

> **Um commit é evidência, não pausa.** Depois do push, o colaborador actualiza o marcador com o resultado e a tarefa seguinte, depois começa imediatamente essa tarefa.

| Frente | Branch de referência | Função actual |
|---|---|---|
| Dev1 / cinematográfica | `feature/cine07-final` | Regiões 1–6, mapa real, QA e integração R6→R7 |
| Dev2 | `feature/dev2-mountain-canyon` | Regiões 7–12, montanha e Orion |
| Dev3 | frente cinematográfica/PR | câmara, takes, luz e evidência visual |
| Dev4 | coordenação transversal | auditoria, integração, orçamento e documentação |
| Dev5 | `feature/dev5-cartographic-world-third-person` | catálogo, candidatos QA, auditorias e base QA Elias |

### Protocolo Dev5 activo

Se não existir tarefa escrita, Dev5 não espera. Consulta `PROTOCOLO_CONTINUIDADE_ACTIVA_DEV5.md` e executa, por esta ordem: candidato QA pendente, ficha cartográfica, auditoria de activo, criação QA de marco menos coberto, melhoria QA de Elias, ou auditoria de regressão. A ausência de `gh auth` não é bloqueio de Git: antes de declarar problema, comparar `HEAD`, `origin/<branch>` e `ahead/behind`; para publicar, usar a credencial autorizada do repositório. [4]

---

## 10. Checklist de entrada para novos colegas

1. Clonar a branch atribuída e confirmar `git status`, `HEAD` e a ponta remota.
2. Ler primeiro `EQUIPA_FUNCOES_E_DELEGACAO.md`, o marcador `CONTINUIDADE_<FRENTE>.md` e as decisões de rejeição aplicáveis.
3. Executar o parser headless antes de editar.
4. Declarar a âncora cartográfica e o marco antes de criar qualquer objecto 3D.
5. Criar candidatos em cena QA isolada; não tocar módulos de produção sem revisão do proprietário.
6. Medir activos novos: triângulos, materiais, colisores e luzes.
7. Rodar 30–36 segundos de QA, capturar o viewport e avaliar contra o objectivo.
8. Reverter o que não tiver ganho visual suficiente; documentar para impedir repetição.
9. No commit, actualizar a continuidade com uma tarefa seguinte activa.
10. Só empacotar/entregar jogo depois de Menu → Novo Jogo e gameplay real sem erro.

---

## 11. Prioridades de conhecimento para a próxima iteração

O maior ganho não é adicionar centenas de props. É aumentar a densidade de **objectos com razão cartográfica**: Casa Voss como origem, Estrada como eixo, Arco como destino, Floresta como transição orgânica, Majestic como desvio ocidental e Ruínas como bacia terminal. A ponte Dev5, o pavilhão e o anexo Casa Voss são candidatos QA; só entram no mundo depois de superarem a alternativa existente em gameplay.

Para a equipa nova, a ordem recomendada é: preservar primeiro a escala e a rota; depois instalar um marco físico de alta qualidade por vez; só então aumentar ecologia e microdetalhe. Esta sequência evita que a floresta, a água ou a decoração escondam a própria geografia que o mapa deve ensinar.

---

## Referências internas

[1]: https://github.com/darlanmelloti/ORIGEM/blob/feature/cine07-final/diretor_orientacoes/EQUIPA_FUNCOES_E_DELEGACAO.md "ORIGEM — Funções da Equipa e Delegação"

[2]: https://github.com/darlanmelloti/ORIGEM/blob/feature/cine07-final/diretor_orientacoes/CONTINUIDADE_DEV1.md "Continuidade Dev1 e decisões CP-CARTO"

[3]: https://github.com/darlanmelloti/ORIGEM/blob/feature/dev5-cartographic-world-third-person/diretor_orientacoes/CP_D5_014_AUDITORIA_MALHAS.md "Auditoria real de malhas Dev5"

[4]: https://github.com/darlanmelloti/ORIGEM/blob/feature/dev5-cartographic-world-third-person/diretor_orientacoes/PROTOCOLO_CONTINUIDADE_ACTIVA_DEV5.md "Protocolo de Continuidade Activa Dev5"
