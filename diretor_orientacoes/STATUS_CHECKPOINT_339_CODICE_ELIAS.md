# STATUS CHECKPOINT 339 — Códice de Elias em Casa Voss

**Branch de integração:** `integration/r1-r6-sprint1`
**Responsável:** Dev1
**Âmbito:** interface narrativa R1, sem alteração de âncoras, geometria, contratos regionais ou orçamento de luzes.

## Entrega

Foi criado `ui/hud/EliasCodexUI.gd`, um painel em `CanvasLayer` aberto por **J**. O Códice mantém o jogador no mundo, mas torna o rato visível enquanto a leitura está aberta; não suspende a simulação nem introduz uma nova transição de estado global. **Esc** fecha primeiro o Códice, evitando que a pausa seja aberta no mesmo gesto.

O painel apresenta uma lista de memórias desbloqueadas, uma área de leitura e o progresso da coleção. As primeiras quatro entradas canónicas são:

| Identificador | Origem | Estado de desbloqueio |
|---|---|---|
| `tomas_letter` | Carta de Tomás | inspeção de `TomasTable` |
| `mountain_map` | Mapa da Montanha | inspeção de `MountainMap` |
| `miguel_tools` | Ferramentas de Miguel | inspeção de `MiguelTools` |
| `river_road` | Estrada do Rio | consequência temporal `road_to_orion_revealed` |

`VossHouse.gd` passou a expor `get_codex_entries()`, reutilizando o estado persistente já existente em `voss_clues_seen`. `scripts/main.gd` atualiza a UI depois de cada inspeção. Portanto, não foi introduzida uma segunda fonte de verdade, um autoload redundante ou uma nova chave de save: o `SaveManager` já guarda a Casa Voss pelo grupo `Persist` e restaura estas três descobertas de forma canónica.

## QA automatizado

Foi acrescentado o modo opcional `ORIGEM_QA_CODEX=1`. Com `ORIGEM_QA_INTERACT=voss_clues`, ele verifica a descoberta de todas as evidências e emite:

```text
[ORIGEM_CODEX_QA] unlocked=tomas_letter,mountain_map,miguel_tools selected=tomas_letter
```

Com a flag complementar `ORIGEM_QA_CODEX_SAVE=1`, o runner guarda no slot técnico 2, limpa temporariamente o estado em memória e carrega novamente o save. A prova aprovada registou:

```text
[ORIGEM_CODEX_SAVE_QA] restored=true voss_entries=3
```

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 headless | Aprovado sem `Parse Error`, `SCRIPT ERROR` ou `Compile Error` |
| Pistas R1 → Códice | Aprovado: 3/3 entradas R1 reveladas |
| Save/load de R1 | Aprovado: 3 entradas restauradas |
| Conflito Esc / pausa | Corrigido: Códice tem precedência para fechar |
| Mapa (`M`) e inventário (`Tab`) | Não foram alterados nesta entrega |
| Geografia R1→R6 e luzes | Não alteradas |

Os avisos SSR/SDFGI e FSR1 em OpenGL Compatibility/headless são esperados nesse renderizador e não constituem falhas de script.

## Próximo incremento contínuo

A próxima extensão segura é alimentar a entrada `river_road` no primeiro evento de abertura da porta e iniciar a camada R2 de documentos físicos do rio, sem alterar a leitura cartográfica Casa Voss → Estrada do Rio → Arco. Antes de criar novas memórias regionais, manter ids estáveis, conteúdo curto e fontes de desbloqueio persistentes nos controladores das respetivas regiões.
