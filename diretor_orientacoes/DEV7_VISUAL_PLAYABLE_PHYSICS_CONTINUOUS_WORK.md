# Dev7 — Design Gráfico e Física Jogável: Trabalho Contínuo

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV7-R6-ARCHAEOLOGY-MATERIAL-SILHOUETTE-AUDIT-002
owner: Dev7
branch: dev7/visual-playable-physics
```

## Base e fronteiras

A fonte é `dev7/visual-playable-physics`, criada a partir da integração R1–R6. Dev7 não assume propriedade de produção regional: produz evidência visual/física, diagnósticos e propostas modulares. Alterações de produção só podem ser implementadas após uma validação explícita de dono regional, cartografia, rotas, orçamento e colisão.

`CartographicAnchors.gd`, rotas canónicas, Player, câmara de jogador, `ForestLakeRegion.gd`, água R6, colisores e luzes regionais são protegidos na baseline e na auditoria seguinte.

## Entrega aprovada — DEV7-VISUAL-PLAYABLE-PHYSICS-BASELINE-001

A baseline preservou seis capturas runtime 1600×900 em `reports/dev7/visual_playable_physics_baseline_001`, abrangendo `road_to_arch`, `arch_to_forest`, `forest_to_majestic`, `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`. Todas registraram spawn pós-carregamento. A prova de grounding, executada pela cena de jogo em `road_to_arch`, passou com posição estável e sem alteração de produção.

A auditoria visual concluiu que a navegação central permanece legível, mas a prioridade artística é hierarquia de material/silhueta em elementos arqueológicos existentes na transição `forest_to_ruins`. Não se recomenda correção de física, luz ou geometria nesta etapa.

## Tarefa ativa — DEV7-R6-ARCHAEOLOGY-MATERIAL-SILHOUETTE-AUDIT-002

Mapear exclusivamente em QA os meshes arqueológicos existentes e visíveis ao longo de `forest_to_ruins`, classificando forma, material, distância da rota e contraste contra o terreno. A entrega deve simular overrides de material apenas no ambiente de teste, sem escrever em produção, e recomendar no máximo uma alteração modular para decisão do dono R6.

| Critério | Obrigatório |
|---|---|
| Produção | Nenhuma modificação em cenas, `ForestLakeRegion.gd`, água, câmara, Player, luz ou física |
| Elementos | Apenas ruínas, estelas, pilares e rochas R6 já existentes |
| Rota | `forest_to_ruins` preservada, sem alteração de largura ou colisão |
| Luzes | R6 mantém exatamente quatro; QA não cria `Light3D` |
| Evidência | Captura 16:9, inventário espacial e auditoria de contraste |
| Validação | Parser, gate R6 e rota canónica antes de recomendação |

## Sucessão obrigatória

Há exatamente uma tarefa ACTIVE. Ao concluir a auditoria, Dev7 deve avançar para uma tarefa de proposta modular `...-003`, ou para uma revisão de evidências se a alteração não for segura. Publicação, CI, dependência ou indisponibilidade transitória não são motivo de paragem.
