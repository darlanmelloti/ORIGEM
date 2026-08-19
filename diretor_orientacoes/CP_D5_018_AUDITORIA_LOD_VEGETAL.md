# CP-D5-018 — Auditoria LOD vegetal

## Resultado

A auditoria QA mediu os activos vegetais reais já existentes no repositório, sem importar novos ficheiros e sem alterar módulos de produção. A cena `VegetationLodAuditPreview.tscn` passou o parser e completou 36 segundos em runtime headless. O aviso FSR1 do renderer de compatibilidade é externo à auditoria.

| Activo | Triângulos | Malhas | Materiais | Colisores | Tamanho |
|---|---:|---:|---:|---:|---:|
| `ez_pine_tall_pbr.glb` | 13.424 | 2 | 2 | 0 | 1.211.556 bytes |
| `tree_detailed_dark.glb` | 402 | 1 | 3 | 0 | 31.416 bytes |
| `fern_02_1k.gltf` | 6.232 | 4 | 4 | 0 | 6.899 bytes |
| `tree_default_dark.glb` | 114 | 1 | 2 | 0 | 9.436 bytes |

## Limites de composição

O pinheiro PBR tem 13.424 triângulos e deve ser limitado a **uma árvore focal por composição QA** até existir LOD comprovado. A camada média pode usar até três árvores detalhadas de 402 triângulos, mantendo a leitura de profundidade sem formar parede de árvores. A camada distante pode usar até oito elementos da alternativa leve de 114 triângulos; o feto de 6.232 triângulos não deve ser tratado como folhagem distante em volume, mas apenas como peça focal isolada ou elemento de estudo.

Não foram encontrados colisores importados nos quatro activos e a cena não criou luzes dinâmicas no lote. Os próximos candidatos dos marcos 4 e 5 devem respeitar estes limites e não devem usar relva tridimensional rejeitada.

## Validação

A linha de runtime confirmou `focal_limit=1_pbr_tree medium_limit=3_detailed_trees distant_limit=8_light_foliage dynamic_lights=0`. Não foram encontrados `SCRIPT ERROR`, `Parse Error`, falhas de carregamento ou erros Dev5. O log integral está em `CP-D5-018_RUNTIME_HEADLESS.log`.

## Próxima tarefa

Ao publicar este checkpoint, abrir automaticamente **CP-D5-019**, conforme a continuidade oficial.
