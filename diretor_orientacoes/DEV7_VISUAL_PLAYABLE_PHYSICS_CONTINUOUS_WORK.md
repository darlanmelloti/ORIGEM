# Dev7 — Design Gráfico e Física Jogável: Trabalho Contínuo

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV7-R6-ARCHAEOLOGY-EVIDENCE-REVIEW-004
owner: Dev7
branch: dev7/visual-playable-physics
```

## Base e fronteiras

A fonte é `dev7/visual-playable-physics`, criada a partir da integração R1–R6. Dev7 não assume propriedade de produção regional: produz evidência visual/física, diagnósticos e propostas modulares. Alterações de produção só podem ser implementadas após uma validação explícita de dono regional, cartografia, rotas, orçamento e colisão.

`CartographicAnchors.gd`, rotas canónicas, Player, câmara de jogador, `ForestLakeRegion.gd`, água R6, colisores e luzes regionais são protegidos na baseline e na auditoria seguinte.

## Entrega aprovada — DEV7-VISUAL-PLAYABLE-PHYSICS-BASELINE-001

A baseline preservou seis capturas runtime 1600×900 em `reports/dev7/visual_playable_physics_baseline_001`, abrangendo `road_to_arch`, `arch_to_forest`, `forest_to_majestic`, `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`. Todas registraram spawn pós-carregamento. A prova de grounding, executada pela cena de jogo em `road_to_arch`, passou com posição estável e sem alteração de produção.

A auditoria visual concluiu que a navegação central permanece legível, mas a prioridade artística é hierarquia de material/silhueta em elementos arqueológicos existentes na transição `forest_to_ruins`. Não se recomenda correção de física, luz ou geometria nesta etapa.

## Entrega aprovada — DEV7-R6-ARCHAEOLOGY-MATERIAL-SILHOUETTE-AUDIT-002

A auditoria QA localizou quatro marcos arqueológicos existentes na transição `forest_to_ruins`: Estela da Chegada, Marco de Ruína Emergente, Pilar Submerso e Afloramento da Chegada. Foram simuladas quatro variantes de material apenas em memória de teste, sem mutação de produção, e as quatro luzes R6 foram preservadas. A evidência está em `reports/dev7/R6_ARCHAEOLOGY_MATERIAL_SILHOUETTE_AUDIT_002.md`.

## Entrega concluída — DEV7-R6-ARCHAEOLOGY-QA-OVERRIDE-CAPTURE-003

A captura comparativa foi executada pela cena de jogo em OpenGL Compatibility/Xvfb. `baseline.png` e `override.png` foram guardadas em 1600×900, com quatro materiais temporários aplicados apenas em memória QA. O runner confirmou quatro luzes R6, transformações inalteradas, rota `forest_to_ruins` preservada e zero escritas de produção. A porta R6 e a prova própria aprovaram.

A diferença de píxeis é mensurável, mas a leitura do par não demonstra ganho visual suficientemente perceptível num enquadramento representativo de exploração. A variante foi, portanto, rejeitada como recomendação de produção. A evidência integral está em `reports/dev7/r6_archaeology_override_capture_003/VISUAL_AUDIT.md`.

## Tarefa ativa — DEV7-R6-ARCHAEOLOGY-EVIDENCE-REVIEW-004

Reconciliar, estritamente em QA documental, a divergência entre o conjunto de quatro marcos da auditoria/contrato e os cinco vestígios próximos da rota descritos na proposta arquivada. O objetivo é definir se existe um conjunto de alvos e um enquadramento de prova inequívocos para uma decisão futura de Dev6/R6; não é criar uma nova variante de produção.

| Critério | Obrigatório |
|---|---|
| Produção | Nenhuma modificação em cenas, `ForestLakeRegion.gd`, água, câmara, Player, luz ou física |
| Elementos | Apenas referências e inventário dos quatro marcos auditados e cinco vestígios já existentes |
| Rota | `forest_to_ruins` continua protegida, sem alteração de largura ou colisão |
| Luzes | R6 mantém exatamente quatro; QA não cria `Light3D` |
| Evidência | Revisão rastreável dos alvos, do enquadramento e do resultado rejeitado |
| Decisão regional | Qualquer implementação continua dependente de decisão explícita de Dev6/R6 |

## Sucessão obrigatória

Há exatamente uma tarefa ACTIVE. Ao concluir a revisão de evidências, Dev7 deve avançar para a próxima auditoria QA rastreável, mantendo a rejeição de produção enquanto não existir decisão explícita do dono R6. Publicação, CI, dependência ou indisponibilidade transitória não são motivo de paragem.
