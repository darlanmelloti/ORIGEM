# HANDOFF DEV2 — R2 ESTRADA DO RIO 016

**Branch canónica:** `dev2/r2-river-road`  
**Base comum:** `integration/r1-r6-sprint1`  
**Coordenação:** Dev1  
**Data:** 25 de agosto de 2026

## Como retomar

A branch histórica `feature/dev2-r2-river-road` contém uma melhoria já absorvida por Dev1: a rota de retorno `road_return_voss`. Para evitar que 12 commits de integração sejam reconstruídos manualmente, a continuidade de Dev2 passa agora a acontecer em `dev2/r2-river-road`.

```bash
git fetch origin
git checkout dev2/r2-river-road
git pull --ff-only
```

## O que já está entregue em R2

A Estrada do Rio, o fluxo de água, o reflexo Orion e as rotas para o Arco e a ponte já estão integrados. O retorno para Casa Voss é agora um requisito validado pela porta de qualidade.

| Rota | Estado |
|---|---|
| `road_to_arch` | Aprovada |
| `positive_bridge` | Aprovada |
| `road_return_voss` | Aprovada |

## Limites de Dev2

Dev2 é dono de `levels/RiverRoadJourney.gd`, `levels/regions/R2_RiverRoad.gd`, assets especificamente colocados em R2 e checkpoints em `qa/regions/`. Não deve alterar `levels/VossHouse.gd`, `scripts/main.gd`, `entities/player/Player.gd`, `levels/CartographicAnchors.gd`, `core/timeline/TimelineManager.gd` ou o mapa cartográfico sem revisão prévia de Dev1.

## Ciclo obrigatório

Antes de abrir uma pull request, executar:

```bash
export GODOT_BIN="/caminho/para/Godot_v4.x"
tools/qa/run_regional_gate.sh R2 origin/integration/r1-r6-sprint1
```

Cada push em `dev2/r2-river-road` também aciona automaticamente a workflow GitHub **ORIGEM Regional Continuous Gate**. O próximo incremento artístico ou de gameplay deve começar apenas depois de o workflow ficar verde.
