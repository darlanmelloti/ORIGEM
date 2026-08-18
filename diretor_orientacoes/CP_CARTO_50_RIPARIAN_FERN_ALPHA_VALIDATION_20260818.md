# CP-CARTO-50 — Material Alfa dos Fetos Ribeirinhos R6

**Branch:** `feature/cine07-final`  
**Escopo:** material das instâncias `FetoRibeirinho_*` na margem das Ruínas Submersas.  
**Fronteira:** nenhum feto fora do perímetro ribeirinho, água, estela, lajes, colisores, luzes, combate ou módulos R7–R12 foi modificado.

## Diagnóstico e correcção aceite

Após o CP-CARTO-49 remover os props claros gerados pelas rochas sem material, persistia uma única folha clara no primeiro plano da tomada estacionária R6. O CP-CARTO-48 não abrangia os `FetoRibeirinho_*`. Foi aplicado apenas a esse conjunto o material PBR duplicado com corte alfa compatível, dupla face, tom vegetal, rugosidade alta e emissão desligada.

A captura CP-CARTO-50 confirma que a folha clara remanescente desapareceu, preservando a vegetação de margem e a leitura da estela.

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Gameplay real | **30 segundos aprovados** em `ruins_arrival` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto50_riparian_fern_1600x900.png` |
| Folha clara de primeiro plano | **Eliminada** |
| Vegetação ribeirinha | **Preservada** |
| Colisão e rota | **Sem alterações** |
| Regiões 7–12 | **Sem alterações** |

## Continuidade

O CP-CARTO-50 é aceite. A sequência R6 passa a ter materiais coerentes de rocha e folhagem no renderizador OpenGL. A próxima prova cartográfica deve regressar ao eixo Casa Voss→Estrada→Arco para uma auditoria de macro-legibilidade enquanto a publicação Dev2 CP-D2-214 continua pendente.
