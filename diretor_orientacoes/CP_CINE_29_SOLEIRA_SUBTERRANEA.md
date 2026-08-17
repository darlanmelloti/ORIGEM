# CP-CINE-29 — Soleira Subterrânea Orion

Foi criado o primeiro módulo subterrâneo separado, `SoleiraSubterraneaOrion`. O módulo contém exclusivamente piso com colisão correspondente e duas paredes curtas. Não contém Cube, altar, partículas, luz Chronos, câmara ou teletransporte.

O módulo é criado em posição subterrânea e inicia invisível. Depois de Elias cruzar `GatilhoFisicoInteriorOrion`, o log de validação confirma a cadeia física:

> `[CP-CINE-28] ORION_HANDOFF_READY player=Player`
>
> `[CP-CINE-29] THRESHOLD_ACTIVE visible=true`

A trajectória de QA usada para atravessar o gatilho foi removida do código permanente. A base mantém a abertura da Casa Voss, a garganta exterior limpa e o Cube bloqueado até à futura integração de passagem real.

## CP-CINE-30 já iniciado

O próximo bloco avalia a ligação jogável entre a soleira e uma secção interior curta, sem mover o jogador automaticamente e sem introduzir o Cube antes de existir uma entrada física verificável.
