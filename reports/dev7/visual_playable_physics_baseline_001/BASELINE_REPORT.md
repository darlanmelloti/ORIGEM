# ORIGEM — Baseline Visual e Física Jogável

| Campo | Valor |
|---|---|
| **Task ID** | `DEV7-VISUAL-PLAYABLE-PHYSICS-BASELINE-001` |
| **Responsável** | Dev7 — Direção Visual, Legibilidade Ambiental e Física Jogável |
| **Branch** | `dev7/visual-playable-physics` |
| **Base verificada** | `origin/integration/r1-r6-sprint1` em `0dbb6860` |
| **Escopo modificado** | Exclusivamente `reports/dev7/visual_playable_physics_baseline_001/` e `qa/dev7/` |
| **Runtime de prova** | Godot `4.7.1.stable.official.a13da4feb`, Compatibility/OpenGL3, 1600×900 |
| **Método** | Captura runtime, sonda física existente `QA-GROUND-01`, sonda regional `CP_CARTO80_FLOOR` e transição `QA-STATE-01` |

## Conclusão executiva

A baseline confirma que os seis pontos de captura arrancam em runtime, que cinco das seis posições de rota permanecem fisicamente estáveis e que a transição de estado do jogador para Orion conserva saúde e stamina. No entanto, a leitura ambiental atual não sustenta a fantasia arqueológica, a escala nem os momentos de descoberta exigidos para o percurso R1→R6. As imagens verificadas mostram corredores excessivamente abertos, lajes fragmentadas, superfície de água geométrica e elementos de baixo detalhe/acentos ciano que disputam a leitura com os objetivos espaciais.

A falha física de `arch_to_forest` é **real e bloqueadora**, pois duas ferramentas existentes apresentam ausência persistente de contacto com o chão. Esta baseline não a corrige por regra explícita: não modifica `Player`, câmara, colisores, ancoragens, luzes, geometria de produção ou `levels/ForestLakeRegion.gd`.

> A única intervenção visual recomendada é o **Kit Modular de Leitura de Trilho R4**, de propriedade de **Dev4 / R4 Floresta Densa**. É uma proposta regional, modular, sem nova luz, sem nova física e sem alteração de ancoragem. A sua implementação só pode começar depois de a falha física `arch_to_forest` ser resolvida e validada pelo proprietário regional.

## Matriz de capturas runtime

Todas as imagens abaixo têm 1600×900. A primeira tentativa de `voss_to_road` com doze segundos de estabilização mostrou o ecrã de arranque Godot e foi descartada. A matriz final usou sessenta segundos de estabilização após o spawn técnico, evitando qualquer cartela de arranque.

| Percurso obrigatório | Objetivo espacial lido no frame | Obstáculos ou superfícies intrusivas | Continuidade de solo | Frame de leitura | Luzes visíveis | Custo / escala observados | Evidência |
|---|---|---|---|---|---|---|---|
| R1/R2 `voss_to_road` | O trilho conduz a uma estrutura distante; a entrada R1→R2 é reconhecível. | Arma do jogador no canto inferior direito; ambiente pouco estratificado. | Lajes contínuas no eixo. | Excesso de céu; arco demasiado distante para comunicar escala. | Sem luz dinâmica evidente. | Ambiente leve, mas com baixa densidade e pouca sensação de vale. | `voss_to_road/voss_to_road_postload.png` |
| R3/R4 `arch_to_forest` | Há orientação geral entre encostas, sem leitura clara da entrada na floresta. | Rochas simplificadas, acentos ciano e vegetação insuficiente; arma intrusiva. | Laje isolada em primeiro plano, sem faixa de caminhada clara. | Corredor em vale sem marco de transição; não demonstra a clareira R4. | Sem luz dinâmica evidente. | Escala horizontal sem profundidade narrativa; não exige nova luz. | `arch_to_forest/arch_to_forest_postload.png` |
| R4/R5 `forest_to_majestic` | Trilho aponta a estruturas ao longe, mas o acampamento não funciona como destino. | Volumes escuros retangulares e marcadores ciano expostos; arma intrusiva. | Via de pedra contínua e navegável. | O vale aberto enfraquece a hierarquia do destino. | Sem luz dinâmica evidente. | Bom potencial para solução modular de margens e repetição de trilho. | `forest_to_majestic/forest_to_majestic_postload.png` |
| R4/R6 `forest_to_ruins` | Margem do lago é reconhecível, mas Ruínas Submersas não são anunciadas. | Recorte rígido da água, blocos/peça vermelha e acentos ciano expostos. | Placas em linha, separadas e pouco integradas na margem. | Falta composição de chegada ao lago. | Sem luz dinâmica evidente. | Pode melhorar por módulos de borda sem aumentar orçamento de luz. | `forest_to_ruins/forest_to_ruins_postload.png` |
| R5/R6 `majestic_to_lake` | Conector segue em frente, sem marco do acampamento ou do lago. | Sombra de estrutura no primeiro plano, objetos de baixo detalhe e arma intrusiva. | Sequência de placas fisicamente navegável. | Sem ponto focal e sem escala de aproximação. | Sem luz dinâmica evidente. | Proposta futura deve preservar o conector e colisores existentes. | `majestic_to_lake/majestic_to_lake_postload.png` |
| R6 `ruins_arrival` | Não revela ruínas, água nem objetivo de exploração. | Elementos soltos, árvore isolada, estela e arma intrusiva. | Sem trilho claramente dominando a chegada. | Campo aberto sem a revelação submersa do storyboard. | Sem luz dinâmica evidente. | Há margem para leitura modular, mas não antecipar R7. | `ruins_arrival/ruins_arrival_postload.png` |

## Evidência física repetível

| Prova | Resultado | Medição determinante | Estado |
|---|---|---|---|
| `QA-GROUND-01` em `voss_to_road` | 180 frames em chão. | Desvio vertical pós-aquecimento: 0,000 m. | **Aprovado** |
| `QA-GROUND-01` em `arch_to_forest` | 0 frames em chão. | Desvio vertical: 1,749 m; pior velocidade descendente: 5,063 m/s. | **Falhou** |
| `CP_CARTO80_FLOOR` em `arch_to_forest` | `no_chao=false` aos 0,0; 0,5; 1,5; 3,0 e 6,0 s. | `y` real não estabiliza no `esperado_y` calculado pela sonda regional. | **Falhou — confirmação independente** |
| `QA-GROUND-01` em `forest_to_majestic` | 180 frames em chão. | Desvio vertical pós-aquecimento: 0,000 m. | **Aprovado** |
| `QA-GROUND-01` em `forest_to_ruins` | 180 frames em chão. | Desvio vertical pós-aquecimento: 0,000 m. | **Aprovado** |
| `QA-GROUND-01` em `majestic_to_lake` | 180 frames em chão. | Desvio vertical pós-aquecimento: 0,000 m. | **Aprovado** |
| `QA-GROUND-01` em `ruins_arrival` | 180 frames em chão. | Desvio vertical pós-aquecimento: 0,000 m. | **Aprovado** |
| `QA-STATE-01` | Entrada Orion concluída em 33 s. | Vida 100 e stamina 100 antes/depois da transição. | **Aprovado** |

A rota `arch_to_forest` não deve ser apresentada como aprovada. O problema deve ser atribuído a **Dev4 / R4**, sem qualquer correção especulativa de Dev7 nesta baseline. As restantes provas comprovam que o defeito é localizado, não uma falha geral do `Player` ou do harness.

## Intervenção candidata única

### DEV7-R4-TRAIL-READABILITY-KIT-002 — Kit Modular de Leitura de Trilho R4

A intervenção candidata consiste em uma família pequena de módulos visuais estáticos e reutilizáveis, restrita às margens do percurso R4 após a correção física da rota. Os módulos devem reforçar o eixo de circulação que já existe através de transições de pedra, bordas de solo compactado, conjuntos de raiz/pedra de baixo perfil e agrupamentos de sub-bosque orientados para fora do corredor. O conjunto deve construir profundidade e enquadrar a descoberta sem criar uma parede de árvores, sem criar colisor, sem usar área, personagem ou obstáculo.

| Critério obrigatório | Decisão da candidata |
|---|---|
| **Classificação** | Modular, regional, sem nova luz, sem nova física, sem alteração de ancoragem. |
| **Região dona** | R4 — Floresta Densa; proprietário Dev4. |
| **Gatilho de início** | Aprovada a recuperação de grounding em `arch_to_forest`. |
| **Limite espacial** | Corredor e margens visuais R4; clareira Orion Z≈126–151 preservada e corredor exterior mínimo de 8 m mantido. |
| **Luzes** | Zero adições. Mantém-se o máximo R4 de uma luz dinâmica. |
| **Física** | Zero colisores, áreas, obstáculos, personagens ou mudanças de `Player`/câmara. |
| **Cartografia** | Não altera `CartographicAnchors.gd`, coordenadas ou rotas canónicas. |
| **Produção partilhada** | Não altera `levels/ForestLakeRegion.gd` sem proposta e aprovação explícitas. |
| **Efeito esperado** | Continuidade visual do trilho, maior legibilidade da transição Arco→Floresta→Majestic e redução da leitura de greybox sem mascarar o mundo. |
| **Risco de integração** | Baixo, se implementada exclusivamente no módulo regional do proprietário e acompanhada pelos gates R4/R5/R6. |

## Limites e próximos gates

O runtime foi executado em `llvmpipe`/OpenGL3, adequado para detectar integridade de inicialização, estabilidade e composição, mas não para certificar fps de uma GTX 1050 Ti. Não foram adicionadas luzes; portanto, a auditoria de orçamento confirmará a preservação das contagens existentes, não uma melhoria de desempenho GPU.

A baseline já executou parser Godot 4.7.1, `git diff --check`, gates R2–R6, rotas contratuais e auditoria global de luz. Todos esses gates passaram. A próxima atividade segura é manter `DEV7-R4-TRAIL-READABILITY-KIT-002` como única tarefa ativa de Dev7 em modo de especificação, bloqueada por `DEV4-R4-ARCH-FOREST-GROUNDING-RECOVERY`. Antes de qualquer alteração de produção, repetir os mesmos gates, incluindo a recuperação explícita de grounding em `arch_to_forest`.

## Inventário de evidências

| Tipo | Localização |
|---|---|
| Capturas 1600×900 | `reports/dev7/visual_playable_physics_baseline_001/{voss_to_road,arch_to_forest,forest_to_majestic,forest_to_ruins,majestic_to_lake,ruins_arrival}/` |
| Logs de runtime e parser por captura | Dentro de cada diretório de rota acima. |
| Grounding por rota | `reports/dev7/visual_playable_physics_baseline_001/physics/*/summary.txt` |
| Sonda R4 independente | `reports/dev7/visual_playable_physics_baseline_001/physics/arch_to_forest_floor_probe/summary.txt` |
| Transição de estado | `reports/dev7/visual_playable_physics_baseline_001/physics/state_transition/` |
| Notas de campo | `reports/dev7/visual_playable_physics_baseline_001/FIELD_NOTES.md` |

## Referências internas

[1] `pasted_content.txt`, briefing **ORIGEM — Briefing Dev7: Design Gráfico e Física Jogável** fornecido pelo Diretor.
[2] `Storyboard_Origem_Gameplay_60s.docx`, storyboard fornecido pelo Diretor.
[3] `tools/qa/capture_regional_runtime.sh`, capturador runtime reutilizado sem alteração.
[4] `tools/qa/run_player_grounding.gd`, sonda `QA-GROUND-01` reutilizada sem alteração.
[5] `levels/TempleLevel.gd`, sonda regional `CP_CARTO80_FLOOR` reutilizada sem alteração.
[6] `tools/qa/run_player_state_transition_xvfb.sh`, verificador `QA-STATE-01` reutilizado sem alteração.
