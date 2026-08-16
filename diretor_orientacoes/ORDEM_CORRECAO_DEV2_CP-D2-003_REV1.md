# Ordem de Correcção Dev2 — CP-D2-003 Rev.1

**Branch exclusiva:** `feature/dev2-mountain-canyon`  
**Âmbito:** Regiões 7–12 e Takes 12–22.  
**Execução:** imediata, sem aguardar revisão intermédia.

## Resultado da auditoria cartográfica

A Vila Elevada, o Observatório e a Câmara final encontram-se próximos das coordenadas esperadas, mas `HighlandRegion.gd` ainda repete coordenadas literais e não consulta `CartographicAnchors.gd`. Isto impede que o mapa cartográfico seja a autoridade única do mundo.

Foi igualmente identificado um problema de orçamento na Vila Elevada: as luzes da vila e a estela de chegada estão dentro do ciclo de quatro pilares. Na forma actual, o construtor pode criar quatro vezes os mesmos três fachos e quatro estelas, elevando inutilmente o número de luzes visíveis.

> **Correcção obrigatória:** concluir CP-D2-003 antes de abrir qualquer nova frente. A ordem geográfica oficial é 7 Vila Elevada → 8 Observatório → 9 Trilha da Montanha → 10 Caverna → 11 Câmara → 12 Hub Temporal.

## Passo 1 — usar o registo único de âncoras

No início de `levels/HighlandRegion.gd`, adicionar:

```gdscript
const CARTOGRAPHIC_ANCHORS: Script = preload("res://levels/CartographicAnchors.gd")
```

Substituir as posições literais pelos seguintes valores:

```gdscript
var village_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.VILA_ELEVADA
var village_x: float = village_anchor.x
var village_z: float = village_anchor.y

var observatory_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.OBSERVATORIO
var ox: float = observatory_anchor.x
var oz: float = observatory_anchor.y

var trail_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.TRILHA_MONTANHA_INICIO
```

A rota de chegada deve terminar exactamente em `VILA_ELEVADA`; o construtor do Observatório deve iniciar em `OBSERVATORIO`; o primeiro segmento da Trilha deve nascer em `TRILHA_MONTANHA_INICIO`.

## Passo 2 — corrigir a repetição de luzes e estelas

Manter no ciclo `for pillar_index in range(4)` apenas a criação de pilares. Mover **para fora** desse ciclo, com uma única ocorrência:

```gdscript
var village_lights: Array[Vector3] = [
    Vector3(-8.0, 6.0, 3.0),
    Vector3(2.0, 9.0, 9.0),
    Vector3(10.0, 7.0, 15.0)
]
# criar exactamente 3 fachos
# criar exactamente 1 estela de chegada e 1 luz de estela
```

O alvo da Vila é **4 luzes dinâmicas**: três fachos de leitura urbana e uma luz da estela. Não adicionar sombras a estas luzes. Este limite preserva a margem para o Observatório, Trilha e cenário Dev1 visto à distância.

## Passo 3 — validar e continuar automaticamente

| Prova | Critério de aceitação |
|---|---|
| Arranque Godot 4.7.1 | Nenhum erro de parser ou recurso em falta. |
| Chegada Região 6→7 | Handoff em `Vector3(140, y, 352)` conduz fisicamente à Vila. |
| Gameplay Região 7–9 | Pelo menos 30 segundos; Vila, Observatório e Trilha legíveis. |
| Luzes | Contagem da Vila igual a 4. |
| Evidências | Print de chegada e print do Observatório; clipe de 30 segundos. |

Após `commit` e `push`, iniciar sem pausa o **CP-D2-004**: ancorar `CAVERNA_ORION`, `CAMARA_ORION_CUBE` e preparar a transição temporal da Câmara para `HUB_TEMPORAL`. A Região 12 não recebe estrada física a partir da Câmara.
