# HANDOFF R3–R6 009 — Base comum e fronteiras de equipa

**Branch canónica:** `integration/r1-r6-sprint1`  
**Commit de partida:** `29f8759`  
**Coordenação:** Dev1  
**Data:** 25 de agosto de 2026

## Estado da base comum

A rota R1 → R2 está integrada e validada em Godot 4.7.1. A Casa Voss guarda a descoberta da porta E, o mapa revela a ligação para a Estrada do Rio no evento correto e a entrega de Dev2 adiciona o fluxo de água e o primeiro reflexo Orion na estrada.

> Não altere `levels/VossHouse.gd`, `levels/RiverRoadJourney.gd`, `ui/menus/CartographicMapUI.gd`, `core/timeline/TimelineManager.gd`, `levels/CartographicAnchors.gd`, `scripts/main.gd` nem `entities/player/Player.gd` sem acordo explícito com Dev1. Esses ficheiros pertencem à integração transversal e são a superfície de conflito mais provável.

| Dev | Região | Ponto de partida | Saída técnica obrigatória | Rota QA |
|---|---|---|---|---|
| Dev3 | R3 — Arco das Ruínas | `dev3/r3-arch-ruins` | Entrada para R4 sem tapar a rota que chega de R2 | `road_to_arch`, `arch_to_forest` |
| Dev4 | R4 — Floresta Densa | `dev4/r4-dense-forest` | Clareira legível para R5 e acesso alternativo a R6 | `arch_to_forest`, `forest_to_majestic`, `forest_to_ruins` |
| Dev5 | R5 — Acampamento Majestic | `dev5/r5-majestic-camp` | Centro social/descanso que reconduz a R6 | `forest_to_majestic`, `majestic_to_lake` |
| Dev6 | R6 — Ruínas Submersas | `dev6/r6-submerged-ruins` | Chegada em ruínas e preparação visual para R7 | `forest_to_ruins`, `majestic_to_lake`, `ruins_arrival` |

## Entrega mínima por região

Cada região deve possuir um único módulo regional isolado em `levels/regions/`, uma função de construção chamada pelo orquestrador já existente, uma saída física transitável e um ficheiro de checkpoint em `qa/regions/`. A cena pode começar por malhas, assets CC0/Poly Haven já presentes e `StaticBody3D` simples; não é permitido introduzir um sistema global novo nem alterar o controlador de Elias.

| Região | Primeiro incremento obrigatório | Critério de aceite visual | Limite de luzes dinâmicas |
|---|---|---|---:|
| R3 | Arco monumental, pedras de passagem e pré-leitura da floresta | Arco reconhecível desde a estrada e corredor livre de 4 m | 2 |
| R4 | Copa densa, trilho dividido e clareira de orientação | Contraste nítido entre entrada do arco, ramo Majestic e ramo R6 | 1 |
| R5 | Fogueira, tendas, perímetro e primeiro ponto de repouso | Acampamento reconhecível sem bloquear o percurso para o lago | 4 |
| R6 | Margem inundada, passarela segura e silhueta de ruínas | Água/ruínas legíveis e transição reservada para R7 | 4 |

## Nota sobre branches legadas

As branches `feature/dev5-cartographic-world-third-person` e `feature/dev6-environment-art` antecedem a base comum e alteram múltiplos sistemas globais. Não devem ser integradas por merge direto. Dev5 e Dev6 devem transportar apenas alterações regionais pequenas para as novas branches; Dev1 fará a revisão e a integração.

## Processo de trabalho

```bash
git clone https://github.com/darlanmelloti/ORIGEM.git
cd ORIGEM
git checkout dev3/r3-arch-ruins  # substituir pela branch atribuída
git pull
```

Antes de pedir integração: executar `git diff --check`, validar o parser Godot, guardar uma nota curta em `qa/regions/`, e não enviar ficheiros `.godot/`, logs de captura ou UID gerados localmente.
