# Dev8 — Auditoria Visual Cartográfica 1600×900

**Tarefa:** `DEV8-CARTOGRAPHIC-FIDELITY-BASELINE-001`
**Rota:** `road_to_arch`
**Modo:** mapa aberto por `ORIGEM_QA_OPEN_MAP` na cena de jogo
**Captura:** `road_to_arch_map_1600x900.png`
**Produção:** `production_mutations=0`

## Execução

A captura foi executada pela cena `scenes/main.tscn` usando Godot 4.7.1, OpenGL Compatibility e Xvfb. O snapshot foi gravado com êxito pelo harness através de `ORIGEM_QA_VIEWPORT_SNAPSHOT`; a imagem tem dimensão real **1600×900**.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 disponível | PASS |
| Xvfb disponível | PASS |
| Spawn `road_to_arch` | PASS — `(-20.05, 0.606, 22.0)` |
| Mapa aberto no viewport | PASS |
| PNG 1600×900 | PASS |
| Mutações de produção | 0 |

## Leitura visual

O mapa é legível em 1600×900: título, legenda, marcos 1–12, escala e rosa-dos-ventos mantêm contraste suficiente. O marcador do jogador permanece no ponto de origem/narrativa **Casa Voss**; a rota técnica teleporta a posição para Estrada–Arco, mas não simula a alteração de descoberta narrativa. Portanto, a captura é válida como baseline de **legibilidade e presença do mapa**, não como prova de progressão de descoberta Estrada→Arco.

## Correção de expectativa

A alegação de que `ESTRADA_RIO_INICIO` deveria devolver destino 3 foi rejeitada por execução real da autoridade `CartographicAnchors.next_dev1_destination()`. Em `z=12`, a condição `player_z < ESTRADA_RIO_INICIO.y + 8.0` é verdadeira e o destino devolvido é **2 — Estrada do Rio**. A expectativa QA permanece em 2. Não houve alteração a `CartographicAnchors.gd`, UI, rotas ou conteúdo de produção.

## Próximo passo seguro

Preservar esta evidência QA, executar parser e gate cumulativo sobre o incremento documental, e só então publicar por fast-forward quando a conectividade Git permitir. Uma captura de descoberta real requer harness autorizado pela frente narrativa/Dev1; Dev8 não deve modificar a timeline para a obter.

## Comparação de vistas

A captura `road_to_arch_map_1600x900.png` funciona como baseline de UI com estado de descoberta inicial, por isso o marcador permanece em Casa Voss. A captura `routes_1600x900/arch_to_forest.png`, obtida pela rota real Arco–Floresta, mostra Elias no mapa próximo da entrada da Floresta Densa, compatível com a telemetria `mundo=(-9.00,107.00)`, marco próximo 4 e destino `RUMO À FLORESTA`.

A leitura é legível em ambas as vistas. O contraste do marcador Elias contra a ilustração é suficiente; não há necessidade nem autorização para alterar a UI ou adicionar sinalização no mundo. A diferença de estado entre as duas imagens é atribuída ao estado narrativo do harness, não a mutação de produção.
