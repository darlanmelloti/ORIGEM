# CP-D5-031 — Vegetação média aterrada R4/R5

**Escopo:** cena QA nova em `levels/dev5/`, sem modificação dos módulos de produção regionais.

## Composição e limites

A composição utiliza somente activos locais já medidos na auditoria LOD: um pinheiro PBR focal, três árvores detalhadas de plano médio, seis árvores leves de fundo e dois fetos. A distribuição foi colocada lateralmente e em profundidade, preservando a abertura central e evitando tanto portal estrutural como parede florestal. Nenhum dos candidatos cria luz própria.

| Classe | Quantidade | Regra CP-D5-018 | Resultado |
|---|---:|---|---|
| Pinheiro PBR focal | 1 | Máximo 1 por composição | Conforme |
| Árvore detalhada média | 3 | Máximo 3 | Conforme |
| Árvore leve distante | 6 | Máximo 6 | Conforme |
| Feto focal lateral | 2 | Isolado nos bordos | Conforme |

## Telemetria de aterramento

Os 12 candidatos aplicaram `CartographicGroundingSystem.gd`. Todos preservaram X/Z e obtiveram impacto físico no solo QA. As diferenças de Y observadas provêm da inclinação dos dois patches físicos; não representam deslocamento cartográfico.

| Marco | Candidatos | Contactos raycast | X/Z preservado | Luzes novas |
|---|---:|---:|---|---:|
| R4 — Floresta Densa | 6 | 6 | Sim | 0 |
| R5 — Acampamento Majestic | 6 | 6 | Sim | 0 |

O parser Godot 4.7.1 passou. A sessão QA de 36 segundos confirmou `candidates=12`, `wall_of_trees=false`, `dynamic_lights_added=0` e ausência de módulos de produção. A captura interna mostra profundidade lateral e corredor visual desimpedido, com a árvore PBR focal limitada a um único bordo.

## Decisão

**APROVADO como composição técnica QA.** A cena não autoriza integração automática em `ForestLakeRegion.gd`: a futura integração requer revisão Dev1 sobre a leitura cinematográfica, colisões de rota e densidade regional.

## Próxima tarefa automática

**CP-D5-032 — Matriz de integração de candidatos aterrados.** Consolidar os candidatos QA que já possuem prova de aterramento — anexo Casa Voss, Ponte Marco 2, Pavilhão Majestic e vegetação média — numa matriz de revisão Dev1 com âncora, impacto Y, evidência, limite LOD e teste de aceitação. Esta é uma auditoria de integração, não uma alteração de módulos regionais.
