# Teste — Direção Soulslike do Diretor

## Como executar

Extraia o projeto para uma pasta nova, abra `project.godot` no Godot 4.7 e execute com `F5`. Esta versão mantém o renderizador **Forward+** e a escala 3D a 75%, configurada para a GTX 1050.

## Experiência esperada

| Área | O que confirmar |
| --- | --- |
| Vale de Kheper | A paleta é menos verde e luminosa; o solo parece húmido e os relevos têm contraste de sombra. |
| Céu e bruma | O céu é azul-cinzento de crepúsculo; a bruma reduz suavemente os detalhes distantes sem ocultar os marcos. |
| Ruínas | Fendas, colunas, musgo e contactos entre pedras apresentam maior profundidade visual. |
| Stamina | A etiqueta `STAMINA` surge sob a vida. Correr, bloquear e atacar reduzem stamina; ao parar, ela recupera. |
| Ataque | O botão esquerdo consome 28 de stamina e reduz bastante o movimento por uma recuperação curta. Ataques seguidos não devem cancelar essa recuperação. |
| Bloqueio | O botão direito reduz dano, mas esgota stamina continuamente. |
| Santuário | Siga a Passagem da Nascente. O Portão da Margem é interativo: prima `E` para abrir o atalho de retorno. |
| Narrativa ambiental | Há três runas interativas no santuário; aproxime-se e prima `E` para ler os vestígios do P-0. |
| Recompensa | O Fragmento da Nascente continua no pedestal; ao usar `E`, recupera 35 pontos de vida. |

## Diagnóstico rápido

Se a imagem estiver demasiado escura, confirme que o projeto está a usar Forward+ e não o renderizador Compatibility. Se as sombras forem demasiado pesadas para o desempenho, reduza `directional_shadow_max_distance` no `levels/LevelEnvironment.gd` de `120.0` para `90.0`. Não ative névoa volumétrica global nesta configuração.

## Ficheiros principais alterados

- `levels/LevelEnvironment.gd`
- `levels/TerrainPatch.gd`
- `levels/ValleyBiome.gd`
- `levels/TempleLevel.gd`
- `levels/SanctuarySlice.gd`
- `entities/player/Player.gd`
- `scripts/main.gd`
- `_autoloads/EventBus.gd`
- `scenes/main.tscn`
- `docs/DIRETOR_SOULSLIKE_IMPLEMENTACAO.md`
