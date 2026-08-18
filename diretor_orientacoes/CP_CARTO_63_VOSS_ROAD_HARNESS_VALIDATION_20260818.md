# CP-CARTO-63 — Harness Casa Voss→Estrada Validado

## Problema corrigido

A rota usada no CP-CARTO-62 (`voss_road`) não é reconhecida por `TempleLevel.gd`; por isso, a captura resultou numa posição geometricamente inválida e não podia ser usada para avaliar o cenário ou o sobreiro.

## Solução

A prova passou a usar exclusivamente o harness reconhecido `road_return_voss`, que chama `_prepare_road_return_voss_qa()` e conserva o mundo de produção intacto.

## Validação

Godot 4.7.1 passou sem erro de parser ou runtime. A sessão `road_return_voss` foi mantida durante 36 segundos e a captura `cp_carto63_road_return_voss_1600x900.png` mostra Casa Voss, soleira, trilho físico e espada em primeira pessoa em uma tomada geometricamente válida.

## Continuidade

Não houve alteração de conteúdo de produção. Usar `road_return_voss` para futuras provas Casa Voss→Estrada; não reutilizar `voss_road`. CP-CARTO-56 continua aguardando a publicação Dev2 para R6→R7.
