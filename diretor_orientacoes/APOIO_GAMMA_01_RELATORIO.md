# APOIO-GAMMA-01 — Grounding de Adereços R5

## Resultado

Foi criado o preview isolado `levels/dev5/GammaR5PropGroundingPreview.tscn` para apoiar Dev6 na validação dos adereços do Acampamento Majestic. A cena testa três elementos representativos — tenda, fogueira e equipamento abandonado — todos posicionados pela âncora cartográfica R5 e aterrados por raycast através de `CartographicGroundingSystem.gd`.

A implementação preserva X/Z cartográfico e ajusta somente Y sobre o terreno físico inclinado. A prova não altera `ForestLakeRegion.gd`, `TempleLevel.gd`, `Player.gd` ou qualquer módulo regional de produção.

## Validação técnica

O parser Godot 4.7.1 terminou com `PARSER_EXIT=0`. A sessão QA headless decorreu durante 36 segundos e terminou com `QA_EXIT=124`, conforme o protocolo. A telemetria da prova registou três adereços grounded, âncora R5 preservada, erro vertical máximo permitido de `0,05 m`, produção intacta e zero luzes dinâmicas.

| Critério | Resultado |
|---|---|
| Tarefa | `APOIO-GAMMA-01` concluída em QA técnica |
| Âncora | R5 — Acampamento Majestic |
| Adereços | Tenda, fogueira e equipamento abandonado |
| Grounding | 3/3 grounded por raycast |
| Transformação | X/Z preservado; Y ajustado ao impacto |
| Parser | Godot 4.7.1, `0` |
| QA | 36 segundos, `124` |
| Luzes dinâmicas | `0/16` |
| Produção | `PRODUCTION_MODULES_CHANGED=false` |

**STATUS_CODE: PASSED / APOIO_GAMMA_01 / CP-D5-671.**

**NEXT_ACTION_IMMEDIATE:** gerar SHA-256, publicar, aguardar 10 segundos, consultar o GitHub e abrir a próxima tarefa de apoio Gamma.
