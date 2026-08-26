# R4 — Inventário QA de Elegibilidade Modular do Afluente 050

| Campo | Valor |
|---|---|
| **Task ID** | `DEV4-R4-CARTOGRAPHIC-INLET-MODULE-ELIGIBILITY-050` |
| **Método** | Inspeção estática do construtor do afluente e reconciliação com a matriz R4/R6 049. |
| **Produção** | Nenhuma modificação a cenas, módulos, materiais, água, geometria, luz, física, câmara, âncoras ou rotas. |
| **Decisão** | Não existe candidata de produção elegível nesta etapa. A próxima prova deve medir leitura runtime, sem alterar o mundo. |

## Fonte observada

O construtor `_build_cartographic_river_inlet()` define uma lâmina própria, `LaminaDoAfluenteCartografico`, através de cinco pontos cartográficos: `(12,6; 163)`, `(13,4; 178)`, `(17,8; 193)`, `(25,6; 208)` e `(36; 224)`. A água recebe `_create_lake_material()`, recurso partilhado com a leitura R6. As margens existentes são construídas no mesmo nó-raiz do afluente e recebem o material húmido de margem já aprovado.

> **Conclusão causal:** os elementos laterais existentes pertencem funcionalmente ao afluente e não são uma camada ambiental independente. Alterá-los para "corrigir" a lâmina seria uma alteração visual direta da mesma composição partilhada, não a evidência de uma solução modular exterior.

## Inventário de candidatas existentes

| Grupo | Quantidade | Relação com a lâmina | Estado de elegibilidade |
|---|---:|---|---|
| `RochaDaMargemDoAfluente_00_*` a `04_*` | 10 | Criadas nos cinco pontos cartográficos, com afastamento lateral calculado a partir da largura do afluente. | **Não elegível**: requer medição runtime de distância ao trilho e pertence ao mesmo nó-raiz da água. |
| `FetoDaMargemDoAfluente_*` | 5 | Criados alternadamente junto às rochas da margem. | **Não elegível**: lê-se como borda imediata da lâmina e não como composição exterior independente. |
| `LaminaDoAfluenteCartografico` | 1 | Malha de água opaca com material lacustre partilhado. | **Proibida**: transparência, cota, largura e `cull_back` permanecem rejeitados. |
| `TrilhoAteAMargemDoLago` e lajes | 30 visuais + 30 físicas | Corredor R6 posterior, com lajes e colisores próprios. | **Excluído**: pertence ao handoff R6 e não pode ser usado como margem decorativa R4. |

## Critérios de exclusão

| Risco | Aplicação ao inventário |
|---|---|
| Repetição de variante rejeitada | Ajustar qualquer elemento para encobrir a lâmina retomaria indiretamente as quatro hipóteses rejeitadas. |
| Propriedade partilhada | A lâmina usa material lacustre R6; qualquer leitura de margem adjacente requer revisão conjunta R4/R6. |
| Corredor e clareira | Nenhuma distância ao trilho foi demonstrada por sessão runtime nesta tarefa; portanto nenhum ativo pode ser promovido. |
| Leitura enganosa | Adicionar massa visual antes de provar a causa arrisca criar painel, muro vegetal ou mascaramento ambiental. |

## Resultado

A etapa **não seleciona nenhum ativo para produção**. A elegibilidade só poderá ser reavaliada depois de uma captura QA runtime que meça, no mesmo enquadramento `arch_to_forest`, a distância ao trilho, a ocupação visual da lâmina e a transformação dos elementos existentes sem os modificar.

## Próxima sucessão proposta

`DEV4-R4-CARTOGRAPHIC-INLET-RUNTIME-SIGHTLINE-051` deve executar uma prova apenas de leitura: recolher baseline 16:9, telemetria dos cinco pontos do afluente, distância ao corredor e contagem de luzes R4/R6. Não pode aplicar overrides de material, transformação, visibilidade, geometria ou colisão.

## Referências internas

[1] `levels/ForestLakeRegion.gd`, `_build_cartographic_river_inlet()`.

[2] `reports/r4/CARTOGRAPHIC_INLET_ISOLATION_044.md`.

[3] `reports/r4/CARTOGRAPHIC_INLET_EVIDENCE_REVIEW_049.md`.
