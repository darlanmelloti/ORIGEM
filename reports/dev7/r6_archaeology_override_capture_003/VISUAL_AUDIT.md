# R6 — Captura QA de Override Arqueológico Dev7

| Campo | Resultado |
|---|---|
| **Task ID** | `DEV7-R6-ARCHAEOLOGY-QA-OVERRIDE-CAPTURE-003` |
| **Estado da execução** | Concluída exclusivamente em QA; nenhuma mutação de produção. |
| **Região proprietária** | R6 — Ruínas Submersas / Dev6. |
| **Rota protegida** | `forest_to_ruins`, preservada sem mudança de colisão, largura, água, âncoras ou câmara do jogador. |
| **Capturas** | `baseline.png` e `override.png`, ambas em **1600×900**, 16:9. |
| **Renderização** | Godot 4.7.1 em viewport gráfico OpenGL Compatibility sob Xvfb. |

## Método

A cena normal do jogo foi carregada com um runner ativado apenas por `ORIGEM_QA_R6_ARCHAEOLOGY_CAPTURE`. O runner criou uma `Camera3D` temporária, ocultou a interface apenas durante o frame de evidência e libertou-a logo após a captura. A câmara do jogador, as cenas, os recursos persistentes e `ForestLakeRegion.gd` não foram alterados.

A variante duplicou em memória o material ativo de **quatro marcos auditados** — `EstelaDaChegada`, `MarcoRuinaEmergente_*`, `PilarSubmerso_*` e `AfloramentoChegadaRuinas_*`. Cada cópia QA aplicou albedo moderadamente mais quente por interpolação de 20%, aumentou a rugosidade em 0,08 e manteve emissão desativada. Os overrides foram restaurados antes do encerramento do jogo.

| Verificação de invariância | Baseline | Variante |
|---|---:|---:|
| Marcos localizados | 4 | 4 |
| Overrides QA ativos durante a captura | 0 | 4 |
| Luzes R6 com nome canónico | 4 | 4 |
| Luzes totais no mundo carregado | 60 | 60 |
| Transformações dos quatro marcos | Inalteradas | Inalteradas após restauro |
| Escritas de produção | 0 | 0 |

## Leitura comparativa

As duas imagens preservam o mesmo enquadramento amplo de `forest_to_ruins`. A diferença de píxeis existe — **67 900 píxeis** diferentes; RMSE normalizado **0,0103364** — mas o ganho não é visualmente legível no enquadramento de exploração: os quatro marcos estão distribuídos por profundidade e escala, e a alteração de material não cria uma nova prioridade narrativa distinguível sem zoom, iluminação adicional ou geometria nova.

> **Resultado QA:** a variante temporária é tecnicamente segura e reversível, mas **não demonstra melhoria visual suficientemente perceptível** para recomendar uma alteração de produção R6.

Esta rejeição não é uma rejeição da qualidade física, da rota ou das quatro luzes R6. Pelo contrário, esses limites foram preservados. A evidência rejeita somente a hipótese de que este override material moderado sobre os quatro marcos, num enquadramento representativo da rota, resolva por si só a leitura arqueológica.

## Recomendação ao dono R6

Dev7 não recomenda implementação de produção. Qualquer revisão futura deve permanecer em QA e começar por clarificar o alvo de avaliação: o contrato ativo exige quatro marcos auditados, enquanto a proposta arquivada descreve cinco vestígios próximos da rota. Essa divergência documental não deve ser convertida em alteração de produção sem decisão explícita de Dev6/R6.

A sucessão Dev7 deve abrir uma **revisão de evidências** do enquadramento e da correspondência entre alvo/rota, sem alterar luzes, água, física, câmara, `ForestLakeRegion.gd`, colisores, ancoragens ou rotas.

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `baseline.png` | Frame de referência R6 sem override QA. |
| `override.png` | Mesmo frame com quatro overrides temporários em memória. |
| `baseline.log` | Marcador runtime e inventário de invariância baseline. |
| `override.log` | Marcador runtime e inventário de invariância da variante. |
| `pixel_difference_ae.txt` | Contagem de píxeis diferentes. |
| `pixel_difference_rmse.txt` | Erro médio quadrático normalizado. |

## Referências internas

[1] `qa/regions/capture_dev7_r6_archaeology_override.gd` — runner temporário da captura comparativa.

[2] `qa/regions/verify_dev7_r6_archaeology_material_silhouette.gd` — auditoria QA anterior dos quatro marcos e das quatro luzes R6.

[3] `diretor_orientacoes/DEV7_VISUAL_PLAYABLE_PHYSICS_CONTINUOUS_WORK.md` — limites de propriedade e sucessão contínua Dev7.
