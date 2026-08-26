# Dev7 — Design Gráfico e Física Jogável: Trabalho Contínuo

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV7-R6-ARCHAEOLOGY-QA-OVERRIDE-CAPTURE-003
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

## Tarefa ativa — DEV7-R6-ARCHAEOLOGY-QA-OVERRIDE-CAPTURE-003

Criar uma cópia de cena exclusivamente QA e produzir duas imagens 16:9 da composição `forest_to_ruins`: baseline e variante de contraste moderado aplicada apenas aos quatro marcos auditados. A tarefa deve medir o orçamento R6 e confirmar que não existe alteração de rota, colisão, água, luz ou produção antes de recomendar ou rejeitar uma proposta modular ao dono R6.

| Critério | Obrigatório |
|---|---|
| Produção | Nenhuma modificação em cenas, `ForestLakeRegion.gd`, água, câmara, Player, luz ou física |
| Elementos | Apenas os quatro marcos R6 auditados e já existentes |
| Rota | `forest_to_ruins` preservada, sem alteração de largura ou colisão |
| Luzes | R6 mantém exatamente quatro; QA não cria `Light3D` |
| Evidência | Par de capturas 16:9, inventário espacial e auditoria de contraste |
| Validação | Parser, gate R6 e rota canónica antes de recomendação |

## Sucessão obrigatória

Há exatamente uma tarefa ACTIVE. Ao concluir a captura QA, Dev7 deve avançar para uma proposta modular `...-004` somente se a variante demonstrar ganho visual mensurável; caso contrário, deve abrir revisão de evidências. Publicação, CI, dependência ou indisponibilidade transitória não são motivo de paragem.
