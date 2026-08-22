# CP-ERR-DEV5 — Relatório de correção dos erros do jogo

## Escopo

Foram investigados os quatro problemas reportados pelo utilizador: o travamento de Elias na transição entre pedra e relva, a resolução de `VossHouse.gd`, a falha de carregamento de `main.tscn` no botão **Novo Jogo** e as bermas/colisões do `TerrainPatch.gd`. O ficheiro indicado como `diretor_orientacoes/DOSSIE_ERROS_DEV5.md` não estava presente na cópia local durante a investigação; a análise foi feita com base no relato fornecido, no código versionado e no vídeo anexado.

## Correções aplicadas

| Área | Correção |
|---|---|
| Movimento de Elias | `floor_max_angle` definido em 70 graus, `floor_snap_length` em 0,35 m, `floor_stop_on_slope=false`, `floor_constant_speed=true` e `safe_margin=0,02`, evitando que uma transição navegável seja tratada como parede ou perda de contacto. |
| Terreno e bermas | A faixa de passagem foi alargada para 5,40 m antes do início da berma; a elevação passou a usar `smoothstep` e amplitudes menores, reduzindo o ressalto físico na saída da estrada para a relva. O anel de vale também recebeu transição suavizada. |
| `VossHouse.gd` | `CartographicAnchors.gd` passou a ser carregado explicitamente por `preload`, com tipagem explícita da constante `HOUSE_ORIGIN`, tornando a resolução do script determinística. |
| Menu / UID | O UID da referência de `Player.gd` em `scenes/main.tscn` foi corrigido de `uid://pbower0o7k7e` para o UID do sidecar actual, `uid://chgidfkiu6wxn`. `MainMenu.gd` passou a resolver `PackedScene` explicitamente antes de usar `change_scene_to_packed`. |

## Validação

A validação estática local passou com 19 verificações, incluindo presença das correcções, indentação dos blocos, referência UID e `git diff --check`, todos com resultado aprovado. O binário Godot 4.7/4.7.1 não estava disponível no ambiente no momento da execução; por isso, não é declarada uma validação de parser ou runtime como concluída. A análise automática do vídeo também não pôde ser executada devido a erro de permissão no serviço de análise; o vídeo permanece anexado como evidência visual fornecida pelo utilizador.

A fronteira de alterações foi mantida limitada aos cinco ficheiros funcionais afectados e ao validador técnico deste checkpoint. Não foram alterados módulos de gameplay não relacionados, assets ou configuração global do renderer.

## Estado de publicação

Este relatório acompanha o commit de correção e os respectivos SHA-256. A validação final em Godot 4.7.1 deve ser executada assim que o binário estiver disponível, incluindo importação, carregamento de `MainMenu.tscn`, clique em **Novo Jogo**, spawn do jogador e travessia pedra–relva durante pelo menos 36 segundos.

**STATUS_CODE: CP-ERR-DEV5 / STATIC_VALIDATION_PASS / GODOT_RUNTIME_PENDING / PRODUCTION_SCOPE_LIMITED.**

## Referências

[1]: `entities/player/Player.gd` — grounding e movimento do jogador.

[2]: `levels/TerrainPatch.gd` — altura analítica e malha de colisão do terreno.

[3]: `levels/VossHouse.gd` — construção da Casa Voss e soleira exterior.

[4]: `ui/menus/MainMenu.gd` e `scenes/main.tscn` — fluxo Novo Jogo e recursos da cena principal.

[5]: `/home/ubuntu/upload/21.08.2026_22.19.12_REC.mp4` — evidência visual fornecida pelo utilizador.
