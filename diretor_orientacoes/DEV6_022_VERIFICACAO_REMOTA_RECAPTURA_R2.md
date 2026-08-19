# DEV6-022 — Verificação Remota de Recaptura R2

A verificação remota detectou o commit Dev5 `c15a4a0` — `test(dev5): regredir contrato camera elias`. O commit altera exclusivamente documentação e logs de contrato de câmara; não altera scripts de câmara, o jogador, `RiverRoadJourney.gd`, `TempleLevel.gd` nem publica uma nova evidência `road_to_arch` em terceira pessoa.

| Critério de entrada Dev6 | Estado |
|---|---:|
| Código de câmara de terceira pessoa R2 | Não publicado |
| PNG 1920×1080 de R2 em terceira pessoa | Não publicado |
| Log `road_to_arch` de 36 s com nova câmara | Não publicado |
| Contrato documental de câmara Dev5 | Encontrado; informativo |
| Revalidação DEV6-014/017 | Não iniciada por ausência de evidência válida |

A alteração Dev5 não satisfaz os critérios de recaptura DEV6. A frente Dev6 mantém o candidato R2 em `REJECTED_VISUAL` e continua com auditorias reversíveis; não deve tratar um log contratual como equivalência de gameplay real.
