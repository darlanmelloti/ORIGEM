# Dev8 — Auditoria Visual Cartográfica 001

| Campo | Resultado |
|---|---|
| Estado | `OBSERVAR_SEM_PRODUCAO` |
| Rota executada | `road_to_arch` |
| Cena | Jogo normal sob Xvfb/OpenGL, com `ORIGEM_QA_OPEN_MAP=1` |
| Evidência | `road_to_arch_map.png` — viewport real 1920×1080 |
| Mutações de produção | `0` |
| Luzes, rotas, âncoras e colisores | Não alterados |

## Leitura do frame

A textura cartográfica é apresentada completa, sem corte, como um canvas 4:3 centrado sobre o mundo. A legenda, os marcos 1–12, o marcador da origem e o destino inicial permanecem legíveis. A apresentação é adequada como **mapa ilustrado de exploração**, e não tenta falsificar um relevo tridimensional no mundo.

O log prova que o harness colocou Elias na rota `road_to_arch`, mas a própria UI registou `estrada_revelada=false`. Portanto, nesta captura ela mantém o estado narrativo inicial de descoberta e exibe `CASA VOSS — ORIGEM`; não é evidência de que a conversão mundo→mapa esteja errada no jogo normal. É uma limitação de cobertura do harness: a rota QA não reproduz a consequência de timeline que revela a Estrada do Rio.

> Não promover alteração em `CartographicMapUI.gd` ou `CartographicAnchors.gd` a partir deste frame. A próxima evidência deverá usar um estado de descoberta real ou um cenário QA explícito, validado por Dev1, que preserve o comportamento normal da timeline.

## Decisão

`OBSERVAR_SEM_PRODUCAO`. A baseline está visualmente legível e a prova estática das seis âncoras passou. A continuidade Dev8 deve agora preparar a matriz de estado narrativo antes de comparar capturas das rotas seguintes. Nenhuma alteração de mapa, rota, geometria, material, câmara ou sinalização é autorizada.
